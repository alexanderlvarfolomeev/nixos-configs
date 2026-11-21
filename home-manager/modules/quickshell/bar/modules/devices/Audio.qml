import qs.base
import qs.config
import qs.services as Services

StatusButton {
    background: Config.audioBgColor
    textColor: Services.Audio.sinkStateColor(Services.Audio.sink?.audio)
    text: Services.Audio.sinkStateText(Services.Audio.sink?.audio)
    onClicked: Services.Actions.toggleApplication("pavucontrol")
}
