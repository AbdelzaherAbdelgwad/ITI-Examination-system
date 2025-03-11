# Examination System Database

## 📌 **Project Overview**

The Examination System Database is designed to:
- Allow instructors to create and manage questions in a question pool.
- Enable instructors to create exams manually or randomly from the question pool.
- Facilitate students to take exams within scheduled time frames.
- Securely store and manage student results.
- Provide robust data management for courses, students, and instructors.
- Ensure system security, performance, and data recovery.

---

## 🔹 **Key Features**

### **Question Pool**
- Supports multiple question types: **multiple-choice**, **true/false**, and **text-based questions**.
- Allows instructors to add, edit, and delete questions.

### **Automated Answer Checking**
- System automatically grades **objective questions** (multiple-choice, true/false).
- Instructors can manually review and grade **text-based answers**.

### **Course & Instructor Management**
- Each course is linked to an instructor.
- Instructors can manage multiple exams for their courses.

### **Exam Creation & Scheduling**
- Instructors can create exams **manually** or **randomly select questions** from the question pool.
- Set **start and end times** for exams.
- Assign exams to specific students or groups.

### **Student Result Tracking**
- Stores student answers and calculates scores.
- Tracks final results and determines if a student **passes** or requires a **corrective exam**.
- Provides detailed performance reports for students and instructors.

### **User Roles & Security**
- Separate accounts with role-based permissions:
  - **Admin**: Manages system-wide settings and users.
  - **Training Managers**: Oversee courses and instructors.
  - **Instructors**: Create and manage exams and questions.
  - **Students**: Take exams and view results.
- Ensures secure access and data protection.

### **Optimized Database Design**
- Utilizes **indexing**, **constraints**, **triggers**, **stored procedures**, and **functions** for optimal performance.
- Ensures data integrity and efficient query execution.

### **Automatic Daily Backup**
- Implements an automated backup system to ensure **data safety** and provide **recovery options** in case of failures.

---

## 🛠️ **Technologies Used**
- **Database**: SQL server
- **Backup**: Automated daily backups using cron jobs or database tools

---

## 📂 **Database Schema Overview**
The database schema includes the following key tables:
1. **Users**: Stores user information (admin, instructors, students).
2. **Courses**: Manages course details and links to instructors.
3. **Questions**: Stores questions and their types (multiple-choice, true/false, text).
4. **Exams**: Manages exam details, including scheduling and assigned students.
5. **StudentAnswers**: Tracks student answers and scores.
6. **Results**: Stores final results and corrective exam status.

---

## 🚀 **How to Use**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/AbdelzaherAbdelgwad/ITI-Examination-system