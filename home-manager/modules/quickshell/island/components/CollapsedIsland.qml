import QtQuick
import qs.config

Item {
    id: root
    required property bool expanded
    property alias sourceComponent: contentLoader.sourceComponent
    readonly property int status: contentLoader.status
    readonly property Item content: contentLoader.item as Item
    implicitWidth: content ? content.implicitWidth : Theme.compactWidth
    implicitHeight: Theme.compactHeight
    visible: opacity > 0
    enabled: !expanded
    opacity: expanded ? 0 : 1
    Behavior on opacity { NumberAnimation { duration: 110 } }

    Loader {
        id: contentLoader
        anchors.fill: parent
    }
}

