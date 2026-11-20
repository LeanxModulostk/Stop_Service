#!/system/bin/sh
# Top 15 procesos por consumo de RAM
G="\033[1;32m"
Y="\033[1;33m"
C="\033[1;36m"
R="\033[1;31m"
W="\033[0m"

echo "${Y}TOP 15 PROCESSES"
echo "CONSUMING THE MOST MEMORY:${W}"
echo "-----------------------------------"
printf "%-10s %s\n" "RAM (KB)" "NAME"
ps -eo rss,args 2>/dev/null | tail -n +2 | sort -n -r | head -n 15 | awk '{n=split($2,a,"/"); printf "%-10s %s\n", $1, a[n]}'
exit 0
