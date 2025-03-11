-- Insert Student
CREATE OR ALTER PROCEDURE InsertStudent
    @ManagerID INT,
    @StudentName VARCHAR(255),
    @StudentAge INT,
    @StudentPhone VARCHAR(20),
    @StudentTrack INT,
    @StudentBranch INT,
    @StudentIntake INT  -- New parameter for Student Intake
AS
BEGIN    
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Check if the Track ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Track WHERE Track_ID = @StudentTrack)
    BEGIN
        PRINT 'Error: Track ID does not exist.';
        RETURN;
    END

    -- Check if the Branch ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Branch WHERE Branch_ID = @StudentBranch)
    BEGIN
        PRINT 'Error: Branch ID does not exist.';
        RETURN;
    END

    -- Check if the Intake ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Intake WHERE Intake_Id = @StudentIntake)
    BEGIN
        PRINT 'Error: Intake ID does not exist.';
        RETURN;
    END

    -- Insert new Student record
    INSERT INTO St_instr.Student (St_Name, Student_Age, Student_Phone, Manger_ID, Student_Track, Student_Branch, Student_Intake)
    VALUES (@StudentName, @StudentAge, @StudentPhone, @ManagerID, @StudentTrack, @StudentBranch, @StudentIntake);

    PRINT 'Student inserted successfully.';
END;

EXEC InsertStudent 
    @ManagerID = 5, 
    @StudentName = 'Omar', 
    @StudentAge = 25, 
    @StudentPhone = '09807694321', 
    @StudentTrack = 2, 
    @StudentBranch = 1,
    @StudentIntake = 1;


---modify
go

-- Update Student
CREATE OR ALTER PROCEDURE UpdateStudent
    @ManagerID INT,
    @OldStudentName VARCHAR(255),  -- Old Student Name for identification
    @NewStudentName VARCHAR(255),
    @NewStudentAge INT,
    @NewStudentPhone VARCHAR(20),
    @NewStudentTrack INT,
    @NewStudentBranch INT,
    @NewStudentIntake INT
AS
BEGIN    
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Check if the Track ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Track WHERE Track_ID = @NewStudentTrack)
    BEGIN
        PRINT 'Error: Track ID does not exist.';
        RETURN;
    END

    -- Check if the Branch ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Branch WHERE Branch_ID = @NewStudentBranch)
    BEGIN
        PRINT 'Error: Branch ID does not exist.';
        RETURN;
    END

    -- Check if the Intake ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Intake WHERE Intake_Id = @NewStudentIntake)
    BEGIN
        PRINT 'Error: Intake ID does not exist.';
        RETURN;
    END

    -- Check if the student with the old name exists
    IF NOT EXISTS (SELECT 1 FROM St_instr.Student WHERE St_Name = @OldStudentName)
    BEGIN
        PRINT 'Error: Student with the old name does not exist.';
        RETURN;
    END

    -- Update the student's details
    UPDATE St_instr.Student
    SET St_Name = @NewStudentName,
        Student_Age = @NewStudentAge,
        Student_Phone = @NewStudentPhone,
        Student_Track = @NewStudentTrack,
        Student_Branch = @NewStudentBranch,
        Student_Intake = @NewStudentIntake
    WHERE St_Name = @OldStudentName;

    PRINT 'Student details updated successfully.';
END;

EXEC UpdateStudent 
    @ManagerID = 3, 
    @OldStudentName = 'Omar', 
    @NewStudentName = 'Ahmed Nady', 
    @NewStudentAge = 28, 
    @NewStudentPhone = '0987684321', 
    @NewStudentTrack = 2, 
    @NewStudentBranch = 1,
    @NewStudentIntake = 2;
