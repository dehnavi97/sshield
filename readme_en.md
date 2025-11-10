# SSHield - A Linux Server Security Tool

SSHield is a powerful, all-in-one security tool for Linux servers, designed to protect against brute-force attacks and provide robust management of critical services. With a user-friendly CLI menu, SSHield simplifies server security, making it accessible to both new and experienced administrators.

## 🚀 Features

- **Service Management**: Easily enable, disable, and check the status of essential services like SSH, FTP, and Telnet.
- **Port Management**: Securely change service ports with built-in conflict and safety checks.
- **IP Restrictions**: Restrict access to your services by allowing or denying specific IP addresses using `ufw`.
- **Brute-Force Protection**: Integrates `fail2ban` to automatically block suspicious IPs.
- **Port Knocking**: Hide your SSH port from scanners by implementing port knocking with `knockd`.
- **Logging & Reporting**: Receive real-time webhook notifications for successful SSH logins and view aggregated reports of failed attempts.
- **Security Summaries**: Get daily and weekly security summaries to stay informed about your server's security status.

## ⚙️ Installation

To install SSHield, simply run the following command as a root user:

```bash
bash install.sh
```

The installer will handle all dependencies and set up the necessary components.

## 🕹️ Usage

Once installed, you can launch the SSHield menu by typing:

```bash
sshield
```

This will open a clean, intuitive CLI menu where you can access all of SSHield's features. The menu is designed to be self-explanatory, allowing you to navigate through the various security options with ease.
