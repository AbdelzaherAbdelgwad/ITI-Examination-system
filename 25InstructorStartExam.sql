-- Create exam (not corrective)
CREATE OR ALTER PROCEDURE St_instr.StartFinalExam
	@Instructor_ID INT,
    @Course_Name VARCHAR(255),
    @Start_Time DATETIME,
    @End_Time DATETIME,
    @BranchName VARCHAR(255),
    @TrackName VARCHAR(255),
    @ExamId INT,
    @ExamType VARCHAR(255),
    @NumberOfQuestions INT
AS
BEGIN
    SET NOCOUNT ON;  -- Prevents extra messages for performance

    DECLARE @Branch_ID INT;
    DECLARE @Track_ID INT;
    DECLARE @Course_ID INT;
    DECLARE @Exam_Degree INT;
    DECLARE @SUM_OF_QUESTION_DEG INT = 0;
    DECLARE @Existing_ExamType VARCHAR(255);
    DECLARE @Available_Exam_IDs VARCHAR(MAX);

    -- Table Variable for Student IDs (Prevents VARCHAR Overflow)
    DECLARE @Student_IDS TABLE (Std_Id INT);

    -- Transaction Start
    BEGIN TRANSACTION;
    BEGIN TRY
		-- Validate that the Start Time is not in the past

		IF @Start_Time < GETDATE()
		BEGIN
			RAISERROR ('Error: Start time cannot be in the past!', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
		-- Validate that the End Time is after the Start Time
		IF @End_Time <= @Start_Time
		BEGIN
			RAISERROR ('Error: End time must be after the start time!', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
        -- Fetch Course ID
        SELECT TOP 1 @Course_ID = Course_Id FROM St_instr.Course WHERE LOWER(Course_Name) = LOWER(@Course_Name);
        IF @Course_ID IS NULL
        BEGIN
            RAISERROR ('Error: Invalid Course Name!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Fetch Branch and Track ID
        SELECT @Branch_ID = Branch_Id FROM Manager.Branch WHERE LOWER(Branch_Name) = LOWER(@BranchName);
        SELECT @Track_ID = Track_ID FROM Manager.Track WHERE LOWER(Track_Name) = LOWER(@TrackName);
        IF @Branch_ID IS NULL OR @Track_ID IS NULL
        BEGIN
            RAISERROR ('Error: Invalid Branch or Track Name!',16,1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validate Exam Type
        SELECT @Existing_ExamType = ExamType FROM Exam.Exam WHERE Exam_ID = @ExamId AND Course_Id = @Course_ID;
        IF LOWER(@Existing_ExamType) != LOWER(@ExamType)
        BEGIN
            RAISERROR ('Error: Provided Exam_ID does not have the same ExamType!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Fetch Instructor ID
        IF NOT EXISTS (SELECT 1 FROM St_instr.Course WHERE Ins_ID = @Instructor_ID)
        BEGIN
            RAISERROR ('Error: No instructor found for this course!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check Exam Exists
        IF NOT EXISTS (SELECT 1 FROM Exam.Exam WHERE Exam_ID = @ExamId AND Course_Id = @Course_ID)
        BEGIN
            SELECT @Available_Exam_IDs = STRING_AGG(CAST(Exam_ID AS VARCHAR), ', ')
            FROM Exam.Exam WHERE Course_Id = @Course_ID;

            IF @Available_Exam_IDs IS NULL
                RAISERROR ('Error: No exams available for this course!', 16, 1);
            ELSE
                RAISERROR ('Error: Provided Exam_ID does not match this Course_ID. Available Exam IDs: %s', 16, 1, @Available_Exam_IDs);

            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Fetch Exam Degree
        SELECT @Exam_Degree = ExamDegree FROM Exam.Exam WHERE Exam_ID = @ExamId;

        -- Store Selected Questions
        DECLARE @SelectedQuestions TABLE (QuestionText VARCHAR(MAX), Degree INT);

        INSERT INTO @SelectedQuestions (QuestionText, Degree)
        SELECT TOP (@NumberOfQuestions) Q.QuestionText, E.Degree
        FROM Exam.ExamQuestion E
        JOIN Exam.QuestionPool Q ON E.Question_ID = Q.Question_ID
        WHERE E.Exam_ID = @ExamId
        ORDER BY NEWID();

        -- Validate Sum of Question Degrees
        SELECT @SUM_OF_QUESTION_DEG = SUM(Degree) FROM @SelectedQuestions;
        IF @SUM_OF_QUESTION_DEG IS NULL OR @SUM_OF_QUESTION_DEG != @Exam_Degree
        BEGIN
            RAISERROR ('ERROR: Total degrees of selected questions (%d) does NOT match the Exam degree (%d)!', 16, 1, @SUM_OF_QUESTION_DEG, @Exam_Degree);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert Student IDs into Table Variable
		IF @ExamType = 'Corrective'
		BEGIN
			INSERT INTO @Student_IDS (Std_Id)
			SELECT DISTINCT SE.Std_Id
			FROM St_instr.Student S, Exam.StudentExam SE 
			WHERE SE.Score < 50 AND SE.Exam_ID IN (SELECT Exam_ID FROM Exam.Exam WHERE Course_Id = @Course_ID);

			IF NOT EXISTS (SELECT 1 FROM @Student_IDS)
			BEGIN
				ROLLBACK TRANSACTION;
				RAISERROR ('NO STUDENTS HAVE CORRECTIVE', 16, 1);
				RETURN;
			END
		END
		ELSE
		BEGIN
			INSERT INTO @Student_IDS (Std_Id)
			SELECT Std_Id FROM St_instr.StudentCourse WHERE Course_ID = @Course_ID;
		END

        -- Ensure There Are Students
        IF NOT EXISTS (SELECT 1 FROM @Student_IDS)
        BEGIN
            RAISERROR ('Error: No students found for this course!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT QuestionText, Degree FROM @SelectedQuestions;
		 -- Ensure Exam is Not Already Assigned
        UPDATE Exam.Exam
		SET ExamStartTime = @Start_Time, ExamEndTime = @End_Time
		WHERE Exam_ID = @ExamId;
		PRINT 'Final exam started successfully with Exam ID: ' + CAST(@ExamId AS VARCHAR);

		IF EXISTS (SELECT 1 FROM St_instr.InstructourExam WHERE Exam_ID = @ExamId AND Ins_ID = @Instructor_ID)
        BEGIN
            PRINT (' Exam already exists!');
            ROLLBACK TRANSACTION;
            RETURN;
        END
		ELSE
		BEGIN
			-- Assign Exam to Instructor with Student IDs
			INSERT INTO St_instr.InstructourExam (Ins_ID, Exam_ID, Student_IDS, NumberOfQuestion)
			SELECT @Instructor_ID, @ExamId, STRING_AGG(CAST(Std_Id AS VARCHAR), ', '), @NumberOfQuestions
			FROM @Student_IDS;
			COMMIT TRANSACTION;
		END
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

GO
EXEC St_instr.StartFinalExam 
    @Course_Name = 'Digital Marketing',
	@Instructor_ID = 5,
    @Start_Time = '2025-02-17 10:00:00',
    @End_Time = '2025-02-18 12:00:00',
    @BranchName = 'Cairo Branch',
    @TrackName = 'Software Engineering',
    @ExamId = 5, 
    @ExamType = 'Corrective',
    @NumberOfQuestions = 5;
