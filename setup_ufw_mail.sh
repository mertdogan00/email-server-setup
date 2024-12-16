#!/bin/bash

# UFW Installation and Configuration for Mail Server and SSH

# 1. Install UFW
echo "Installing UFW..."
apt update && apt install ufw -y

# 2. Allow SSH Port (for Remote Access)
echo "Allowing SSH port (22)..."
ufw allow 22     # SSH port 22

# 3. Open Necessary Ports for Mail Server

# SMTP (Mail Sending)
echo "Allowing SMTP port (25)..."
ufw allow 25     # SMTP port 25

# SMTPS (Secure Mail Sending with SSL/TLS)
echo "Allowing SMTPS port (465)..."
ufw allow 465    # SMTPS port 465 (SSL/TLS)

# Submission (Secure Mail Sending with STARTTLS)
echo "Allowing Submission port (587)..."
ufw allow 587    # Submission port 587 (STARTTLS)

# POP3 (Mail Retrieval)
echo "Allowing POP3 port (110)..."
ufw allow 110    # POP3 port 110

# POP3S (Secure Mail Retrieval with SSL/TLS)
echo "Allowing POP3S port (995)..."
ufw allow 995    # POP3S port 995 (SSL/TLS)

# IMAP (Mail Retrieval and Management)
echo "Allowing IMAP port (143)..."
ufw allow 143    # IMAP port 143

# IMAPS (Secure Mail Retrieval and Management with SSL/TLS)
echo "Allowing IMAPS port (993)..."
ufw allow 993    # IMAPS port 993 (SSL/TLS)

echo "Allowing Sieve port (4190)..."
ufw allow 4190    # Sieve port 4190 (ManageSieve)

# 4. Enable UFW
echo "Enabling UFW..."
ufw --force enable   # Enable UFW without asking for confirmation

# 5. Ensure UFW Starts on Boot
echo "Ensuring UFW starts on boot..."
systemctl enable ufw

# 6. Display UFW Status
echo "Displaying UFW status..."
ufw status verbose

echo "UFW installation and configuration complete!"
