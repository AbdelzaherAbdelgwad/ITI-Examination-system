--CREATE OR ALTER FUNCTION St_instr.GetInstructorCourseStudents (@InstructorID INT)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT 
--        I.InstructourName,
--        C.Course_Name,
--        S.St_Name AS StudentName,
--        SE.Score
--    FROM St_instr.Instructour I
--    JOIN St_instr.Course C ON I.Ins_ID = C.Ins_ID
--    JOIN Exam.Exam E ON C.Course_Id = E.Course_Id
--    JOIN Exam.StudentExam SE ON SE.Exam_ID = E.Exam_ID
--    JOIN St_instr.Student S ON SE.Std_Id = S.Std_Id
--    WHERE I.Ins_ID = @InstructorID
--);

--GO

--SELECT * FROM St_instr.GetInstructorCourseStudents(2);


create or alter procedure ViewResultsOfAllStudents(@ins_id int)
as
begin 
   select st.St_name as 'student Name',c.Course_Name as 'Course Name',ExamDegree as 'Exam degree', score as 'Student Score' 
   from St_instr.Student st
   join Exam.StudentExam se on st.Std_Id = se.Std_Id
   join Exam.Exam ex on ex.Exam_ID = se.Exam_ID
   join St_instr.Course c on c.Course_Id = ex.Course_Id
   where ex.Ins_ID = @ins_id
end

exec ViewResultsOfAllStudents 1;
