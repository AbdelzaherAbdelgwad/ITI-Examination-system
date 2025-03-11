-- Retrieve All Students and their Courses
CREATE OR ALTER VIEW Manager.AllStudentsCourses AS
SELECT 
    S.St_Name AS StudentName,
    C.Course_Name AS CourseName
FROM St_instr.Student S
JOIN St_instr.StudentCourse SC ON S.Std_Id = SC.Std_Id
JOIN St_instr.Course C ON SC.Course_Id = C.Course_Id;

GO

SELECT * FROM Manager.AllStudentsCourses;

-------------------------------------------------------------

GO
-- Retrieve All Instructors and their Courses
CREATE OR ALTER VIEW Manager.AllCoursesInstructors AS
SELECT 
    C.Course_Name AS CourseName,
    I.InstructourName AS InstructorName
FROM St_instr.Course C
JOIN St_instr.Instructour I ON C.Ins_ID = I.Ins_ID;

GO

SELECT * FROM Manager.AllCoursesInstructors;

-------------------------------

GO
-- Retrieve All Managers and their Branches
CREATE OR ALTER VIEW Manager.AllManagersBranches AS
SELECT 
    M.Man_Name AS ManagerName,
    B.Branch_Name AS BranchName
FROM Manager.Manger M
JOIN Manager.Branch B ON M.Manger_ID = B.Manger_ID;

GO

SELECT * FROM Manager.AllManagersBranches;

-------------------------------

-- View: All Tracks and Their Departments
GO
CREATE OR ALTER VIEW Manager.AllTracksDepartments AS
SELECT 
    T.Track_Name AS TrackName,
    D.Dept_Name AS DepartmentName
FROM Manager.Track T
JOIN Manager.Department D ON T.Dept_ID = D.Dept_ID;

GO

SELECT * FROM Manager.AllTracksDepartments;

-------------------

-- All Students and Their Managers
GO
CREATE OR ALTER VIEW Manager.AllStudentsManagers AS
SELECT 
    S.St_Name AS StudentName,
    M.Man_Name AS ManagerName
FROM St_instr.Student S
JOIN Manager.Manger M ON S.Manger_ID = M.Manger_ID;

GO

SELECT * FROM Manager.AllStudentsManagers;

-----------------------------------------------------

GO

CREATE OR ALTER VIEW Manager.AllStudentsManagersTracks AS
SELECT 
    M.Man_Name AS ManagerName,
    T.Track_Name AS TrackName,
    b.Branch_Name AS BranchName,
    d.Dept_Name AS Department,
    I.InstructourName AS InstructorName,
    S.St_Name AS StudentName,
    C.Course_Name AS CourseName
FROM St_instr.Student S
JOIN Manager.Manger M ON S.Manger_ID = M.Manger_ID
JOIN St_instr.StudentCourse SC ON S.Std_Id = SC.Std_Id
JOIN St_instr.Course C ON SC.Course_ID = C.Course_ID
JOIN St_instr.Instructour I ON C.Ins_ID = I.Ins_ID
JOIN Manager.Track T ON M.Manger_ID = T.Manger_ID
JOIN Manager.Branch b ON b.Manger_ID = M.Manger_ID
JOIN Manager.BranchDepartment bd ON bd.Branch_Id = b.Branch_Id
JOIN Manager.Department d ON d.Branch_Id = b.Branch_Id;

GO

SELECT * FROM Manager.AllStudentsManagersTracks;
