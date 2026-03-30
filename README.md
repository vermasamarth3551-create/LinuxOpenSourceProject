# oss-audit-24BCE10139

**Open Source Audit — MySQL**  
Capstone Project | Open Source Software (OSS NGMC)

---

## Student Details

| Field | Value |
|---|---|
| Name | Samarth Verma|
| Registration Number | 24BCE10139 |
| Software Audited | MySQL (Community Edition — GPL v2) |

---

## About This Project

This repository contains five shell scripts written as part of the OSS NGMC capstone project. The project is a structured audit of MySQL — examining its origin story, GPL v2 license, Linux footprint, FOSS ecosystem, and comparison with Microsoft SQL Server.

---

## Scripts

| Script | File | Description |
|---|---|---|
| 1 | `script1_system_identity.sh` | Displays a formatted system identity report: kernel version, user, distro, uptime, date/time, and OS license. |
| 2 | `script2_package_inspector.sh` | Checks if MySQL is installed, displays version/license info, and prints a philosophy note using a case statement. |
| 3 | `script3_disk_auditor.sh` | Audits permissions and disk usage of key system directories and MySQL-specific paths using a for loop. |
| 4 | `script4_log_analyzer.sh` | Reads a log file line-by-line, counts keyword occurrences, and shows the last 5 matching lines. |
| 5 | `script5_manifesto_generator.sh` | Interactive script that asks 3 questions and generates a personalised open-source philosophy statement saved to a .txt file. |

---

## How to Run Each Script on Linux

### Prerequisites

- A Linux system (Ubuntu/Debian or RHEL/Fedora/CentOS)
- Bash shell (version 4+)
- For Script 2: `dpkg` (Ubuntu) or `rpm` (RHEL) — both come pre-installed
- For Script 4: any plain text log file (e.g. `/var/log/syslog`)

### Make scripts executable

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Script 1 — System Identity Report

```bash
./script1_system_identity.sh
```

No arguments required. Displays system info including distro name, kernel, user, uptime, date/time, and the Linux kernel license.

---

### Script 2 — FOSS Package Inspector

```bash
./script2_package_inspector.sh
```

No arguments required. Checks for `mysql-server` by default. To check a different package, edit the `PACKAGE` variable at the top of the script.

---

### Script 3 — Disk and Permission Auditor

```bash
./script3_disk_auditor.sh
```

No arguments required. Audits `/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/var/lib`, `/usr/sbin` and then checks MySQL-specific paths.

> Note: Some directories (like `/var/lib/mysql`) will show as MISSING if MySQL is not installed — this is expected.

---

### Script 4 — Log File Analyzer

```bash
./script4_log_analyzer.sh /var/log/syslog error
```

**Arguments:**
- `$1` — Path to a log file (required)
- `$2` — Keyword to search for (optional, defaults to `error`)

**Examples:**
```bash
./script4_log_analyzer.sh /var/log/syslog warning
./script4_log_analyzer.sh /var/log/mysql/error.log error
./script4_log_analyzer.sh /var/log/auth.log failed
```

---

### Script 5 — Open Source Manifesto Generator

```bash
./script5_manifesto_generator.sh
```

No arguments required. The script will ask you three interactive questions. Your manifesto is saved to `manifesto_<yourusername>.txt` in the current directory.

---

## Dependencies

| Script | Dependencies |
|---|---|
| Script 1 | `uname`, `whoami`, `uptime`, `date`, `hostname` (all standard) |
| Script 2 | `dpkg` or `rpm` (pre-installed on respective distros) |
| Script 3 | `ls`, `du`, `awk`, `cut` (all standard) |
| Script 4 | `grep`, `wc`, `tail` (all standard) |
| Script 5 | `date`, `cat` (all standard) |

All dependencies come pre-installed on any standard Linux distribution. No additional packages need to be installed to run these scripts.

---

## License

This project is submitted for academic evaluation under the VITyarthi OSS NGMC course.  
The shell scripts may be freely used and adapted for educational purposes.
