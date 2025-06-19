# Submission_reminder_app_Darlene250
this is a student reminder app, where a student will be updated the task to do before deadlines
## What does this app do
A bash script system that tracks student assignment submissions and sends reminders for missing work.

## How to run it

### 1. First-time setup
```bash
chmod +x create_environment.sh
./create_environment.sh
# Enter your name when prompted
```

### 2. Manage assignments
```bash
chmod +x copilot_shell_script.sh
./copilot_shell_script.sh
# Enter new assignment name when prompted
```

## What happens
- Creates a directory structure with student data and configuration files
- Tracks which students haven't submitted assignments
- Shows reminders for missing submissions
- Updates assignment names and deadlines

## Key files created
- `submissions.txt` - Student submission records
- `config.env` - Current assignment and deadline settings
- `reminder.sh` - Main reminder script
- `startup.sh` - Runs the system

## Output example
```
Current Assignment: Shell Navigation
Days remaining: 2 days
Reminder: Rita has not submitted the Git assignment!
``` 
