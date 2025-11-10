#!/bin/bash
# SSHield Summary Generator

LOG_FILE="/var/log/auth.log"
if [ -f /etc/redhat-release ]; then
    LOG_FILE="/var/log/secure"
fi

# Function to generate a summary for a given time period
generate_summary() {
    PERIOD=$1
    echo "SSHield Security Summary - Last $PERIOD"
    echo "======================================"
    echo
    echo "Successful Logins:"
    journalctl _SYSTEMD_UNIT=sshd.service --since "-$PERIOD" | grep "Accepted"
    echo
    echo "Failed Logins:"
    journalctl _SYSTEMD_UNIT=sshd.service --since "-$PERIOD" | grep "Failed"
    echo
    echo "fail2ban Actions:"
    journalctl _SYSTEMD_UNIT=fail2ban.service --since "-$PERIOD" | grep "Ban"
}

# Main logic
case "$1" in
    daily)
        generate_summary "24 hours"
        ;;
    weekly)
        generate_summary "7 days"
        ;;
    *)
        echo "Usage: $0 {daily|weekly}"
        exit 1
        ;;
esac
