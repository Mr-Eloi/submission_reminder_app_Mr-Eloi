#!/bin/bash

# Prompt for username
read -p "Enter your name: " userName

# Define the main directory
ti_app="submission_reminder_${userName}"

# Create other directories
mkdir -p "$ti_app/app"
mkdir -p "$ti_app/modules"
mkdir -p "$ti_app/assets"
mkdir -p "$ti_app/config"

# Add necessary files
touch "$ti_app/app/reminder.sh"
touch "$ti_app/modules/functions.sh"
touch "$ti_app/assets/submissions.txt"
touch "$ti_app/config/config.env"
touch "$ti_app/startup.sh"

# Config.env
cat << EOF > "$ti_app/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Submissions.txt
cat << EOF > "$ti_app/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Innocent, Linux intro and IT tolls, Submitted
Kabera, Javascript, Not submitted
Jonathan, Shell Navigation, Submitted
Laura, Python, Submitted
Ketsia, Loop, Not submitted
EOF

# Functions.sh
cat << 'EOF' > "$ti_app/modules/functions.sh"
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

# Reminder.sh
cat << 'EOF' > "$ti_app/app/reminder.sh"
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

# Startup.sh
cat << 'EOF' > "$ti_app/startup.sh"
#!/bin/bash

# Load Resources
source ./config/config.env
source ./modules/functions.sh

# Initialize the submission.txt file
submissions_file="./assets/submissions.txt"

# Check if submissions.txt file exists
if [ ! -f "$submissions_file" ]; then
    echo "Error: Submissions file: ($submissions_file) is missing!"
    exit 1
fi

# Display assignment details from the config.env
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

echo "_______________________________________________"
echo ""

# Call the function to check submissions
check_submissions "$submissions_file"

# Reminder executable messagee
echo "Reminder script executed successfully!!!"
EOF

# Making scripts executable
chmod 755 "$ti_app/modules/functions.sh"
chmod 755 "$ti_app/startup.sh"
chmod 755 "$ti_app/app/reminder.sh"

echo -e "Environment setup completed! \nChanging Directory to: $ti_app"
cd "$ti_app"
echo -e "Current directory: $(pwd) \nRunning the startup script..."
echo "_______________________________________________"
echo ""
./startup.sh