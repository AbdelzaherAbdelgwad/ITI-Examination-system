CREATE OR ALTER TRIGGER PreventDeleteIntake
ON Manager.Intake
INSTEAD OF DELETE
AS
BEGIN
        PRINT 'You can not delete from intake';
END;

DELETE FROM Manager.Intake WHERE Intake_Id = 1;

GO

CREATE OR ALTER TRIGGER PreventDeleteBranch
ON Manager.Branch
INSTEAD OF DELETE
AS
BEGIN
        PRINT 'You can not delete from branch';
END;

DELETE FROM Manager.Branch WHERE Branch_Id = 1;

GO

CREATE OR ALTER TRIGGER PreventDeleteTrack
ON Manager.Track
INSTEAD OF DELETE
AS
BEGIN
        PRINT 'You can not delete from track';
END;

DELETE FROM Manager.Track WHERE Track_ID = 1;

GO

CREATE OR ALTER TRIGGER AfterInsertIntake
ON Manager.Intake
AFTER INSERT
AS
BEGIN
    PRINT 'Intake Inserted successfully from trigger';
END;

GO

CREATE OR ALTER TRIGGER AfterInsertBranch
ON Manager.Branch
AFTER INSERT
AS
BEGIN
    PRINT 'Branch Inserted successfully from trigger';
END;

GO

CREATE OR ALTER TRIGGER AfterInsertTrack
ON Manager.Track
AFTER INSERT
AS
BEGIN
    PRINT 'Track Inserted successfully from trigger';
END;

GO


-- CREATE AN EXAM
GO

CREATE OR ALTER TRIGGER TRG_INSERTEXAM
ON Exam.Exam
AFTER INSERT 
AS
BEGIN
	SELECT * FROM inserted;
END;
------------------------
-- START AN EXAM
GO
CREATE OR ALTER TRIGGER TRG_STARTEXAM_STD_IDS
ON St_instr.InstructourExam
AFTER INSERT 
AS
BEGIN
	SELECT * FROM inserted;
END;
-----------------------
GO
CREATE OR ALTER TRIGGER TRG_INSERTEXAM_UPDATE_DATE
ON Exam.Exam
AFTER UPDATE 
AS
BEGIN
	SELECT ExamStartTime 'UPDATED START TIME', ExamEndTime 'UPDATED END TIME' FROM inserted;
END;


--------------------------------------------------------------------------

GO
create table AuditStudentTable
(
	AuditID int primary key identity,
	stdID int,
	inserted_by varchar(255),
	inserted_at DATETIME
)

GO
-- Create or alter the AuditStudent trigger
-- Create or alter the trigger to capture insert events
CREATE OR ALTER TRIGGER AuditStudent
ON St_instr.Student
AFTER INSERT
AS
BEGIN
    -- Insert audit information into the AuditStudentTable
    INSERT INTO AuditStudentTable (stdID, inserted_by, inserted_at)
    SELECT 
        i.Std_Id, 
        m.Man_Name, 
        SYSDATETIME() 
    FROM inserted i
    LEFT JOIN Manager.Manger m ON i.Manger_ID = m.Manger_ID;
	PRINT 'Student Inserted successfully from trigger';
END;


INSERT INTO St_instr.Student (St_Name, Student_Age, Student_Phone, Manger_ID, Student_Intake, Student_Track, Student_Branch)
VALUES
('Mariam', 21, '0190000000', 1, 1, 1, 1)

-- Check the contents of the AuditStudentTable to see the audit logs
SELECT * FROM AuditStudentTable;



