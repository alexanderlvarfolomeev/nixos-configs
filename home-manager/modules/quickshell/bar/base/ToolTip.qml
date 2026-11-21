import QtQuick
import QtQuick.Controls
import qs.config

Popup {
    id: root
    property string text: ""
    property Item targetItem: null
    property int delay: 600

    parent: targetItem
    x: parent ? (parent.width - width) / 2 : 0
    y: parent ? parent.height + 5 : 0
    padding: 15
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#d7241b20"
        radius: 5
    }

    contentItem: TextShadow {
        text: root.text
        color: Config.networkTextColor
        font.family: Config.fontFamily
        font.pixelSize: Config.fontSize
        font.bold: true
    }

    Timer {
        id: showDelay
        interval: root.delay
        onTriggered: {
            if (root.targetItem && root.text) root.open();
        }
    }

    function prepareToShow(target, label) {
        hide();
        if (!target || !label) return;
        targetItem = target;
        text = label;
        showDelay.start();
    }

    function hide() {
        showDelay.stop();
        close();
    }

    function refreshText(label) {
        text = label;
    }
}
