#!/system/bin/sh
# Estado de los servicios de tu lista (services.list)
G="\033[1;32m"
Y="\033[1;33m"
C="\033[1;36m"
R="\033[1;31m"
W="\033[0m"

MODDIR=$(dirname "$0")/..
LIST=/data/adb/stopservices/services.list
[ -f "$LIST" ] || LIST="$MODDIR/other/services.default"

echo "${Y}SERVICE STATUS OF YOUR LIST:${W}"
echo "-----------------------------------"
act=0; det=0
while read -r s; do
    case "$s" in ''|'#'*) continue ;; esac
    status=$(getprop "init.svc.$s")
    [ -n "$status" ] || continue
    if [ "$status" = "running" ]; then
        echo "${R}[RUN]${W}   $s"
        act=$((act + 1))
    else
        echo "[STOP] $s ($status)"
        det=$((det + 1))
    fi
done < "$LIST"
echo "-----------------------------------"
echo "${G}Actives: $act | Stoppeds: $det${W}"
exit 0
