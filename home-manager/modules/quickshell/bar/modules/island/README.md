# Qsbar island

The island is part of qsbar and starts with it. Run the bar directly from the
checkout for immediate QML reloads:

```sh
qs --path ~/nix/home-manager/modules/quickshell/bar
```

The existing `dashboard toggle` IPC target (Super+D) also toggles the island.

IPC entry points (replace the path if the checkout lives elsewhere):

```sh
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island toggle
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island launcher
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island open media
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island open resources
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island open system
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island close
```

The island expands only through IPC. Pointer hover highlights controls and
workspace tiles but never changes the window state; moving away does not close
an expanded island. Page buttons switch the already-expanded view, and Close
collapses it. Super+D uses the existing dashboard IPC alias.

The expanded pages are Control Center, Launcher, Media, Resources, and System.
Media restores the old player panel with album art, metadata, guarded transport
controls, and player selection. Resources restores CPU, memory, and root-filesystem
usage; its sampler and storage query exist only while the page is loaded.
System restores the user/session, OS, kernel, hostname, and uptime information.

## Glass surface

The island uses a translucent blue tint (28% collapsed, 56% expanded) with native
gradient highlights and a glossy double rim. Tune these opacities in
`config/General.qml`; text and workspace tiles keep their own opacity and palette.

Background blur follows the animated rounded surface through Quickshell's
`BackgroundEffect` region. Hyprland also has a scoped `qsbar-island-glass` layer
rule in `hyprland.lua`, matching the `qsbar-island` namespace. Its alpha cutoff
leaves the fixed backing window transparent outside the island. Load the updated
Hyprland config to enable that rule. Actual blur requires a supporting compositor;
the tint and highlights still render without it. There is no screen-capture loop
or shader compilation dependency.

## Adding a page

Add the view under `views/` and export it in that directory's `qmldir`. In
`services/PageRegistry.qml`, declare its view component and add one entry to
`entries`: a unique `key`, `title`, `icon`, `width`, `height`,
`keyboardFocus`, `view`, and `compactView`. Reuse an existing compact component
or register another one under `components/`.

The shell derives its loaders, focus policy, and backing size from that entry.
The dashboard pages share a header and registry-driven navigation. Open any registered page with:

```sh
qs ipc -p ~/nix/home-manager/modules/quickshell/bar call island open launcher
```

`IslandController.qml` owns page selection and explicit open/close commands. Views receive
it explicitly rather than accessing the window or its ids. The bar's shared
`services/SystemState.qml` supplies device state and commands, and `base/` supplies
text shadows. There is no Settings page or hover-expansion state.

## Design references

The implementation stays local to this repo. The media service/view split and
capability checks follow the approach in [iNiR's media components](https://github.com/snowarch/iNiR/tree/main/modules/shared/mediaControls/components).
The resource cards and page-scoped sampling follow [Caelestia's resource dashboard](https://github.com/caelestia-dots/shell/blob/main/modules/dashboard/dash/Resources.qml).
No upstream shell or additional dependency is installed.
