# Qsbar

Run directly from the checkout for hot reloads:

```sh
qs --path ~/nix/home-manager/modules/quickshell/bar
```

`shell.qml` starts one `components/BarPanel.qml` per monitor and the island.
`base/` contains shared text, pointer, status-button, and tooltip components.
`services/` contains the shared clock, keyboard, audio, Bluetooth/control state,
network status, desktop-icon resolver, media players, and application actions.
These singletons are shared by every monitor and by the island.
Resource and uptime sampling are owned by their loaded pages and stop on unload;
views do not duplicate keyboard discovery or device services.

`modules/devices/` and `modules/general/` contain the bar widgets.
`config/Config.qml` owns the bar palette and sizing; the island theme reuses
those palette values. See [the island documentation](modules/island/README.md)
for its page registry and IPC interface. The existing `dashboard toggle` IPC
target remains an alias for the island toggle.

The IWD and XKB helper scripts remain under `scripts/`; their paths resolve
relative to this config root.

## Smoke check

With Quickshell installed, run the alternate entry point:

```sh
QT_QPA_PLATFORM=offscreen qs --path ~/nix/home-manager/modules/quickshell/bar/smoke.qml
```

It loads the bar widgets and every island page, checks shared keyboard mappings,
click/hold signals, Bluetooth interactivity, IPC-only expansion, resource parsing,
and the tooltip. Success prints
`QSBAR_REFACTOR_CHECK_OK`. The check exits without starting a layer-shell bar.
On a container without desktop services, missing Hyprland, DBus, PipeWire, and
helper-command messages are expected; real device interaction and Wayland
placement still require a desktop session.

The optional pointer check (requires QtTest) sends real Qt mouse-move events to
an empty workspace tile and verifies its hover color and restoration on exit:

```sh
QT_QPA_PLATFORM=offscreen qs --path ~/nix/home-manager/modules/quickshell/bar/workspace-hover-smoke.qml
```
