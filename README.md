# Stop Services!

**English** | [Español](#español)

A module that stops logging, tracing and telemetry services on Android at boot, with a WebUI to manage the list and check the result.

## Features

- Stops the services in an editable list (57 by default: `logd`, `tombstoned`, `statsd`, `traced`, `dumpstate`, `thermal-engine`, OPlus/Xiaomi telemetry services, etc.).
- Applies the list automatically ~60 seconds after boot.
- WebUI to edit the list, stop the services on demand and check the status. It has an English / Spanish switch (flag button, top right).
- The list is stored outside the module folder, so your changes survive module updates.

## Requirements

- Magisk v20.4+ or KernelSU (with WebUI support), root access.

## Installation

1. Download `Stop_Services_v*.zip`.
2. Flash it in Magisk / KernelSU Manager and reboot.
3. Open the module's WebUI from the manager.

## WebUI

| Button | What it does |
|---|---|
| **STOP SERVICES!** | Stops every service in your list right now, without waiting for the boot delay. Pending changes from the editor are saved first. |
| **Edit Services** | Expandable editor. Add services with the input box, remove them with the **×** on each chip, then press **Save**. **Restore default** goes back to the module's original list. |
| **Check List** | Shows the state (running / stopped) of every service in your list. |
| **Active Services** | Lists all native init services currently running. Telemetry/log services are highlighted in red, thermal/performance ones in yellow. |
| **Check RAM** | Shows the top 15 processes by RAM usage (KB) with their names. |
| **Show Info** | Short in-app description of each button. |
| **Flag button** (top right) | Switches the WebUI language between English (default) and Spanish. The choice is remembered. |
| **Round floating button** | Opens the support channel on Telegram (t.me/modulostk). |

Results of the check buttons and of STOP SERVICES! are printed in the log window at the top. The output of the check scripts is always shown in its original language.

Service names may only contain letters, numbers, `.`, `_` and `-`.

## How it works

- `post-fs-data.sh` starts a background task that waits 60 seconds and until `sys.boot_completed` is `1`, then runs `service.sh`. It runs in the background so it never blocks the boot.
- `service.sh` reads the list and runs `stop <service>` for each entry. If it is launched by Magisk/KernelSU before the system finished booting, it exits immediately (the delayed call from `post-fs-data.sh` does the real work).
- The list lives in `/data/adb/stopservices/services.list` (one service per line, lines starting with `#` are ignored). It is created from `other/services.default` on first install. If the file is missing, `service.sh` falls back to the default list.
- You can also edit the list by hand or from a terminal; the WebUI reads the same file.

## Warning

Some services in the default list are not only loggers. For example, `thermal-engine` handles thermal management, and stopping it can disable thermal throttling on some devices. Review the list before using the module and remove anything you do not want stopped. Stopped services come back after a reboot unless the module applies the list again, so disabling or uninstalling the module restores the normal behavior.

## Extras
- Donations: [PayPal](https://www.paypal.me/LeanHijosdesusMadres) - [LiberaPay](https://liberapay.com/LeanHijosdesusMadres) - [Ko-fi](https://ko-fi.com/leantupapi) - [Binance](https://app.binance.com/qr/dplk7b28e9c123ff4e378b472505b0adba63) - [SociaBuzz](https://sociabuzz.com/leanhijosdesusmadres/support) - [More](https://t.me/modulemagiskChiase/4846)
- Support: [Telegram](https://t.me/modulostk)

---

# Español

[English](#stop-services) | **Español**

Módulo que detiene servicios de logs, tracing y telemetría de Android al arrancar, con un WebUI para administrar la lista y comprobar el resultado.

## Características

- Detiene los servicios de una lista editable (57 por defecto: `logd`, `tombstoned`, `statsd`, `traced`, `dumpstate`, `thermal-engine`, servicios de telemetría de OPlus/Xiaomi, etc.).
- Aplica la lista automáticamente ~60 segundos después del arranque.
- WebUI para editar la lista, detener los servicios cuando quieras y comprobar su estado. Incluye un cambio de idioma inglés / español (botón con bandera, arriba a la derecha).
- La lista se guarda fuera de la carpeta del módulo, así que tus cambios sobreviven a las actualizaciones.

## Requisitos

- Magisk v20.4+ o KernelSU (con soporte de WebUI), acceso root.

## Instalación

1. Descarga `Stop_Services_v*.zip`.
2. Instálalo en Magisk / KernelSU Manager y reinicia.
3. Abre el WebUI del módulo desde el gestor.

## WebUI

| Botón | Qué hace |
|---|---|
| **STOP SERVICES!** | Detiene ahora mismo todos los servicios de tu lista, sin esperar el retraso del arranque. Antes guarda los cambios pendientes del editor. |
| **Editar servicios** | Editor desplegable. Agrega servicios con el cuadro de texto, quítalos con la **×** de cada chip y pulsa **Guardar**. **Restaurar lista** vuelve a la lista original del módulo. |
| **Ver lista** | Muestra el estado (corriendo / detenido) de cada servicio de tu lista. |
| **Servicios activos** | Lista todos los servicios nativos de init que están corriendo. Los de telemetría/logs se resaltan en rojo y los de térmica/rendimiento en amarillo. |
| **Ver RAM** | Muestra los 15 procesos que más RAM usan (KB) con sus nombres. |
| **Ver info** | Descripción corta dentro de la app de cada botón. |
| **Botón con bandera** (arriba a la derecha) | Cambia el idioma del WebUI entre inglés (por defecto) y español. Se recuerda la elección. |
| **Botón flotante redondo** | Abre el canal de soporte en Telegram (t.me/modulostk). |

Los resultados de los botones de comprobación y de STOP SERVICES! se muestran en la ventana de log de arriba. La salida de los scripts de comprobación siempre se muestra en su idioma original.

Los nombres de servicio solo pueden contener letras, números, `.`, `_` y `-`.

## Cómo funciona

- `post-fs-data.sh` inicia una tarea en segundo plano que espera 60 segundos y hasta que `sys.boot_completed` sea `1`, y entonces ejecuta `service.sh`. Corre en segundo plano, así que nunca bloquea el arranque.
- `service.sh` lee la lista y ejecuta `stop <servicio>` por cada entrada. Si Magisk/KernelSU lo lanza antes de que el sistema termine de arrancar, sale de inmediato (el trabajo real lo hace la llamada con retraso de `post-fs-data.sh`).
- La lista está en `/data/adb/stopservices/services.list` (un servicio por línea; las líneas que empiezan con `#` se ignoran). Se crea a partir de `other/services.default` en la primera instalación. Si el archivo no existe, `service.sh` usa la lista por defecto.
- También puedes editar la lista a mano o desde una terminal; el WebUI lee el mismo archivo.

## Advertencia

Algunos servicios de la lista por defecto no son solo de logs. Por ejemplo, `thermal-engine` gestiona la térmica y detenerlo puede desactivar el control de temperatura en algunos dispositivos. Revisa la lista antes de usar el módulo y quita lo que no quieras detener. Los servicios detenidos vuelven tras reiniciar a menos que el módulo aplique la lista otra vez, por lo que desactivar o desinstalar el módulo restaura el comportamiento normal.

## Extras
- Donaciones: [PayPal](https://www.paypal.me/LeanHijosdesusMadres) - [LiberaPay](https://liberapay.com/LeanHijosdesusMadres) - [Ko-fi](https://ko-fi.com/leantupapi) - [Binance](https://app.binance.com/qr/dplk7b28e9c123ff4e378b472505b0adba63) - [SociaBuzz](https://sociabuzz.com/leanhijosdesusmadres/support) - [Más](https://t.me/modulemagiskChiase/4846)
- Soporte: [Telegram](https://t.me/modulostk)
