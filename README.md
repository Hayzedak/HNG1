# Automating User and Group Management with a Bash Script

This is an [HNG](https://hng.tech/internship) internship task for a DevOps engineer. Managing user accounts and groups is a crucial job for system administrators, especially in environments where many new users are frequently added. Automating this process can save significant time and reduce the risk of human error. 

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
