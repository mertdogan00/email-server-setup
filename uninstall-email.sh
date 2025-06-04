#!/bin/bash

# uninstall-email.sh
# This script removes all components installed for the email server setup.
# It purges packages, deletes configuration files, user accounts, certificates,
# logs, and DNS-related data if available.
# USE WITH CAUTION!

echo "Stopping services..."
systemctl stop postfix dovecot opendkim spamassassin fail2ban 2>/dev/null

echo "Disabling services..."
systemctl disable postfix dovecot opendkim spamassassin fail2ban 2>/dev/null

echo "Purging packages..."
apt purge -y postfix postfix-pcre dovecot-imapd dovecot-pop3d dovecot-sieve dovecot-core \
opendkim opendkim-tools spamassassin spamc fail2ban bind9-host certbot \
python3-certbot python3-certbot-nginx python3-certbot-apache net-tools

echo "Removing related users and groups..."
deluser --remove-home postmaster 2>/dev/null
deluser --remove-home vmail 2>/dev/null
delgroup opendkim 2>/dev/null

echo "Deleting mail configuration files..."
rm -rf /etc/postfix /etc/dovecot /etc/opendkim /etc/fail2ban /var/lib/dovecot /var/mail
rm -rf /etc/default/spamassassin /etc/spamassassin

echo "Deleting DKIM keys and mail logs..."
rm -rf /etc/postfix/dkim /var/log/mail.* /var/log/mail.log /var/log/spamassassin

echo "Deleting Let's Encrypt certificates..."
rm -rf /etc/letsencrypt/live/* /etc/letsencrypt/archive/* /etc/letsencrypt/renewal/*

echo "Cleaning cron jobs related to mail..."
rm -f /etc/cron.weekly/postmaster-clean

echo "Reloading systemd daemon and cleaning up leftover files..."
systemctl daemon-reexec
systemctl daemon-reload

echo "Email server and all related components have been removed."
