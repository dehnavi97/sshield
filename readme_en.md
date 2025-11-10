# SSHield - A Linux Server Security Tool

SSHield is a powerful, all-in-one security tool for Linux servers, designed to protect against brute-force attacks and provide robust management of critical services. With a user-friendly CLI menu, SSHield simplifies server security, making it accessible to both new and experienced administrators.

## ⚙️ Installation

To install SSHield, simply run the following command as a root user:

```bash
curl -sSL https://raw.githubusercontent.com/jules-dot-ai/ops-sshield/main/install.sh | bash
```

The installer will handle all dependencies and set up the necessary components.

## 🕹️ Usage

Once installed, you can launch the SSHield menu by typing:

```bash
sshield
```

This will open a clean, intuitive CLI menu where you can access all of SSHield's features.

## 🚀 Features

### Service Management
- **Enable/Disable Services**: Quickly enable or disable critical services like `sshd`, `vsftpd`, and `telnet`.
- **Status Check**: Instantly view the current status (active/inactive, enabled/disabled) of any managed service.
- **Safety First**: The tool prevents you from disabling the SSH service you are currently using, avoiding accidental lockouts.

### Port Management
- **Change SSH Port**: Easily change the default SSH port to a custom one.
- **Security Checks**: The tool automatically checks for port conflicts and warns against using privileged or insecure ports.
- **Firewall Integration**: `ufw` rules are automatically updated to allow the new port and block the old one, ensuring a seamless transition.

### IP Restriction
- **Allow/Deny IPs**: Restrict access to SSH by creating `ufw` rules to allow or deny specific IP addresses.
- **Auto-Allow Current IP**: To prevent accidental lockouts, SSHield will offer to automatically allow your current IP address if no other allow rules are detected.
- **View Rules**: You can view all active `ufw` rules directly from the menu.

### Brute-Force Protection
- **fail2ban Integration**: SSHield automates the installation and configuration of `fail2ban`.
- **SSH Protection**: A `fail2ban` jail for `sshd` is automatically enabled to monitor and block malicious login attempts.
- **Status Monitoring**: You can view the status of the `sshd` jail at any time to see a list of banned IPs.

### Port Knocking
- **Hide SSH Port**: Implement port knocking to hide your SSH port from public view.
- **Custom Sequences**: Define a custom sequence of ports that must be "knocked" before the main SSH port is opened.
- **Automatic Configuration**: SSHield handles the installation and configuration of `knockd` and sets up the necessary firewall rules.

### Logging & Reporting
- **Webhook Notifications**: Configure a webhook URL to receive real-time notifications for every successful SSH login. The notification is sent as a JSON payload with the following structure:
  ```json
  {
    "hostname": "your-server-hostname",
    "user": "the-user-logging-in",
    "source_ip": "the-source-ip-address",
    "timestamp": "YYYY-MM-DD HH:MM:SS",
    "message": "Full notification message"
  }
  ```
- **Failed Attempts Report**: View an aggregated list of failed login attempts, sorted by IP address, to easily identify persistent threats.

### Security Summaries
- **Daily & Weekly Reports**: Generate on-demand security summaries for the last 24 hours or 7 days.
- **Key Metrics**: The summaries include successful logins, failed attempts, and a list of IPs banned by `fail2ban`, providing a quick overview of your server's security.
