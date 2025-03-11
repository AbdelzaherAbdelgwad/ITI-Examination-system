-- Show the available questions and their IDs
CREATE OR ALTER VIEW St_instr.InstructorQuestions AS
SELECT 
    Question_ID AS Q_ID, 
    QuestionText AS Q_Name
FROM Exam.QuestionPool;

GO
SELECT * FROM St_instr.InstructorQuestions;

---------------------------------
-- Assign questions to an exam
GO
CREATE OR ALTER PROCEDURE St_instr.AddExamQuestions 
(
    @Ins_ID INT,
    @Exam_ID INT,
    @Q_IDs NVARCHAR(MAX),  -- Comma-separated question IDs (e.g., '1,2,3')
    @Q_Degrees NVARCHAR(MAX) = NULL -- Comma-separated degrees (e.g., '5,10,15')
)
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @ActualIns_ID INT;
    DECLARE @TotalExamDegree INT;
    DECLARE @TotalQuestionsDegree INT = 0;
    DECLARE @Question_ID INT;
    DECLARE @Degree INT;
    DECLARE @Index INT = 1;
    DECLARE @QuestionsTable TABLE (Q_ID INT, Q_Degree INT);

    -- Step 1: Check if the instructor is assigned to this exam
    SELECT @ActualIns_ID = Ins_ID, @TotalExamDegree = Exam.ExamDegree 
    FROM Exam.Exam 
    WHERE Exam_ID = @Exam_ID;

    IF @ActualIns_ID IS NULL
    BEGIN
        PRINT 'Error: Exam ID does not exist.';
        RETURN;
    END

    IF @ActualIns_ID <> @Ins_ID
    BEGIN
        PRINT 'Error: Instructor is not assigned to this exam.';
        RETURN;
    END

    -- Step 2: Parse the question IDs and degrees into a table
	IF @Q_Degrees IS  NULL 
	BEGIN
		INSERT INTO @QuestionsTable
		SELECT Question_ID, InstructourDegree 
		FROM Exam.QuestionPool 
		WHERE Question_ID IN (SELECT value FROM STRING_SPLIT(@Q_IDs, ','));
	END
	ELSE
	BEGIN
		WHILE CHARINDEX(',', @Q_IDs) > 0
		BEGIN
			SET @Question_ID = CAST(LEFT(@Q_IDs, CHARINDEX(',', @Q_IDs) - 1) AS INT);
			SET @Degree = CAST(LEFT(@Q_Degrees, CHARINDEX(',', @Q_Degrees) - 1) AS INT);

			INSERT INTO @QuestionsTable VALUES (@Question_ID, @Degree);

			-- Remove the inserted question and degree from the string
			SET @Q_IDs = STUFF(@Q_IDs, 1, CHARINDEX(',', @Q_IDs), '');
			SET @Q_Degrees = STUFF(@Q_Degrees, 1, CHARINDEX(',', @Q_Degrees), '');
		END
    -- Insert the last remaining value
    INSERT INTO @QuestionsTable VALUES (CAST(@Q_IDs AS INT), CAST(@Q_Degrees AS INT));
	END

    -- Step 3: Calculate the total degree of questions
    SELECT @TotalQuestionsDegree = SUM(Q_Degree) FROM @QuestionsTable;

    -- Step 4: Check if total degrees match the exam's total degree
    IF @TotalQuestionsDegree <> @TotalExamDegree
    BEGIN
        PRINT 'Error: Total question degrees do not match the exam degree.';
        RETURN;
    END

    -- Step 5: Insert questions into Exam.ExamQuestion table
	BEGIN TRY
		BEGIN TRANSACTION;  -- Start transaction

		INSERT INTO Exam.ExamQuestion (Question_ID, Exam_ID, Degree)
		SELECT Q_ID, @Exam_ID, Q_Degree FROM @QuestionsTable;

		COMMIT TRANSACTION;  -- Commit only if successful

		PRINT 'Questions successfully added to the exam.';
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;  -- Rollback if an error occurs
		PRINT ('ERROR: SOME OF THESES QUESTIONS ALREADY EXIST FOR THAT EXAM');
		RETURN;
	END CATCH;
END;
----

GO
EXEC St_instr.AddExamQuestions 
    @Ins_ID = 5, 
    @Exam_ID = 13, 
    @Q_IDs = '1,2,3,4,5',
	@Q_Degrees = '10,10,10,10,10';

-----------------
-- Show all questions for an instructor's exam
GO
CREATE OR ALTER FUNCTION St_instr.GetExamQuestionsForInstructor 
(
    @Ins_ID INT,
    @Exam_ID INT
)
RETURNS TABLE
AS
RETURN 
(
    -- Check if the instructor is assigned to the exam
    SELECT EQ.Question_ID, QP.QuestionText, EQ.Degree
    FROM Exam.ExamQuestion EQ
    JOIN Exam.QuestionPool QP ON EQ.Question_ID = QP.Question_ID
    WHERE EQ.Exam_ID = @Exam_ID
    AND EXISTS 
    (
        SELECT 1 FROM Exam.Exam 
        WHERE Exam_ID = @Exam_ID 
        AND Ins_ID = @Ins_ID
    )
);
-- Function usage example
GO
SELECT * FROM St_instr.GetExamQuestionsForInstructor(2, 12);
