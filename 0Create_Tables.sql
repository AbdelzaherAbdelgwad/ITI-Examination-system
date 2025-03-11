CREATE TABLE Manger (
    Manger_ID INT PRIMARY KEY,
    Man_Name VARCHAR(255),
    Mang_Age INT,
    Mang_Phone VARCHAR(20)
);

CREATE TABLE Intake (
    Intake_Id INT PRIMARY KEY,
    [Year] INT,
    Manger_ID INT,
    FOREIGN KEY (Manger_ID) REFERENCES Manger(Manger_ID)
);

CREATE TABLE Branch (
    Branch_Id INT PRIMARY KEY,
    Branch_Name VARCHAR(255) UNIQUE,
    Manger_ID INT,
    FOREIGN KEY (Manger_ID) REFERENCES Manger(Manger_ID)
);

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(255),
    Branch_Id INT,
    FOREIGN KEY (Branch_Id) REFERENCES Branch(Branch_Id)
);

CREATE TABLE BranchDepartment (
    Branch_Id INT,
    Dept_ID INT,
    PRIMARY KEY (Branch_Id, Dept_ID),
    FOREIGN KEY (Branch_Id) REFERENCES Branch(Branch_Id),
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE IntakeBranch (
    Intake_Id INT,
    Branch_Id INT,
    PRIMARY KEY (Intake_Id, Branch_Id),
    FOREIGN KEY (Intake_Id) REFERENCES Intake(Intake_Id),
    FOREIGN KEY (Branch_Id) REFERENCES Branch(Branch_Id)
);

CREATE TABLE Track (
    Track_ID INT PRIMARY KEY,
    Track_Name VARCHAR(255),
    Dept_ID INT,
    Manger_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
    FOREIGN KEY (Manger_ID) REFERENCES Manger(Manger_ID)
);

CREATE TABLE Student (
    Std_Id INT PRIMARY KEY,
    St_Name VARCHAR(255),
    Student_Age INT,
    Student_Phone VARCHAR(20),
    Manger_ID INT,
    Student_Intake INT,
    Student_Track INT,
    Student_Branch INT,
    FOREIGN KEY (Manger_ID) REFERENCES Manger(Manger_ID)
);

CREATE TABLE Course (
    Course_Id INT PRIMARY KEY,
    Course_Name VARCHAR(255),
    MaxDegree INT,
    MinDegree INT,
    CourseDescription TEXT
);


CREATE TABLE Instructour (
    Ins_ID INT PRIMARY KEY,
    InstructourName VARCHAR(255),
    InstructourAge INT,
    InstructourPhone VARCHAR(20),
    Course_Id INT,
    FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id)
);

ALTER TABLE Course ADD Ins_ID INT;
ALTER TABLE Course
ADD CONSTRAINT FK_Course_Instructour FOREIGN KEY (Ins_ID)
REFERENCES Instructour(Ins_ID);


CREATE TABLE StudentCourse (
    Std_Id INT,
    Course_Id INT,
	Score INT,
    PRIMARY KEY (Std_Id, Course_Id),
    FOREIGN KEY (Std_Id) REFERENCES Student(Std_Id),
    FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id)
);

CREATE TABLE TrackCourse (
    Course_Id INT,
    Track_ID INT,
    PRIMARY KEY (Course_Id, Track_ID),
    FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID)
);

CREATE TABLE Exam (
    Exam_ID INT PRIMARY KEY,
    ExamType VARCHAR(255),
    ExamDegree INT,
    ExamIntake INT,
    ExamTrack INT,
    ExamBranch INT,
    Course_Id INT,
    Ins_ID INT,
    ExamStartTime DATETIME,
    ExamEndTime DATETIME,
    FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id),
    FOREIGN KEY (Ins_ID) REFERENCES Instructour(Ins_ID)
);

CREATE TABLE InstructourExam (
    Ins_ID INT,
    Exam_ID INT,
    Student_IDS VARCHAR(255),
    NumberOfQuestion INT,
    PRIMARY KEY (Ins_ID, Exam_ID),
    FOREIGN KEY (Ins_ID) REFERENCES Instructour(Ins_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)
);

CREATE TABLE StudentExam (
    Std_Id INT,
    Exam_ID INT,
    Answer NVARCHAR(MAX),
    PRIMARY KEY (Std_Id, Exam_ID),
    FOREIGN KEY (Std_Id) REFERENCES Student(Std_Id),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)
);

CREATE TABLE QuestionPool (
    Question_ID INT PRIMARY KEY,
    CorrectAnswer VARCHAR(255),
    BestAnswer VARCHAR(255),
    QuestionText TEXT,
    QuestionType VARCHAR(255),
    Ins_ID INT,
    InstructourDegree INT,
    FOREIGN KEY (Ins_ID) REFERENCES Instructour(Ins_ID)
);



CREATE TABLE ExamQuestion (
    Question_ID INT,
    Exam_ID INT,
    PRIMARY KEY (Question_ID, Exam_ID),
    FOREIGN KEY (Question_ID) REFERENCES QuestionPool(Question_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)
);