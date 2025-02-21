# Submission Reminder App
## Overview
***Submission Reminder App*** helps instructors track students' assignment submissions. It checks the submission status and sends reminders to students who haven't submitted their assignments yet.

## Setup Instructions
1. Clone The Repository:
   ```
   git clone https://github.com/Mr-Eloi/submission_reminder_app_Mr-Eloi.git
   ```
2. Provide Permissions & Bash the "create_environment.sh" script:
   ```
   cd submission_reminder_app_Mr-Eloi
   chmod 755 create_environment.sh
   ./create_environment.sh
   ```
3. Navigate to the created directory and check the created Directories:
   ```
   cd submission_reminder_{userName}
   ls
   ```
   
### Files Structure
```
submission_reminder_<your_name>/
├── app/
│   └── reminder.sh      # Main script for sending reminders to students
├── modules/
│   └── functions.sh     # Helper functions for processing submissions
├── assets/
│   └── submissions.txt  # CSV file containing student submissions and their statuses
└── config/
    └── config.env       # Configuration file for the assignment details (name and due date)
└── startup.sh           # Initialization script to start the reminder system
```

## How To Use
1. Navigate to your project folder:
```
cd submission_reminder_<your_name>
```
2. Run the script:
```
./startup.sh
```
The system will check the submission statuses and print reminders for any unsubmitted assignments.
### Author: ***Eloi Iradukunda***
