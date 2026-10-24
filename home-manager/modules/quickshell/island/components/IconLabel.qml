import QtQuick
import qs.config

Text {
    property int iconSize: 20

    color: Theme.text
    font {
        family: Theme.iconFamily
        pixelSize: iconSize
        weight: Font.Medium
    }
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
