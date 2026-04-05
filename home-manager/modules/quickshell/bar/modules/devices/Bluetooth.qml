import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth as BT
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.base as Base
import qs.config

Base.MouseRec {
  id: root

  anchors {
      top: parent.top
      bottom: parent.bottom
      topMargin: 2.0
      bottomMargin: 2.0
  }
  width: statusText.width + 10 * 2
  color: root.hovered ? Qt.darker("#0071c5", 1.1) : "#0071c5"

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
      default: {
        console.log(state);
        return "?";
      }
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

  Text {
      id: statusText
      anchors.centerIn: parent

      font.pixelSize: 28
      font.bold: true
      font.family: Config.fontFamily

      color: "#c6e800"
      text: root.stateIcon(adapter ? adapter.state : null)
  }
}