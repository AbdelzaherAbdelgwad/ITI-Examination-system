CREATE OR ALTER PROCEDURE SubmitExam
    @StudentID INT,
    @ExamID INT,
    @StudentAnswers NVARCHAR(MAX)  -- Expected JSON format: [{"QuestionID":1, "Answer":"A"}]
AS
BEGIN    
    DECLARE @TotalScore INT = 0;
    
    -- Check if the Student ID exists
    IF NOT EXISTS (SELECT 1 FROM St_instr.Student WHERE Std_Id = @StudentID)
    BEGIN
        PRINT 'Error: Student ID does not exist.';
        RETURN;
    END

    -- Check if the Exam ID exists
    IF NOT EXISTS (SELECT 1 FROM Exam.Exam WHERE Exam_ID = @ExamID)
    BEGIN
        PRINT 'Error: Exam ID does not exist.';
        RETURN;
    END

    -- Temporary table to hold student answers from JSON input
    CREATE TABLE #StudentAnswers 
	(
        QuestionID INT,
        Answer NVARCHAR(MAX)
    );

    -- Parse JSON input into table
    INSERT INTO #StudentAnswers (QuestionID, Answer)
    SELECT QuestionID, Answer
    FROM OPENJSON(@StudentAnswers)
    WITH (
        QuestionID INT '$.QuestionID',
        Answer NVARCHAR(MAX) '$.Answer'
    );

	-- Calculate score based on question type
    SELECT @TotalScore = SUM(
        CASE 
            -- Case 1: True/False (TF) or Multiple Choice (MCQ)
            WHEN QP.QuestionType IN ('TF', 'MCQ') AND SA.Answer = QP.CorrectAnswer 
                THEN EQ.Degree

            -- Case 2: Text-based answers (Compare with BestAnswer)
            WHEN QP.QuestionType = 'Text' AND SA.Answer LIKE '%' + QP.BestAnswer + '%'
                THEN EQ.Degree 

            ELSE 0  -- No score for incorrect answers
        END
    )
    FROM #StudentAnswers SA
    JOIN Exam.ExamQuestion EQ ON SA.QuestionID = EQ.Question_ID AND EQ.Exam_ID = @ExamID
    JOIN Exam.QuestionPool QP ON SA.QuestionID = QP.Question_ID;

    -- Update StudentExam with the submitted answers and calculated score
	IF NOT exists (select 1 from Exam.StudentExam where Exam_id = @ExamID and Std_Id = @StudentID)
	BEGIN
		INSERT INTO Exam.StudentExam 
		VALUES
		(
			@StudentID,@ExamID,@StudentAnswers,@TotalScore
		)
	END
	ELSE
	BEGIN
		UPDATE Exam.StudentExam
		SET Answer = @StudentAnswers,  -- Store raw JSON input
			Score = @TotalScore
		WHERE Std_Id = @StudentID AND Exam_ID = @ExamID;
	END
    PRINT 'Exam submitted successfully. Student Score: ' + CAST(@TotalScore AS VARCHAR);

    -- Clean up temporary table
    DROP TABLE #StudentAnswers;
END;

----------------------------------------------
EXEC SubmitExam 
    @StudentID = 9, 
    @ExamID = 13, 
    @StudentAnswers = '[{"QuestionID":1, "Answer":"B"}, {"QuestionID":2, "Answer":"B"}, {"QuestionID":3, "Answer":"C"}, {"QuestionID":4, "Answer":"It is process to speed search methods"}, {"QuestionID":5, "Answer":"A"}]';

