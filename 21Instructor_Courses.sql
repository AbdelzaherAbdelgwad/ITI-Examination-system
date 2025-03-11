CREATE OR ALTER FUNCTION St_instr.GetInstructorCourses (@InstructorID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT I.InstructourName, C.Course_Name, C.CourseDescription
    FROM St_instr.Course C
    JOIN St_instr.Instructour I ON C.Ins_ID = I.Ins_ID
    WHERE I.Ins_ID = @InstructorID
);

GO

SELECT * FROM St_instr.GetInstructorCourses(2);


GO
create or alter proc ViewAllCourses(@ins_name varchar(255))
as
begin
 IF EXISTS (
        SELECT 1 FROM St_instr.Course c
        JOIN St_instr.Instructour ins ON ins.Ins_ID = c.Ins_ID
        WHERE ins.InstructourName = @ins_name
    )
	select c.Course_Name as 'Course Name' from St_instr.Course c
	join St_instr.Instructour ins on ins.Ins_ID = c.Ins_ID
	where ins.InstructourName = @ins_name
 else
	select 'this instractor doesnt teach any courses'
end
exec ViewAllCourses 'Dr. Ayman'

