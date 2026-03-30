#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Samarth Verma | Reg: 24BCE10139
# Course: Open Source Software (OSS NGMC)
# Purpose: Audit permissions and disk usage of key system directories,
#          then specifically check MySQL-related directories.

# ─── Define directories to audit ─────────────────────────────
# Bash array of important system directories
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var/lib" "/usr/sbin")

echo "========================================================"
echo "  Directory Audit Report"
echo "  Generated: $(date '+%d %B %Y %H:%M:%S')"
echo "========================================================"
echo ""
printf "  %-20s %-12s %-8s %-8s %s\n" "Directory" "Size" "Owner" "Group" "Permissions"
echo "  ─────────────────────────────────────────────────────"

# ─── Loop through each directory ─────────────────────────────
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using awk on ls output
        # ls -ld gives: "drwxr-xr-x 2 root root 4096 Jan 1 12:00 /etc"
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # Get human-readable size; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "  %-20s %-12s %-8s %-8s %s\n" "$DIR" "$SIZE" "$OWNER" "$GROUP" "$PERMS"
    else
        # Directory does not exist on this system
        printf "  %-20s [DOES NOT EXIST]\n" "$DIR"
    fi
done

echo ""
echo "========================================================"
echo "  MySQL-Specific Directory Check"
echo "========================================================"
echo ""

# ─── MySQL directory checks ───────────────────────────────────
# Array of MySQL-relevant paths to inspect
MYSQL_PATHS=(
    "/etc/mysql"
    "/etc/my.cnf"
    "/var/lib/mysql"
    "/var/log/mysql"
    "/run/mysqld"
    "/usr/sbin/mysqld"
)

for PATH_ITEM in "${MYSQL_PATHS[@]}"; do
    # Check for both files and directories
    if [ -e "$PATH_ITEM" ]; then
        PERMS=$(ls -ld "$PATH_ITEM" | awk '{print $1}')
        OWNER=$(ls -ld "$PATH_ITEM" | awk '{print $3}')
        GROUP=$(ls -ld "$PATH_ITEM" | awk '{print $4}')
        echo "  FOUND   : $PATH_ITEM"
        echo "            Owner: $OWNER | Group: $GROUP | Permissions: $PERMS"

        # Security note for the data directory
        if [ "$PATH_ITEM" = "/var/lib/mysql" ]; then
            echo "            NOTE: This is MySQL's data directory. It should be"
            echo "            owned by the 'mysql' user for security."
        fi
        echo ""
    else
        echo "  MISSING : $PATH_ITEM (MySQL may not be installed)"
        echo ""
    fi
done

echo "  Audit complete."
