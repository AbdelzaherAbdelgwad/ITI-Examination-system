-- Retrieve Student Degrees in All Courses
CREATE OR ALTER FUNCTION St_instr.GetStudentExamResults (@StudentID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        S.St_Name AS StudentName,
        C.Course_Name AS CourseName,
        E.ExamType,
        E.ExamDegree
    FROM Exam.StudentExam SE
    JOIN Exam.Exam E ON SE.Exam_ID = E.Exam_ID
    JOIN St_instr.Course C ON E.Course_Id = C.Course_Id
    JOIN St_instr.Student S ON SE.Std_Id = S.Std_Id
    WHERE SE.Std_Id = @StudentID
);

GO

SELECT * FROM St_instr.GetStudentExamResults(2);
