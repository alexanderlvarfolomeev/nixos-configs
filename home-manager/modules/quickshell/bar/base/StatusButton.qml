import QtQuick

MouseRec {
    id: root
    property alias text: label.text
    property alias textColor: label.color
    property alias textSize: label.font.pixelSize
    property alias leftPadding: label.leftPadding
    property alias rightPadding: label.rightPadding
    property color background: "transparent"

    anchors {
        top: parent.top
        bottom: parent.bottom
        topMargin: 2
        bottomMargin: 2
    }
    width: label.implicitWidth + 20
    color: hovered ? Qt.darker(background, 1.1) : background

    StyledText {
        id: label
        anchors.centerIn: parent
    }
}
