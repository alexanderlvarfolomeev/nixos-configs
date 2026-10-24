import QtQuick
import QtQuick.Controls
import qs.config

Item {
    id: root

    property string icon: "volume_up"
    property string label: "Sound"
    property real value: 0
    property real from: 0
    property real to: 1
    signal valueMoved(real value)

    implicitHeight: 38

    IconLabel {
        id: glyph
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        width: 28
        text: root.icon
        iconSize: 19
        color: Theme.textMuted
    }

    Text {
        id: title
        anchors {
            left: glyph.right
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
        width: 58
        text: root.label
        color: Theme.text
        font { family: Theme.fontFamily; pixelSize: 11; weight: Font.DemiBold }
    }

    Slider {
        id: slider
        anchors {
            left: title.right
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        from: root.from
        to: root.to
        value: root.value
        onMoved: root.valueMoved(value)

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: 5
            radius: 3
            color: "#26ffffff"

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                radius: parent.radius
                color: Theme.accent
            }
        }

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: 14
            height: 14
            radius: 7
            color: Theme.text
            border.color: Theme.accent
            border.width: 2
        }
    }
}
