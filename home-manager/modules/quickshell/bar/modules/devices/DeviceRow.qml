import QtQuick


Row {
    id: root
    spacing: 2

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    Network {}

    Bluetooth {}

    Audio {}

    Battery {}
}
