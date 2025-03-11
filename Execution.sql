-- Manager insert intake 
EXEC InsertIntake @ManagerID = 6;

-- Manager edit intake
exec EditIntake @IntakeID = 16 , @NewManagerID = 4;

-- Manager insert branch 
EXEC InsertBranch @ManagerID = 5, @BranchName = 'Minia';

-- Manager edit branch
EXEC EditBranch @OldName = 'Minia', @NewBranchName = 'NewMinia', @ManagerID = 5;

-- Manager insert track
EXEC InsertTrack @ManagerID = 3, @TrackName = 'Programming PS', @DeptID = 3;

-- Manager edit track
EXEC UpdateTrack 
    @ManagerID = 3, 
    @OldTrackName = 'Programming PS', 
    @NewTrackName = 'Programming problem solving', 
    @NewDeptID = 2;

-- Manager add student
EXEC InsertStudent 
    @ManagerID = 5, 
    @StudentName = 'Mariam Younis', 
    @StudentAge = 24, 
    @StudentPhone = '0369852147', 
    @StudentTrack = 2, 
    @StudentBranch = 1,
    @StudentIntake = 1;

-- Manager edit student
EXEC UpdateStudent 
    @ManagerID = 5, 
    @OldStudentName = 'Mariam Younis', 
    @NewStudentName = 'Ahmed Nady', 
    @NewStudentAge = 25, 
    @NewStudentPhone = '0987644321', 
    @NewStudentTrack = 2, 
    @NewStudentBranch = 1,
    @NewStudentIntake = 1;

-- Manager report about all students and their courses
SELECT * FROM Manager.AllStudentsCourses;

-- Manager report all instructors and their courses
SELECT * FROM Manager.AllCoursesInstructors;

-- Manager report all managers and their branches
SELECT * FROM Manager.AllManagersBranches;

-- Manager report all tracks and Their departments
SELECT * FROM Manager.AllTracksDepartments;

-- Manager report all students and Their managers
SELECT * FROM Manager.AllStudentsManagers;

-- Manager report all Information
SELECT * FROM Manager.AllStudentsManagersTracks;

-- Instructor add question in question pool
EXEC St_instr.InsertQuestion 
    @InstructorID = 9, 
    @CorrectAnswer = 'A',
    @BestAnswer = 'Null',
    @QuestionText = 'What is SQL? A) True Answer  B) Wrong Answer C) Wrong Answer',
    @QuestionType = 'MCQ',
    @InstructorDefaultDegree = 5;

-- Instructor report all his courses with his id
SELECT * FROM St_instr.GetInstructorCourses(2);

-- Instructor report all his courses with his name
exec ViewAllCourses 'Dr. Ayman'

-- Instructor report all his courses and his students in this courses and their score
exec ViewResultsOfAllStudents 1;

-- Instructor create exam
EXEC Exam.InsertExam 
    @Ins_ID = 4,
    @Course_NAME = 'Finance Basics',
    @Exam_Type = 'Exam',
    @Exam_Deg = 50,
    @BranchName = 'Mansoura Branch';

-- Instructor see all questions inside question pool
SELECT * FROM St_instr.InstructorQuestions;

-- Instructor assign questions to the exam
EXEC St_instr.AddExamQuestions 
    @Ins_ID = 4, 
    @Exam_ID = 14, 
    @Q_IDs = '1,2,3,4,5',
	@Q_Degrees = '10,10,10,10,10';

-- Instructor see the exam's questions
SELECT * FROM St_instr.GetExamQuestionsForInstructor(4, 14);

-- Instructor start exam
EXEC St_instr.StartFinalExam 
    @Course_Name = 'Finance Basics',
	@Instructor_ID = 4,
    @Start_Time = '2025-02-11 10:00:00',
    @End_Time = '2025-02-11 12:00:00',
    @BranchName = 'Mansoura Branch',
    @TrackName = 'Finance',
    @ExamId = 14, 
    @ExamType = 'Exam',
    @NumberOfQuestions = 5;

-- Student take exam and see his score
EXEC SubmitExam 
    @StudentID = 7, 
    @ExamID = 14, 
    @StudentAnswers = '[{"QuestionID":1, "Answer":"B"}, {"QuestionID":2, "Answer":"B"}, {"QuestionID":3, "Answer":"C"}, {"QuestionID":4, "Answer":"It is process to speed search methods"}, {"QuestionID":5, "Answer":"A"}]';

-- Student report All his courses and their instructors
exec ViewAllCoursesWithInstractors 7;

-- Student report All his results at all his exams
SELECT * FROM St_instr.GetStudentExamResults(7);