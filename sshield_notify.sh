#!/bin/bash
# SSHield Notification Script

# This script is called by PAM on successful SSH login.
# It sends a notification to a webhook URL.

# It requires the following PAM variables to be set:
# PAM_USER: The user logging in
# PAM_RHOST: The remote host

# Read webhook URL from config
if [ -f /etc/sshield/config ]; then
    WEBHOOK_URL=$(grep WEBHOOK_URL /etc/sshield/config | cut -d'=' -f2)
fi

if [ -z "$WEBHOOK_URL" ]; then
    # If no webhook is configured, exit silently.
    exit 0
fi

# Get login info from PAM environment variables
USER="$PAM_USER"
IP="$PAM_RHOST"
HOSTNAME=$(hostname)

# Check if the variables are set
if [ -z "$USER" ] || [ -z "$IP" ]; then
    # If PAM variables are not set, it's not a real login session.
    # Or something is wrong with the PAM configuration.
    # Exit silently to avoid spamming.
    exit 0
fi


# Send notification
MESSAGE="Successful SSH login on $HOSTNAME: User '$USER' from IP '$IP'"
# Use timeout to prevent login process from hanging
curl --connect-timeout 5 -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" "$WEBHOOK_URL" > /dev/null 2>&1
