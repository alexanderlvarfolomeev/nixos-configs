import QtQuick
import qs.config

Item {
    implicitWidth: workspaceStrip.implicitWidth + 24
    implicitHeight: Theme.compactHeight

    Flickable {
        anchors { fill: parent; leftMargin: 12; rightMargin: 12; topMargin: 2; bottomMargin: 2 }
        contentWidth: workspaceStrip.width
        contentHeight: height
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Workspaces {
            id: workspaceStrip
            height: parent.height
        }
    }

}
