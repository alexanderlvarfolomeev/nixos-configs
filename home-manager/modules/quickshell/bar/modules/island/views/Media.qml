pragma ComponentBehavior: Bound

import QtQuick
import qs.base as Base
import qs.services as Services
import qs.modules.island.components
import qs.modules.island.config

PageFrame {
    id: root
    title: "Media"
    subtitle: Services.Media.active?.identity ?? "MPRIS players"

    Column {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 120
            height: 120
            radius: 20
            color: Theme.raised
            clip: true
            Image {
                id: artwork
                anchors.fill: parent
                source: Services.Media.artUrl
                sourceSize { width: 240; height: 240 }
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                visible: status === Image.Ready
            }
            IconLabel {
                anchors.centerIn: parent
                text: "music_note"
                iconSize: 48
                color: Theme.accent
                visible: artwork.status !== Image.Ready
            }
        }

        Base.TextShadow {
            width: parent.width
            text: Services.Media.title
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            color: Theme.text
            font { family: Theme.fontFamily; pixelSize: 16; weight: Font.DemiBold }
        }
        Base.TextShadow {
            width: parent.width
            text: Services.Media.active ? (Services.Media.artist || "Unknown artist") : "Start a player to see its controls here"
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            color: Theme.textMuted
            font { family: Theme.fontFamily; pixelSize: 11 }
        }
        Base.TextShadow {
            width: parent.width
            text: Services.Media.album
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            color: Theme.textMuted
            font { family: Theme.fontFamily; pixelSize: 10 }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 14
            IconButton {
                icon: "skip_previous"
                enabled: Services.Media.active?.canGoPrevious ?? false
                opacity: enabled ? 1 : 0.35
                onClicked: Services.Media.previous()
            }
            IconButton {
                icon: Services.Media.active?.isPlaying ? "pause" : "play_arrow"
                checked: true
                buttonSize: 40
                enabled: Services.Media.active?.canTogglePlaying ?? false
                opacity: enabled ? 1 : 0.35
                onClicked: Services.Media.toggle()
            }
            IconButton {
                icon: "skip_next"
                enabled: Services.Media.active?.canGoNext ?? false
                opacity: enabled ? 1 : 0.35
                onClicked: Services.Media.next()
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 6
            Repeater {
                model: Services.Media.players
                IconButton {
                    required property var modelData
                    icon: "music_note"
                    tooltip: modelData.identity
                    checked: modelData === Services.Media.active
                    buttonSize: 28
                    onClicked: Services.Media.select(modelData)
                }
            }
        }
    }
}
