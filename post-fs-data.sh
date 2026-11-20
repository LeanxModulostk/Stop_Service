#!/system/bin/sh
MODDIR=${0%/*}

# Retraso de 60s en segundo plano (un sleep directo aquí bloquearía el arranque)
(
  sleep 60
  until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 5; done
  sh "$MODDIR/service.sh"
) >/dev/null 2>&1 &

exit 0
