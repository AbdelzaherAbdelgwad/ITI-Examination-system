CREATE OR ALTER PROCEDURE St_instr.InsertQuestion
    @InstructorID INT,
    @CorrectAnswer VARCHAR(255),
    @BestAnswer VARCHAR(255),
    @QuestionText TEXT,
    @QuestionType VARCHAR(255),
    @InstructorDefaultDegree INT
AS
BEGIN
    -- Check if the Instructor ID exists
    IF NOT EXISTS (SELECT 1 FROM St_instr.Instructour WHERE Ins_ID = @InstructorID)
    BEGIN
        PRINT 'Error: Instructor ID does not exist.';
        RETURN;
    END

    -- Insert the new question into the QuestionPool
    INSERT INTO Exam.QuestionPool (CorrectAnswer, BestAnswer, QuestionText, QuestionType, Ins_ID, InstructourDegree)
    VALUES (@CorrectAnswer, @BestAnswer, @QuestionText, @QuestionType, @InstructorID, @InstructorDefaultDegree);

    PRINT 'Question inserted successfully into the QuestionPool.';
END;

GO

EXEC St_instr.InsertQuestion 
    @InstructorID = 8, 
    @CorrectAnswer = 'C',
    @BestAnswer = 'Null',
    @QuestionText = 'What is a Database? A) Wrong Answer B) Wrong Answer C) Set of tables',
    @QuestionType = 'MCQ',
    @InstructorDefaultDegree = 5;
