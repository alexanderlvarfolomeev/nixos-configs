# Repo-local Quickshell island

This shell is independent from `bar/` and is intentionally not autostarted. Run
it directly from the checkout for immediate QML reloads:

```sh
qs --path ~/nix/home-manager/modules/quickshell/island
```

The existing bar remains at:

```sh
qs --path ~/nix/home-manager/modules/quickshell/bar
```

IPC entry points (replace the path if the checkout lives elsewhere):

```sh
qs ipc -p ~/nix/home-manager/modules/quickshell/island call island toggle
qs ipc -p ~/nix/home-manager/modules/quickshell/island call island launcher
qs ipc -p ~/nix/home-manager/modules/quickshell/island call island settings
qs ipc -p ~/nix/home-manager/modules/quickshell/island call island close
```

The compact pill expands after a short hover delay; leaving an unpinned surface
collapses it after a grace period. In control mode, compact tiles switch Hyprland
workspaces. IPC or page navigation pins the expanded view.

## Adding a page

Add the view under `views/` and export it in that directory's `qmldir`. In
`services/PageRegistry.qml`, declare its view component and add one entry to
`entries`: a unique `key`, `title`, `icon`, `width`, `height`,
`keyboardFocus`, `view`, and `compactView`. Reuse an existing compact component
or register another one under `components/`.

The shell derives its loaders, focus policy, and backing size from that entry.
Control Center navigation also uses the registry. Open any registered page with:

```sh
qs ipc -p ~/nix/home-manager/modules/quickshell/island call island open launcher
```

`IslandController.qml` owns navigation, pinning, and hover timers. Views receive
it explicitly rather than accessing the window or its ids. `SystemState.qml`
owns shared device state and commands. Appearance changes apply for the current
session; Settings exposes only the controls currently implemented.
