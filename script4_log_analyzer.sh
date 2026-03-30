#!/bin/bash
# Script 4: Log File Analyzer
# Author: Samarth Verma| Reg: 24BCE10139
# Course: Open Source Software (OSS NGMC)
# Purpose: Read a log file line-by-line, count keyword occurrences,
#          and display a summary with the last 5 matching lines.
# Usage: ./log_analyzer.sh /path/to/logfile [keyword]

# ─── Command-line arguments ───────────────────────────────────
# $1 is the first argument: path to the log file
LOGFILE=$1
# $2 is optional: the keyword to search for. Default is "error"
KEYWORD=${2:-"error"}

echo "================================================"
echo "  Log File Analyzer"
echo "  File   : ${LOGFILE:-[not specified]}"
echo "  Keyword: $KEYWORD"
echo "================================================"
echo ""

# ─── Validate input ───────────────────────────────────────────
# Check that a filename was actually provided
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# Check that the file exists
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File not found: $LOGFILE"
    echo "  Common MySQL log locations:"
    echo "    /var/log/mysql/error.log     (Ubuntu/Debian)"
    echo "    /var/log/mysqld.log           (RHEL/Fedora)"
    exit 1
fi

# ─── Retry logic for empty file ──────────────────────────────
# Do-while style: check file size, wait and retry once if empty
ATTEMPT=0
MAX_ATTEMPTS=2
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    ATTEMPT=$((ATTEMPT + 1))
    if [ ! -s "$LOGFILE" ]; then
        # -s checks if file has size > 0
        if [ $ATTEMPT -lt $MAX_ATTEMPTS ]; then
            echo "  WARNING: Log file is empty. Waiting 2 seconds and retrying..."
            sleep 2
        else
            echo "  WARNING: Log file is empty after retry. No lines to process."
            exit 0
        fi
    else
        # File has content, break out of retry loop
        break
    fi
done

# ─── Count keyword occurrences with while read loop ──────────
COUNT=0           # Counter variable initialised to zero

# Read file line by line; IFS= preserves leading whitespace
while IFS= read -r LINE; do
    # Case-insensitive grep check using -i flag
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))         # Increment counter
    fi
done < "$LOGFILE"   # Redirect file as input to the while loop

# ─── Summary output ───────────────────────────────────────────
TOTAL_LINES=$(wc -l < "$LOGFILE")
echo "  Total lines in file : $TOTAL_LINES"
echo "  Lines with '$KEYWORD' : $COUNT"

if [ $TOTAL_LINES -gt 0 ]; then
    # Calculate percentage using bash arithmetic (integer only)
    PERCENT=$(( COUNT * 100 / TOTAL_LINES ))
    echo "  Match percentage    : ${PERCENT}%"
fi

echo ""
echo "  ─── Last 5 matching lines ───────────────────────"
# Use grep with -i (case-insensitive) and pipe to tail for last 5
LAST_MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)
if [ -n "$LAST_MATCHES" ]; then
    echo "$LAST_MATCHES" | while IFS= read -r line; do
        echo "    $line"
    done
else
    echo "    (no matches found)"
fi

echo ""
echo "  Analysis complete."
