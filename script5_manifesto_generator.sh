#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Samarth Verma| Reg: 24BCE10139
# Course: Open Source Software (OSS NGMC)
# Purpose: Generate a personalised open-source philosophy statement
#          by collecting user input and composing a reflective paragraph.

# ─── Alias concept demonstration (comment) ───────────────────
# In a live shell session, you could define a shortcut alias:
#   alias mkmanifesto='bash ./script5_manifesto_generator.sh'
# Aliases are defined in ~/.bashrc for persistence across sessions.
# They differ from scripts in that they exist only in the shell session.

echo "=================================================="
echo "   Open Source Manifesto Generator"
echo "   Answer three questions to generate your manifesto."
echo "=================================================="
echo ""

# ─── Collect user input with read -p ─────────────────────────
# The -p flag displays a prompt on the same line before reading input
read -p "  1. Name one open-source tool you use every day: " TOOL

read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

read -p "  3. Name one thing you would build and share freely: " BUILD

# ─── Validate that all inputs were provided ──────────────────
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo ""
    echo "  ERROR: All three questions must be answered."
    exit 1
fi

# ─── Prepare metadata ────────────────────────────────────────
# Capture the current date in a readable format using the date command
DATE=$(date '+%d %B %Y')
# The output filename includes the current username for personalisation
OUTPUT="manifesto_$(whoami).txt"

echo ""
echo "  Composing your manifesto..."
echo ""

# ─── Compose the manifesto paragraph ─────────────────────────
# Build the manifesto by concatenating variables into strings
# Using >> to append each line to the output file
# First, overwrite/create the file with the header using >

echo "=========================================" > "$OUTPUT"
echo "  My Open Source Manifesto"              >> "$OUTPUT"
echo "  Generated: $DATE"                      >> "$OUTPUT"
echo "  Author: $(whoami)"                     >> "$OUTPUT"
echo "=========================================" >> "$OUTPUT"
echo ""                                         >> "$OUTPUT"

# Compose the body paragraph using string concatenation
# Variables are expanded inside double quotes in bash
PARA1="Every day I rely on $TOOL — a piece of software that someone built"
PARA1="$PARA1 and chose to share with the world, not for profit, but because"
PARA1="$PARA1 knowledge grows stronger when it is given away freely."

PARA2="To me, freedom means $FREEDOM. In the context of software, that means"
PARA2="$PARA2 the right to look inside the tools I depend on, understand how they work,"
PARA2="$PARA2 and adapt them to my own needs without asking anyone's permission."

PARA3="The project I dream of building and sharing freely is $BUILD."
PARA3="$PARA3 I want to put it into the world the way MySQL, Linux, and Python were"
PARA3="$PARA3 put into the world — not locked behind a license, but open for anyone"
PARA3="$PARA3 who needs it, wherever they are."

PARA4="Open source is not just a licensing model. It is a statement about how"
PARA4="$PARA4 knowledge should work: accumulated, shared, and improved by everyone."
PARA4="$PARA4 I stand on the shoulders of giants, and I intend to add to that foundation."

# Write paragraphs to the file, each separated by a blank line
echo "$PARA1" >> "$OUTPUT"
echo ""       >> "$OUTPUT"
echo "$PARA2" >> "$OUTPUT"
echo ""       >> "$OUTPUT"
echo "$PARA3" >> "$OUTPUT"
echo ""       >> "$OUTPUT"
echo "$PARA4" >> "$OUTPUT"
echo ""       >> "$OUTPUT"
echo "=========================================" >> "$OUTPUT"

# ─── Display result ───────────────────────────────────────────
echo "  ──── Your Open Source Manifesto ────"
echo ""
# cat reads the file and prints it to stdout
cat "$OUTPUT"
echo ""
echo "  Manifesto saved to: $OUTPUT"
