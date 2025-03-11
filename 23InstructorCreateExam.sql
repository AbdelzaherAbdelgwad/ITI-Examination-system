CREATE OR ALTER PROCEDURE Exam.InsertExam
    @Ins_ID INT,
    @Course_NAME VARCHAR(255),
    @Exam_Type VARCHAR(255),
    @Exam_Deg INT,
    @BranchName VARCHAR(255)
AS
BEGIN
    DECLARE @Branch_ID INT;
    DECLARE @Course_ID INT;
    DECLARE @Latest_Intake_ID INT;
    DECLARE @Lastest_Exam_ID INT;
    DECLARE @Course_MaxDegree INT;
    DECLARE @Total_Exam_Degree INT;
    DECLARE @Track_ID INT;

    -- Retrieve IDs based on names
    SELECT @Branch_ID = Branch_Id FROM Manager.Branch WHERE LOWER(Branch_Name) = LOWER(@BranchName);
    SELECT @Course_ID = Course_Id FROM St_instr.Course WHERE Course_Name = @Course_NAME;
    SELECT @Track_ID = Track_ID FROM Manager.TrackCourse WHERE Course_Id = @Course_ID;
    SELECT TOP 1 @Lastest_Exam_ID = Exam_ID FROM Exam.Exam ORDER BY Exam_ID DESC;
    SELECT TOP 1 @Latest_Intake_ID = Intake_Id FROM Manager.Intake ORDER BY [Year] DESC;
    SELECT @Course_MaxDegree = MaxDegree FROM St_instr.Course WHERE Course_Id = @Course_ID;
    SELECT @Total_Exam_Degree = COALESCE(SUM(ExamDegree), 0) FROM Exam.Exam WHERE Course_Id = @Course_ID;

    -- Check if total exam degrees exceed course max degree
    IF (@Total_Exam_Degree + @Exam_Deg) > @Course_MaxDegree  
    BEGIN
        PRINT 'Error: Total exam degrees exceed course max degree!';
        RETURN;
    END

    -- Check if the instructor exists
    IF NOT EXISTS (SELECT 1 FROM St_instr.Instructour WHERE Ins_ID = @Ins_ID)
    BEGIN
        PRINT 'Error: Instructor not found!';
        RETURN;
    END

    -- Validate required data exists
    IF @Track_ID IS NULL
    BEGIN
        PRINT 'Error: Track not found!';
        RETURN;
    END

    IF @Branch_ID IS NULL
    BEGIN
        PRINT 'Error: Branch not found!';
        RETURN;
    END

    IF @Latest_Intake_ID IS NULL
    BEGIN
        PRINT 'Error: No Intake found!';
        RETURN;
    END

    IF @Course_ID IS NULL
    BEGIN
        PRINT 'Error: Instructor does not have a course assigned!';
        RETURN;
    END

    -- Insert new exam
    INSERT INTO Exam.Exam (Exam_ID, ExamType, ExamDegree, ExamIntake, ExamTrack, ExamBranch, Course_Id, Ins_ID)
    VALUES (@Lastest_Exam_ID + 1, @Exam_Type, @Exam_Deg, @Latest_Intake_ID, @Track_ID, @Branch_ID, @Course_ID, @Ins_ID);

    PRINT 'Exam inserted successfully!';
END;
GO

EXEC Exam.InsertExam 
    @Ins_ID = 5,
    @Course_NAME = 'Digital Marketing',
    @Exam_Type = 'Exam',
    @Exam_Deg = 50,
    @BranchName = 'Cairo Branch';
