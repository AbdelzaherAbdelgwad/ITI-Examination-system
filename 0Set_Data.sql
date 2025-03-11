-- 1. Insert into Manager schema
INSERT INTO Manager.Manger (Manger_ID, Man_Name, Mang_Age, Mang_Phone)
VALUES
(1, 'Ali Hassan', 45, '0100000001'),
(2, 'Sara Ahmed', 50, '0100000002'),
(3, 'Hassan Ibrahim', 42, '0100000003'),
(4, 'Fatma Khaled', 39, '0100000004'),
(5, 'Omar Youssef', 47, '0100000005'),
(6, 'Nour Mohamed', 38, '0100000006'),
(7, 'Khaled Salah', 52, '0100000007'),
(8, 'Mariam Adel', 41, '0100000008'),
(9, 'Ahmed Mostafa', 48, '0100000009'),
(10, 'Laila Tarek', 44, '0100000010');

-- 2. Insert into Manager schema
INSERT INTO Manager.Intake (Intake_Id, [Year], Manger_ID)
VALUES
(1, 2022, 1),
(2, 2023, 2),
(3, 2023, 3),
(4, 2024, 4),
(5, 2024, 5),
(6, 2025, 6),
(7, 2025, 7),
(8, 2026, 8),
(9, 2026, 9),
(10, 2027, 10);

-- 3. Insert into Manager schema
INSERT INTO Manager.Branch (Branch_Id, Branch_Name, Manger_ID)
VALUES
(1, 'Cairo Branch', 1),
(2, 'Alexandria Branch', 2),
(3, 'Giza Branch', 3),
(4, 'Mansoura Branch', 4),
(5, 'Fayoum Branch', 5),
(6, 'Tanta Branch', 6),
(7, 'Suez Branch', 7),
(8, 'Ismailia Branch', 8),
(9, 'Asyut Branch', 9),
(10, 'Luxor Branch', 10);

-- 4. Insert into Manager schema
INSERT INTO Manager.Department (Dept_ID, Dept_Name, Branch_Id)
VALUES
(1, 'Computer Science', 1),
(2, 'Information Technology', 2),
(3, 'Business Administration', 3),
(4, 'Accounting', 4),
(5, 'Marketing', 5),
(6, 'Engineering', 6),
(7, 'Medical Science', 7),
(8, 'Law', 8),
(9, 'Arts', 9),
(10, 'Physics', 10);

-- 5. Insert into Manager schema
INSERT INTO Manager.BranchDepartment (Branch_Id, Dept_ID)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- 6. Insert into Manager schema
INSERT INTO Manager.IntakeBranch (Intake_Id, Branch_Id)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- 7. Insert into Manager schema
INSERT INTO Manager.Track (Track_ID, Track_Name, Dept_ID, Manger_ID)
VALUES
(1, 'Data Science', 1, 1),
(2, 'Cybersecurity', 2, 2),
(3, 'Software Engineering', 3, 3),
(4, 'Finance', 4, 4),
(5, 'Digital Marketing', 5, 5),
(6, 'Civil Engineering', 6, 6),
(7, 'Biotechnology', 7, 7),
(8, 'Criminal Law', 8, 8),
(9, 'Literature', 9, 9),
(10, 'Astrophysics', 10, 10);

-- 8. Insert into St_instr schema
INSERT INTO St_instr.Student (St_Name, Student_Age, Student_Phone, Manger_ID, Student_Intake, Student_Track, Student_Branch)
VALUES
('Youssef Ali', 21, '0110000001', 1, 1, 1, 1),
('Aya Mohamed', 22, '0110000002', 2, 2, 2, 2),
('Karim Hassan', 20, '0110000003', 3, 3, 3, 3),
('Lina Ahmed', 23, '0110000004', 4, 4, 4, 4),
('Mostafa Tarek', 22, '0110000005', 5, 5, 5, 5),
('Noha Khaled', 21, '0110000006', 6, 6, 6, 6),
('Omar Sherif', 24, '0110000007', 7, 7, 7, 7),
('Fatima Youssef', 20, '0110000008', 8, 8, 8, 8),
('Ali Salem', 23, '0110000009', 9, 9, 9, 9),
('Dalia Hassan', 22, '0110000010', 10, 10, 10, 10);

-- 9. Insert into St_instr schema
INSERT INTO St_instr.Course (Course_Id, Course_Name, MaxDegree, MinDegree, CourseDescription,Ins_ID)
VALUES
(1, 'Database Systems', 100, 50, 'Intro to databases',2),
(2, 'Network Security', 100, 50, 'Cybersecurity fundamentals',3),
(3, 'Web Development', 100, 50, 'Front-end and back-end development',2),
(4, 'Finance Basics', 100, 50, 'Introduction to Finance',2),
(5, 'Digital Marketing', 100, 50, 'SEO and social media marketing',5),
(6, 'Structural Engineering', 100, 50, 'Construction and materials',2),
(7, 'Genetics', 100, 50, 'Basic genetics and DNA sequencing',2),
(8, 'Constitutional Law', 100, 50, 'Understanding legal principles',2),
(9, 'Creative Writing', 100, 50, 'Fiction and poetry writing',9),
(10, 'Quantum Mechanics', 100, 50, 'Introduction to quantum physics',2);

