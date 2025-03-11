
CREATE SCHEMA Manager;
go
CREATE SCHEMA St_instr
go
CREATE SCHEMA Exam
go

-- Manager schema
ALTER SCHEMA Manager TRANSFER dbo.Manger
ALTER SCHEMA Manager TRANSFER dbo.Branch
ALTER SCHEMA Manager TRANSFER dbo.BranchDepartment
ALTER SCHEMA Manager TRANSFER dbo.Department
ALTER SCHEMA Manager TRANSFER dbo.Intake
ALTER SCHEMA Manager TRANSFER dbo.IntakeBranch
ALTER SCHEMA Manager TRANSFER dbo.Track
ALTER SCHEMA Manager TRANSFER dbo.TrackCourse

-- Exam schema

ALTER SCHEMA Exam TRANSFER dbo.Exam
ALTER SCHEMA Exam TRANSFER dbo.QuestionPool
ALTER SCHEMA Exam TRANSFER dbo.ExamQuestion
ALTER SCHEMA Exam TRANSFER dbo.StudentExam

-- Student_instructor  St_instr

ALTER SCHEMA St_instr TRANSFER dbo.Student
ALTER SCHEMA St_instr TRANSFER dbo.StudentCourse
ALTER SCHEMA St_instr TRANSFER dbo.Course
ALTER SCHEMA St_instr TRANSFER dbo.Instructour
ALTER SCHEMA St_instr TRANSFER dbo.InstructourExam


-- For manager user
	-- Create manager user
CREATE LOGIN Manager
WITH PASSWORD = '123';

CREATE USER ManagerUser FOR LOGIN Manager

-- Manager full access on manager schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Manager TO ManagerUser;

-- Full Access on Student Table in Student Schema
GRANT SELECT, INSERT, UPDATE, DELETE ON St_instr.Student TO ManagerUser;

-- SELECT on All Other Tables & Schemas
GRANT SELECT ON SCHEMA :: St_instr TO ManagerUser
GRANT SELECT ON SCHEMA :: Exam TO ManagerUser


-- For instructor user
	-- Create instructor user
CREATE LOGIN Instructor
WITH PASSWORD = '123';


CREATE USER InsUser FOR LOGIN Instructor;

-- Full Access on Exam Schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Exam TO InsUser;

-- Full Access on student Schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::St_instr TO InsUser;

-- For student user
CREATE LOGIN Student 
WITH PASSWORD = '123';

CREATE USER StudentUser FOR LOGIN Student;



-- If these are views or tables instead of functions or procedures
GRANT SELECT ON dbo.GetStudentExamResults TO StudentUser;
GRANT SELECT ON dbo.GetStudentCoursesInstructors TO StudentUser;
GRANT EXECUTE ON dbo.SubmitExam TO StudentUser;




drop user StudentUser
drop login Student


