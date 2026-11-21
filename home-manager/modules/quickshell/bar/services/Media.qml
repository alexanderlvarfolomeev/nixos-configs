pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    readonly property var players: Mpris.players.values
    property var selected: null
    readonly property var active: players.includes(selected) ? selected
        : players.find(player => player.isPlaying) ?? players[0] ?? null
    readonly property string title: active ? (active.trackTitle || "Unknown track") : "Nothing playing"
    readonly property string artist: active?.trackArtist ?? ""
    readonly property string album: active?.trackAlbum ?? ""
    readonly property string artUrl: active?.trackArtUrl ?? ""

    function select(player) { if (players.includes(player)) selected = player; }
    function previous() { if (active?.canGoPrevious) active.previous(); }
    function toggle() { if (active?.canTogglePlaying) active.togglePlaying(); }
    function next() { if (active?.canGoNext) active.next(); }
}
