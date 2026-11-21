import Quickshell.Services.UPower
import qs.base
import qs.config
import qs.services as Services

StatusButton {
    id: root
    background: Config.batteryBgColor
    textColor: Config.batteryTextColor
    text: Services.Battery.batteryStateText(UPower.displayDevice.state, UPower.displayDevice.percentage)
    topRightRadius: height / 2
    bottomRightRadius: height / 2
    rightPadding: 8
    onEntered: tooltip.prepareToShow(root, Services.Battery.tooltipText())
    onExited: tooltip.hide()
    ToolTip { id: tooltip }
}
