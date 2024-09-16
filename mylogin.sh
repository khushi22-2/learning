#!/bin/bash
# Predefined username and password
Valid_Username="user123"
Valid_Password="pass123"

# Function to display usage
usage()
{
    echo "Usage: $0 -u username -p password"
    exit 1
}

# Parse command line arguments
while getopts ":u:p:" opt;
do
    case $opt in
        u)
            USERNAME="$OPTARG";;
        p)
            PASSWORD="$OPTARG";;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage;;
        *)
            echo "Option -$OPTARG requires an argument." >&2
            usage;;
    esac
done

# Check if both username and password are provided
if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ];
then
    echo "Both username and password are required."
    usage
fi

# Validate the login credentials
if [ "$USERNAME" == "$Valid_Username" ] && [ "$PASSWORD" == "$Valid_Password" ];
then
    echo "Login successful!"
else
    echo "Invalid username or password."
fi