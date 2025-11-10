#!/bin/bash
# SSHield Summary Generator

# Function to generate a summary for a given time period
generate_summary() {
    PERIOD=$1
    echo "SSHield Security Summary - Last $PERIOD"
    echo "======================================"
    echo
    echo "=== Successful Logins ==="
    journalctl _SYSTEMD_UNIT=sshd.service --since "-$PERIOD" | grep "Accepted password" | sed -E 's/.*Accepted password for ([^ ]+) from ([^ ]+) port.*/\1 from \2/' | sort | uniq -c
    echo
    echo "=== Failed Login Attempts ==="
    journalctl _SYSTEMD_UNIT=sshd.service --since "-$PERIOD" | grep "Failed password" | sed -E 's/.*Failed password for (invalid user )?([^ ]+) from ([^ ]+) port.*/\2 from \3/' | sort | uniq -c
    echo
    echo "=== fail2ban Actions (Banned IPs) ==="
    journalctl _SYSTEMD_UNIT=fail2ban.service --since "-$PERIOD" | grep "Ban" | sed -E 's/.*Ban ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*/\1/' | sort | uniq -c
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
