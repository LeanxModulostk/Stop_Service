#!/system/bin/sh
# Stop Services - detiene los servicios de la lista (sin espera).
# El retraso de 60s en el arranque lo aplica post-fs-data.sh.
MODDIR=${0%/*}

# Si se ejecuta al arrancar (Magisk/KSU lo lanza en late_start) y el sistema
# aún no terminó de iniciar, salir: post-fs-data.sh lo llamará con retraso.
[ "$(getprop sys.boot_completed)" = "1" ] || exit 0

LIST=/data/adb/stopservices/services.list
[ -f "$LIST" ] || LIST="$MODDIR/other/services.default"

total=0
activos=0
while read -r SERVICE; do
  case "$SERVICE" in ''|'#'*) continue ;; esac
  [ "$(getprop "init.svc.$SERVICE")" = "running" ] && activos=$((activos + 1))
  stop "$SERVICE" >/dev/null 2>&1
  total=$((total + 1))
done < "$LIST"

echo "SERVICES STOPPED!"
echo "Please check on the Check List."
exit 0
