--CREATE OR ALTER FUNCTION St_instr.GetStudentCoursesInstructors (@StudentID INT)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT 
--        S.St_Name AS StudentName,
--        C.Course_Name AS CourseName,
--        I.InstructourName AS InstructorName
--    FROM St_instr.Student S
--    JOIN St_instr.StudentCourse SC ON S.Std_Id = SC.Std_Id
--    JOIN St_instr.Course C ON SC.Course_Id = C.Course_Id
--    JOIN St_instr.Instructour I ON C.Ins_ID = I.Ins_ID
--    WHERE S.Std_Id = @StudentID
--);

--GO

--SELECT * FROM St_instr.GetStudentCoursesInstructors(2);


---- Retrieve Student Courses' Instructors
create or alter proc ViewAllCoursesWithInstractors(@std_id int)
as
begin
	select Course_Name as 'Course Name' , ins.InstructourName 'Instructor Name' 
	from St_instr.Instructour ins 
	join St_instr.Course c on c.Ins_ID = ins.Ins_ID
	join St_instr.StudentCourse stdc on stdc.Course_Id = c.Course_Id
	where stdc.Std_Id = @std_id
end
exec ViewAllCoursesWithInstractors 5;


