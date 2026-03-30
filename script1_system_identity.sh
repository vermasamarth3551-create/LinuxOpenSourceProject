#!/bin/bash
# Script 1: System Identity Report
# Author: Samarth Verma | Reg: 24BCE10139
# Course: Open Source Software (OSS NGMC)
# Purpose: Display a formatted system identity welcome screen

# ─── Variables ───────────────────────────────────────────────
STUDENT_NAME="Samarth Verma"
REG_NUMBER="24BCE10139"
SOFTWARE_CHOICE="MySQL"

# Capture system info using command substitution $()
KERNEL=$(uname -r)
USER_NAME=$(whoami)
HOME_DIR=$HOME
UPTIME=$(uptime -p)
CURRENT_DATE=$(date '+%d %B %Y')
CURRENT_TIME=$(date '+%H:%M:%S')
HOSTNAME=$(hostname)

# Read distro name from the standard os-release file
if [ -f /etc/os-release ]; then
    # Source the file to load its variables
    source /etc/os-release
    DISTRO_NAME="$PRETTY_NAME"
else
    # Fallback if file is missing
    DISTRO_NAME="Unknown Linux Distribution"
fi

# ─── Display ─────────────────────────────────────────────────
echo "=============================================="
echo "   Open Source Audit — System Identity Report"
echo "   Student : $STUDENT_NAME ($REG_NUMBER)"
echo "   Software: $SOFTWARE_CHOICE"
echo "=============================================="
echo ""
echo "  Hostname     : $HOSTNAME"
echo "  Distribution : $DISTRO_NAME"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "  OS License   : GNU General Public License v2 (GPL v2)"
echo "  Note: The Linux kernel is free software licensed under"
echo "        the GPL v2 — you have the right to use, study,"
echo "        modify, and distribute it."
echo "=============================================="
