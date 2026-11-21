import QtQuick
import Quickshell
import qs.config
import qs.modules.devices as Devices
import qs.modules.general as General

PanelWindow {
    id: panel
    color: Config.barColor

    implicitHeight: Config.barHeight

    anchors {
        top: true
        left: true
        right: true
    }

    exclusiveZone: height

    Item {
        id: content
        anchors.fill: parent

        Row {
            id: leftBlocks
            spacing: 20
            anchors {
                left: content.left
                top: content.top
                bottom: content.bottom
                leftMargin: 8.0
            }

            General.Icon {}

            General.Time {}
        }

        Row {
            id: rightBlocks
            spacing: 8
            anchors {
                right: content.right
                top: content.top
                bottom: content.bottom
            }

            Devices.DeviceRow {}

            General.Language {}

            General.Power {}
        }
    }
}
