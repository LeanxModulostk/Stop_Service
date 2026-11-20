#!/system/bin/sh
# Todos los daemons nativos (init) en ejecución
G="\033[1;32m"
Y="\033[1;33m"
C="\033[1;36m"
R="\033[1;31m"
W="\033[0m"

echo "${Y}NATIVE DAEMONS (INIT) IN PROGRESS:${W}"
echo "-----------------------------------"
getprop | grep '\[init\.svc\..*\]: \[running\]' | sed 's/\[init\.svc\.//g; s/\]: \[running\]//g' | sort | while read -r svc; do
    case "$svc" in
        *stats*|*trace*|*diag*|*dump*|*log*|*incident*|*perfetto*|*telemetry*)
            echo "${R}• $svc${W} <-(Telemetry/Traces/Logs)"
            ;;
        *thermal*|*orms*|*brain*)
            echo "${Y}• $svc${W} <-(Thermal Control/Performance)"
            ;;
        *)
            echo "${G}• $svc${W}"
            ;;
    esac
done
exit 0
