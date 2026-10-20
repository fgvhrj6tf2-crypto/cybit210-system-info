#!/bin/bash

# CYBIT210 Module 8 - System Information Script

REPORT="$HOME/system-info.txt"

{
echo "===== SYSTEM INFORMATION ====="
echo "Hostname: $(hostname)"
echo "Operating System: $(. /etc/os-release; echo "$PRETTY_NAME")"
echo "System Uptime: $(uptime -p)"
echo "Linux Kernel Version: $(uname -r)"

echo ""
echo "===== CPU INFORMATION ====="
lscpu

echo ""
echo "===== MEMORY INFORMATION ====="
free -h

echo ""
echo "===== NETWORK INFORMATION ====="
ip address show

echo ""
echo "===== FILESYSTEM INFORMATION ====="
df -hT

echo ""
echo "===== LAST FIVE SYSTEM LOG ERRORS ====="
if [ -r /var/log/syslog ]; then
    grep -i "error" /var/log/syslog | tail -n 5
else
    journalctl --no-pager 2>/dev/null | grep -i "error" | tail -n 5
fi

} > "$REPORT"

cat "$REPORT"
echo "Report saved to: $REPORT"
