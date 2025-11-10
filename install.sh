#!/bin/bash
# SSHield Installer

# --- Helper Functions ---

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print messages
print_msg() {
    echo "=> $1"
}

# --- Main Installation Logic ---

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  print_msg "Please run as root."
  exit 1
fi

print_msg "Starting SSHield installation..."

# Install dependencies
print_msg "Installing dependencies..."
if [ -f /etc/debian_version ]; then
    apt-get update
    apt-get install -y whiptail ufw fail2ban knockd curl
elif [ -f /etc/redhat-release ]; then
    yum install -y newt ufw fail2ban knockd curl
else
    print_msg "Unsupported distribution. Please install the following dependencies manually: whiptail, ufw, fail2ban, knockd, curl"
fi

# Copy scripts to /usr/local/bin
print_msg "Installing SSHield scripts..."
install -m 755 sshield /usr/local/bin/sshield
install -m 755 sshield_notify.sh /usr/local/bin/sshield_notify.sh
install -m 755 sshield_summary.sh /usr/local/bin/sshield_summary.sh

# Set up cron jobs for summaries
print_msg "Setting up cron jobs for security summaries..."
(crontab -l 2>/dev/null; echo "0 0 * * * /usr/local/bin/sshield_summary.sh daily > /var/log/sshield_daily.log") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * 0 /usr/local/bin/sshield_summary.sh weekly > /var/log/sshield_weekly.log") | crontab -

print_msg "Installation complete! Type 'sshield' to get started."
exit 0
