import qs.base
import qs.config
import qs.services as Services

StatusButton {
    background: Config.networkBgColor
    textColor: Config.networkTextColor
    text: Services.Network.networkStateText(Services.Network.state, Services.Network.network, Services.Network.rssi)
    topLeftRadius: height / 2
    bottomLeftRadius: height / 2
    leftPadding: 8
    onClicked: Services.Actions.toggleApplication("iwgtk")
}
