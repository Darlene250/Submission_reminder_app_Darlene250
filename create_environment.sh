#!/bin/bash
#The user will have access to input their name
echo "====== Hi there! You are Welcome,kindly type your NAME ========"
read -p "Enter you name here: " name
echo "Your account has been created"
echo "Hello "$name" welcome to your reminder_app"
#Error handling for empty inputs
if [[ -z "$name" ]]; then 
	echo "Please your name can not be empty"
	exit 1
fi
#creating the submission_remind with input name of the user
name_dir="submission_reminder_$name"
#Error handling for if the file already exist
if [[ -d "$name_dir" ]]; then
	echo "file directory $name_dir ALREADY EXIST"
	exit 1
fi
#Creating a structure for the environment
mkdir -p "$name_dir/app" "$name_dir/modules" "$name_dir/assets" "$name_dir/config"
#creating the files inside their various directories
touch "$name_dir/app/reminder.sh" "$name_dir/modules/functions.sh" "$name_dir/assets/submissions.txt" "$name_dir/config/config.env"
#to populate the various files
cat << 'EOF' >> "$name_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
#populating for the functions.sh file
cat << 'EOF' >> "$name_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#populating for the submissions.txt file
cat << 'EOF' >> "$name_dir/assets/submissions.txt" 
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Darlene, Shell Scripting, submitted
Rita, Git, not submitted
Nashe, Python,  not submitted
Gazelle, JavaScript, submitted
Celyse, Web Development, submitted
Matthew, Node.js, not submitted
Dalicia. Python Variables, submitted
EOF

#populating for the config.env file
cat << 'EOF' >> "$name_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
#Give the scripts executable permissions
chmod +x "$name_dir/app/reminder.sh" "$name_dir/modules/functions.sh" 
#creating the startup.sh file 
cat << 'EOF' >> "$name_dir/startup.sh"
#!/bin/bash
./app/reminder.sh
EOF

#Make the startup.sh file executable 
chmod +x "$name_dir/startup.sh"

echo " Your environment '$name_dir' has been created successfully"
