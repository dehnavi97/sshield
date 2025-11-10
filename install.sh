#!/bin/bash
# SSHield Online Installer

# --- Global Variables ---
REPO_RAW_URL="https://raw.githubusercontent.com/jules-dot-ai/ops-sshield/main"

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

# Download and install scripts
print_msg "Downloading and installing SSHield scripts..."
curl -sSL "$REPO_RAW_URL/sshield" -o "/usr/local/bin/sshield"
curl -sSL "$REPO_RAW_URL/sshield_notify.sh" -o "/usr/local/bin/sshield_notify.sh"
curl -sSL "$REPO_RAW_URL/sshield_summary.sh" -o "/usr/local/bin/sshield_summary.sh"

# Make scripts executable
chmod +x /usr/local/bin/sshield
chmod +x /usr/local/bin/sshield_notify.sh
chmod +x /usr/local/bin/sshield_summary.sh


# Set up cron jobs for summaries
print_msg "Setting up cron jobs for security summaries..."
(crontab -l 2>/dev/null | grep -v "sshield_summary.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * * /usr/local/bin/sshield_summary.sh daily > /var/log/sshield_daily.log") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * 0 /usr/local/bin/sshield_summary.sh weekly > /var/log/sshield_weekly.log") | crontab -

print_msg "Installation complete! Type 'sshield' to get started."
exit 0