-- 10. Insert into St_instr schema
INSERT INTO St_instr.StudentCourse (Std_Id, Course_Id)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- 11. Insert into Manager schema
INSERT INTO Manager.TrackCourse (Course_Id, Track_ID)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- 12. Insert into St_instr schema
INSERT INTO St_instr.Instructour (Ins_ID, InstructourName, InstructourAge, InstructourPhone)
VALUES
(1, 'Dr. Ayman', 50, '0120000001'),
(2, 'Prof. Hala', 45, '0120000002'),
(3, 'Dr. Sherif', 48, '0120000003'),
(4, 'Dr. Mona', 52, '0120000004'),
(5, 'Prof. Tamer', 47, '0120000005'),
(6, 'Dr. Salma', 43, '0120000006'),
(7, 'Dr. Wael', 55, '0120000007'),
(8, 'Dr. Laila', 49, '0120000008'),
(9, 'Prof. Amr', 46, '0120000009'),
(10, 'Dr. Rania', 44, '0120000010');

-- 13. Insert into Exam schema
INSERT INTO Exam.Exam (Exam_ID, ExamType, ExamDegree, ExamIntake, ExamTrack, ExamBranch, Course_Id, Ins_ID, ExamStartTime, ExamEndTime)
VALUES
(1, 'Exam', 100, 1, 1, 1, 1, 1, '2025-05-10 09:00:00', '2025-05-10 11:00:00'),
(2, 'Corrective', 50, 2, 2, 2, 2, 2, '2025-06-15 10:00:00', '2025-06-15 12:00:00'),
(3, 'Exam', 25, 3, 3, 3, 3, 3, '2025-07-20 08:00:00', '2025-07-20 09:00:00'),
(4, 'Corrective', 100, 4, 4, 4, 4, 4, '2025-08-22 10:00:00', '2025-08-22 12:00:00'),
(5, 'Exam', 50, 5, 5, 5, 5, 5, '2025-09-12 11:00:00', '2025-09-12 01:00:00'),
(6, 'Corrective', 25, 6, 6, 6, 6, 6, '2025-10-05 09:00:00', '2025-10-05 10:00:00'),
(7, 'Exam', 100, 7, 7, 7, 7, 7, '2025-11-10 08:30:00', '2025-11-10 10:30:00'),
(8, 'Corrective', 50, 8, 8, 8, 8, 8, '2025-12-01 09:00:00', '2025-12-01 11:00:00'),
(9, 'Exam', 25, 9, 9, 9, 9, 9, '2025-12-15 10:00:00', '2025-12-15 11:00:00'),
(10, 'Corrective', 100, 10, 10, 10, 10, 10, '2026-01-20 09:30:00', '2026-01-20 11:30:00');

-- 14. Insert into St_instr schema
INSERT INTO St_instr.InstructourExam (Ins_ID, Exam_ID, Student_IDS, NumberOfQuestion)
VALUES
(1, 1, 1, 10),
(2, 2, 2, 15),
(3, 3, 3, 20),
(4, 4, 4, 25),
(5, 5, 5, 30),
(6, 6, 6, 12),
(7, 7, 7, 14),
(8, 8, 8, 18),
(9, 9, 9, 22),
(10, 10, 10, 28);

-- 15. Insert into St_instr schema
INSERT INTO Exam.StudentExam (Std_Id, Exam_ID, Answer)
VALUES
(1, 1, 'A,B,C,D'),
(2, 2, 'B,C,A,D'),
(3, 3, 'D,A,C,B'),
(4, 4, 'C,D,A,B'),
(5, 5, 'B,D,C,A'),
(6, 6, 'D,B,A,C'),
(7, 7, 'A,C,D,B'),
(8, 8, 'C,A,B,D'),
(9, 9, 'D,C,B,A'),
(10, 10, 'A,B,D,C');

-- 16. Insert into Exam schema
INSERT INTO Exam.QuestionPool (Question_ID, InstructourDegree, CorrectAnswer, BestAnswer, QuestionText, QuestionType, Ins_ID, InstructourDegree)
VALUES
(1, 10, 'A', 'B', 'What is SQL?', 'MCQ', 1, 90),
(2, 10, 'B', 'C', 'What is Normalization?', 'MCQ', 2, 85),
(3, 10, 'C', 'D', 'What is a Database?', 'MCQ', 3, 80),
(4, 10, 'D', 'A', 'What is an Index?', 'MCQ', 4, 75),
(5, 10, 'A', 'B', 'What is a View?', 'MCQ', 5, 70),
(6, 10, 'B', 'C', 'What is a Trigger?', 'MCQ', 6, 65),
(7, 10, 'C', 'D', 'What is an Entity?', 'MCQ', 7, 60),
(8, 10, 'D', 'A', 'What is a Key?', 'MCQ', 8, 55),
(9, 10, 'A', 'B', 'What is a Schema?', 'MCQ', 9, 50),
(10, 10, 'B', 'C', 'What is a Query?', 'MCQ', 10, 45);
