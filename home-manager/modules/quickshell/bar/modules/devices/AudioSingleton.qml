pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../utils"

Singleton {
    id: root

    property string mutedEmoji: ""
    property var volumeEmoji: ["", ""]

    property string mutedColor: "#cc241d"
    property string onColor: "#c6e800"
    property string placeholderColor: "transparent"

    property PwNode sink: Pipewire.defaultAudioSink

    function sinkStateColor(audio: PwNodeAudio): string {
        if (!audio) {
            return placeholderColor
        }
        if (audio.muted) {
            return mutedColor
        } else {
            return onColor
        }
    }

    function sinkStateText(audio: PwNodeAudio): string {
        if (!audio) {
            return ""
        }
        if (audio.muted) {
            return mutedEmoji
        }

        return Visualization.getBinValue(volumeEmoji, audio.volume) + " " + Math.round(100 * audio.volume) + "%"
    }

    PwObjectTracker {
        objects: [ sink ]
    }
}