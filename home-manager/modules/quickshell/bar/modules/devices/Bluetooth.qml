import Quickshell
import Quickshell.Bluetooth as BT
import QtQuick
import qs.base
import qs.config

MouseRec {
  id: root

  anchors {
      top: parent.top
      bottom: parent.bottom
      topMargin: 2.0
      bottomMargin: 2.0
  }
  width: statusText.width + 10 * 2
  color: root.hovered ? Qt.darker(Config.bluetoothBgColor, 1.1) : Config.bluetoothBgColor

  property var adapter: BT.Bluetooth.defaultAdapter
  readonly property bool enabled: adapter ? adapter.enabled : false
  readonly property var devices: []

  function stateIcon(state): string {
    switch (state) {
      case BT.BluetoothAdapterState.Disabled: return "\udb80\udcb2"; // 󰂲
      case BT.BluetoothAdapterState.Enabled: return "\udb80\udcaf"; // 󰂯
      case BT.BluetoothAdapterState.Enabling: return "\udb80\udcb1"; // 󰂱
      case BT.BluetoothAdapterState.Disabling: return "\udb80\udcb1"; // 󰂱
      case BT.BluetoothAdapterState.Blocked: return "\uf293"; // 
      default: return "?";
    }
  }

  function toggleAdapter() {
    if (adapter.state == BT.BluetoothAdapterState.Blocked) {
      console.log("Attempt to change blocked adapter state")
    }
    if (adapter.state == BT.BluetoothAdapterState.Enabled) {
      Quickshell.execDetached(["bluetoothctl", "power", "off"])
    }
    if (adapter.state == BT.BluetoothAdapterState.Disabled) {
      Quickshell.execDetached(["bluetoothctl", "power", "on"])
    }
  }

  function openUI() {
    Quickshell.execDetached(["xdg-terminal-exec", "bluetui"])
  }

  onClicked: (mouse) => {
    if (mouse.wasHeld) {
      openUI()
    } else {
      if (adapter) { toggleAdapter() }
    }
  }

  StyledText {
      id: statusText
      anchors.centerIn: parent

      font.pixelSize: Config.bluetoothFontSize

      color: Config.bluetoothTextColor
      text: root.stateIcon(adapter ? adapter.state : null)
  }
}
