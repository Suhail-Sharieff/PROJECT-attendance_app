# attendance_app

Attendance tracking app for schools,colleges and universities

## Version 1.0.0
This version of the Attendance App includes the core functionalities as described in the preview video. The app currently uses **SQFlite** for local data storage, and there is no login/signup system implemented at this stage. The state management is basic and will be enhanced in future releases using **ChangeNotifierProvider** or **BLoC**.

## Key Features:
- **Local Data Storage:** Data is stored locally using SQFlite.
- **No Login/Signup:** There is no user authentication system at this point.
- **State Management:** Basic state management in place, with plans to implement more robust solutions like **ChangeNotifierProvider** or **BLoC** in future releases.
## Version 1.0.0 preview:
https://drive.google.com/file/d/1q5FtGHgt17RbxgM0T5OvdEptJxTtSpw1/view?usp=sharing

## How to Use?
git push --set-upstream origin main

### 1. Attendance Page
- **Create Classes:** On the first page, you can create new classes by providing a name for each class. You can add as many classes as you need. To delete a class, just long press on that class.
- **View and Mark Attendance:** Upon clicking a class in the grid (each grid element represents a class), you will be navigated to the attendance page for that class. On this page, you can:
  - **Mark Attendance**: Record student attendance for that class.
  - **Manage Students**: Add, delete, and edit student details.
  - **View Student Details**: Long press on a student’s name to view detailed information about the student.
  
  **Important:** In this version, attendance can only be marked for a class once per day. The student records are maintained, but the attendance status is refreshed daily.

### 2. Analytics Page
- **View Class Statistics:** The analytics page provides data about:
  - The number of classes held for each class.
  - The number of students in each class.
  
  The data is currently presented in bar chart format. Future releases will introduce more features and enhanced analytics.

### 3. Schedule Page
- **Schedule Classes:** On the schedule page, you can:
  - **Mark Scheduled Classes:** Click on a specific date to add a scheduled class.
  - **Delete and View Scheduled Classes:** View and delete scheduled classes for that date.
  
  **Note:** The option to edit scheduled classes will be added in future updates.

---

## Version 2.0.0
This version of the Attendance App includes the core functionalities as described in the preview video. The app currently uses **SQFlite** for local data storage, and there is no login/signup system implemented at this stage. The state management is basic and will be enhanced in future releases using **ChangeNotifierProvider** or **BLoC**.




Feel free to explore these pages, and stay tuned for more features in future releases!


