#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Samarth Verma| Reg: 24BCE10139
# Course: Open Source Software (OSS NGMC)
# Purpose: Check if a FOSS package is installed, show its info,
#          and display a philosophy note about the software.

# ─── Configuration ───────────────────────────────────────────
# The package to inspect (MySQL server package)
PACKAGE="mysql-server"

echo "================================================"
echo "  FOSS Package Inspector"
echo "  Checking: $PACKAGE"
echo "================================================"
echo ""

# ─── Detect package manager ──────────────────────────────────
# Check which package manager is available on this system
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    echo "ERROR: No supported package manager found (rpm or dpkg)."
    exit 1
fi

echo "  Package Manager: $PKG_MANAGER"
echo ""

# ─── Check installation and display info ─────────────────────
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based system (RHEL, Fedora, CentOS)
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  STATUS: $PACKAGE IS INSTALLED"
        echo ""
        echo "  Package Details:"
        # Pipe rpm output through grep to show only key fields
        rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
            while IFS= read -r line; do echo "    $line"; done
    else
        echo "  STATUS: $PACKAGE is NOT installed."
        echo "  Install with: sudo dnf install $PACKAGE"
    fi

elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # APT-based system (Ubuntu, Debian)
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  STATUS: $PACKAGE IS INSTALLED"
        echo ""
        # Show version using dpkg-query
        VERSION=$(dpkg-query -W -f='${Version}' "$PACKAGE" 2>/dev/null)
        echo "    Version : $VERSION"
        echo "    License : GPL v2 (GNU General Public License version 2)"
        echo "    Summary : MySQL database server"
    else
        echo "  STATUS: $PACKAGE is NOT installed."
        echo "  Install with: sudo apt install $PACKAGE"
    fi
fi

echo ""
echo "================================================"
echo "  FOSS Philosophy Notes"
echo "================================================"

# ─── Case statement: philosophy notes ────────────────────────
# Match on common package names and print a philosophy note
case "$PACKAGE" in
    mysql-server|mysql|mysqld)
        echo "  MySQL: The database at the heart of the web — GPL v2"
        echo "  means the community keeps the right to study and share it."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server: Built the open internet. The Apache"
        echo "  License allows anyone to use it, even in proprietary products."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open, private web."
        echo "  Mozilla's mission proves open source can challenge corporate giants."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to stream video."
        echo "  LGPL means it can be embedded in other open or closed software."
        ;;
    git)
        echo "  Git: Linus Torvalds built this when BitKeeper's free license was"
        echo "  revoked. A reminder that open source protects us from lock-in."
        ;;
    python3|python)
        echo "  Python: Shaped entirely by community consensus. The PSF License"
        echo "  is permissive — freedom without copyleft obligations."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice when Oracle"
        echo "  acquired it. Proof that the community will fork to preserve freedom."
        ;;
    *)
        echo "  $PACKAGE: A free and open-source software package."
        echo "  Check its license at: https://spdx.org/licenses/"
        ;;
esac

echo ""
echo "  Script complete."
