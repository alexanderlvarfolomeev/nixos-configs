import Quickshell
import Quickshell.Bluetooth as BT
import qs.base
import qs.config
import qs.services

StatusButton {
    background: Config.bluetoothBgColor
    textColor: Config.bluetoothTextColor
    textSize: Config.bluetoothFontSize
    text: stateIcon(SystemState.bluetoothAdapter?.state)

    function stateIcon(state): string {
        switch (state) {
        case BT.BluetoothAdapterState.Disabled: return "\udb80\udcb2";
        case BT.BluetoothAdapterState.Enabled: return "\udb80\udcaf";
        case BT.BluetoothAdapterState.Enabling:
        case BT.BluetoothAdapterState.Disabling: return "\udb80\udcb1";
        case BT.BluetoothAdapterState.Blocked: return "\uf293";
        default: return "?";
        }
    }

    onClicked: mouse => {
        if (!mouse.wasHeld) SystemState.toggleBluetooth();
    }
    onPressAndHold: Quickshell.execDetached(["xdg-terminal-exec", "bluetui"])
}
