pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
  id: root

  readonly property var players: Mpris.players.values
  readonly property var active: players.find(p => p.isPlaying) ?? players[0] ?? null
  readonly property bool hasPrevious: active?.canGoPrevious == true
  readonly property bool hasNext: active?.canGoNext == true
  readonly property bool isPlaying: active?.isPlaying == true
  readonly property string title: (active?.trackTitle ?? "No media") || "Unknown"
  readonly property string artist: (active?.trackArtist ?? "-") || "Unknown"
  readonly property string album: (active?.trackAlbum ?? "-") || "Unknown"
  readonly property string artUrl: active?.trackArtUrl ?? ""

  function toggle() {
    const active = root.active;
    if (active?.canTogglePlaying) {
      active.togglePlaying()
    }
  }

  function stop() {
    const active = root.active;
    if (active?.canControl) {
      active?.stop();
    }
  }

  function previous() {
    const active = root.active;
    if (active?.canGoPrevious) {
      active.previous();
    }
  }

  function next() {
    const active = root.active;
    if (active?.canGoNext) {
      active.next();
    }
  }
}