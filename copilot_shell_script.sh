#!/bin/bash
#Let's find our submission reminder directory
echo "=======YOU ARE WELCOME TO YOUR ASSIGNMENT PORTAL======="
application_directory=$(ls -d submission_reminder_* 2>/dev/null | head -1)
#Error handling if directory is not found then it should go through the following
if [[ -z "$application_directory" ]]; then
	echo "ERROR 101: There is NO such file"
	exit 1
fi
#Let's check if the config file exist
config_file="$application_directory/config/config.env"
if [[ ! -f "$config_file" ]]; then
	echo "ERROR 102: CONFIG file CAN NOT BE FOUND"
	exit 1
fi
# for the current assignment name
current_assigned_name=$(sed -n '2p' "$config_file" | cut -d'=' -f2 | tr -d'"')
echo "Current Assignment: $current_assigned_name"
echo "=====GREAT You have your $current_assigned_name OPEN!!!======"
#Student to enter their assignment name
read -p "Enter your new Assignment name here: " new_assigned
#Error handling if assignment is empty
if [[ -z "$new_assigned" ]]; then 
	echo "ERROR 103: Your Assignment CAN NOT be empty!!"
	exit 1
fi
#To update the assignment with sed (row 2)
sed -i "2s/ASSIGNMENT=.*ASSIGNMENT=\"$new_assigned\"/" "$config_file"
#If the sed works then show us this
echo "Your Assignment has been Updated to: $new_assigned"

#Now we have to run our startup.sh file
cd "$application_directory"
./startup.sh

echo "=======WELL DONE your $new_assigned was successfully submitted======"
