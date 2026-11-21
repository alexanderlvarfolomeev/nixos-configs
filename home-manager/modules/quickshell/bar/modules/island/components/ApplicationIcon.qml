import QtQuick

Item {
    id: root
    required property string source
    width: 20
    height: 20

    Image {
        id: image
        anchors.fill: parent
        source: root.source
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectFit
        visible: status === Image.Ready
    }

    IconLabel {
        anchors.fill: parent
        text: "apps"
        iconSize: 18
        visible: image.status !== Image.Ready
    }
}
