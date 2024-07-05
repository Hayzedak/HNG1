# Automating User and Group Management with a Bash Script

Managing user accounts and groups is a crucial job for system administrators, especially in environments where many new users are frequently added. Automating this process can save significant time and reduce the risk of human error. 

In this article, we will demonstrate how to automate user and group management using Bash script. This script will read a text file containing usernames and group names, create the users and groups as specified, set up home directories, generate random passwords, and log all actions.

## Script Overview

The script **`create_users.sh`** performs the following tasks:

1. Reads a text file where each line contains a username and a list of groups, separated by a semicolon (**`;`**).

2. Creates a personal group for each user.

3. Creates user accounts with their respective personal groups.

4. Adds users to additional groups as specified.

5. Sets up home directories with appropriate permissions.

6. Generates random passwords for each user.

7. Logs all actions to **`/var/log/user_management.log`**.

8. Stores the generated passwords securely in **`/var/secure/user_passwords.txt`**.


## Prerequisites

Ensure you have the necessary permissions to create users, groups, and modify system files. The script needs to be executed with superuser privileges.

## The Bash Script: [create_users.sh](https://github.com/Hayzedak/HNG1/blob/main/create_users.sh)

## Preparing the Input File

Create a text file named **`user_list.txt`** with the following format:

```
azeez;developers,admins
hng;developers
nora;admins
```

Each line contains a username and a list of groups separated by a semicolon (**`;`**). Multiple groups are separated by commas (**`,`**).

## Running the Script

## Make the Script Executable:

`sudo chmod +x create_users.sh`

## Execute the Script:

`sudo ./create_users.sh user_list.txt`

## Verifying the Script Execution

## Check the Log File:

`sudo cat /var/log/user_management.log`

## Check the Password File:

`sudo cat /var/secure/user_passwords.txt`

## Verify User Accounts:

`cut -d: -f1 /etc/passwd | grep -E 'azeez|hng|nora'`

## Verify Group Membership:

```
groups azeez
groups hng
groups nora
```

## Conclusion

Automating user and group management with a Bash script can enhance the efficiency and accuracy of administrative tasks. This script provides solution for creating users, managing group memberships, setting up home directories, and ensuring secure password handling. By following this guide, system administrators can save time and reduce errors, particularly in environments with frequent user account changes.

