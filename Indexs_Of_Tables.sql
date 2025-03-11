CREATE INDEX idx_Intake_Manger 
ON Manager.Intake (Manger_ID);

CREATE INDEX idx_Branch 
ON Manager.Branch (Manger_ID, Branch_Name);

CREATE INDEX idx_Department_Branch 
ON Manager.Department (Branch_Id);

CREATE INDEX idx_BranchDept 
ON Manager.BranchDepartment (Branch_Id, Dept_ID);

CREATE INDEX idx_IntakeBranch
ON Manager.IntakeBranch (Intake_Id, Branch_Id);

CREATE INDEX idx_Track_Dept 
ON Manager.Track (Dept_ID);

CREATE INDEX idx_Track_Manger 
ON Manager.Track (Manger_ID);

CREATE INDEX idx_Student
ON St_instr.Student (Manger_ID, Student_Intake, Student_Track, Student_Branch);

CREATE INDEX idx_Course_Ins 
ON St_instr.Course (Ins_ID);

CREATE INDEX idx_StudentCourse_Student 
ON St_instr.StudentCourse (Std_Id);

CREATE INDEX idx_StudentCourse_Course 
ON St_instr.StudentCourse (Course_Id);

CREATE INDEX idx_TrackCourse
ON Manager.TrackCourse (Course_Id, Track_ID);

CREATE INDEX idx_Exam
ON Exam.Exam (Course_Id, Ins_ID);

CREATE INDEX idx_InstructourExam_Ins 
ON St_instr.InstructourExam (Ins_ID);

CREATE INDEX idx_InstructourExam_Exam 
ON St_instr.InstructourExam (Exam_ID);

CREATE INDEX idx_StudentExam_Student 
ON Exam.StudentExam (Std_Id);

CREATE INDEX idx_StudentExam_Exam 
ON Exam.StudentExam (Exam_ID);

CREATE INDEX idx_QuestionPool_Ins 
ON Exam.QuestionPool (Ins_ID);

CREATE INDEX idx_ExamQuestion_Question 
ON Exam.ExamQuestion (Question_ID);

CREATE INDEX idx_ExamQuestion_Exam 
ON Exam.ExamQuestion (Exam_ID);