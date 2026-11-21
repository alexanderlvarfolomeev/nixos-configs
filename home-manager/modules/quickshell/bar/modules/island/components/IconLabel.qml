import QtQuick
import qs.base as Base
import qs.modules.island.config

Base.TextShadow {
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
