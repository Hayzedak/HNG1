#!/bin/bash

# Log file location
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Create secure directory if it doesn't exist
mkdir -p /var/secure
chmod 700 /var/secure

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to generate a random password
generate_password() {
    openssl rand -base64 12
}

# Function to create user and groups
create_user_and_groups() {
    local user="$1"
    local groups="$2"

    # Create personal group with the same name as the user
    if ! getent group "$user" > /dev/null; then
        groupadd "$user"
        log_message "Group $user created."
    else
        log_message "Group $user already exists."
    fi

    # Create the user with their personal group
    if ! id -u "$user" > /dev/null 2>&1; then
        useradd -m -g "$user" -s /bin/bash "$user"
        log_message "User $user created."
    else
        log_message "User $user already exists."
    fi

    # Set home directory permissions
    chmod 700 /home/"$user"
    chown "$user":"$user" /home/"$user"
    log_message "Home directory permissions set for $user."

    # Add user to additional groups
    if [ -n "$groups" ]; then
        IFS=',' read -ra group_array <<< "$groups"
        for group in "${group_array[@]}"; do
            group=$(echo "$group" | xargs) # Trim whitespace
            if ! getent group "$group" > /dev/null; then
                groupadd "$group"
                log_message "Group $group created."
            fi
            usermod -aG "$group" "$user"
            log_message "User $user added to group $group."
        done
    fi

    # Generate and set password
    local password=$(generate_password)
    echo "$user:$password" | chpasswd
    log_message "Password set for user $user."

    # Save the password securely
    echo "$user:$password" >> $PASSWORD_FILE
    chmod 600 $PASSWORD_FILE
}

# Check if the input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <user_file>"
    exit 1
fi

# Read the input file
while IFS=';' read -r user groups || [ -n "$user" ]; do
    user=$(echo "$user" | xargs) # Trim whitespace
    groups=$(echo "$groups" | xargs) # Trim whitespace
    [ -z "$user" ] && continue # Skip empty lines
    create_user_and_groups "$user" "$groups"
done < "$1"

log_message "User creation script completed."
