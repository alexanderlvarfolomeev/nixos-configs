import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

PopupWindow {
  id: root

  property var text: ""
  property var targetItem: null
  property int anchorX: 0
  property int anchorY: 0
  property int delay: 600
  
  visible: false
  color: "transparent"

  anchor.item: targetItem
  anchor.rect.x: anchorX
  anchor.rect.y: anchorY

  Rectangle {
    id: tooltipRec

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    width: tooltipText.width + 15 * 2
    implicitHeight: tooltipText.font.pixelSize + 15 * 2
    color: "#d7241b20"
    radius: 5 

    Text {
      id: tooltipText

      anchors.centerIn: parent

      font.pixelSize: 20
      font.bold: true
      font.family: "JetBrains Mono NF"

      color: "#00b4d8"
      text: root.text
    }
  }

  Timer {
    id: tooltipTimer
    interval: root.delay
    repeat: false
    onTriggered: root.show()
  }

  function prepareToShow(target, text) {
    if (!target || !text) {
      return
    }

    tooltipTimer.stop()

    if (root.visible && target !== root.targetItem) {
      // hide
    }

    root.text = text
    root.targetItem = target

    tooltipTimer.start()
  }

  function show() {
    if (!targetItem) {
      return
    }

    const tipWidth = tooltipRec.width
    const tipHeight = tooltipRec.implicitHeight
    root.implicitWidth = tipWidth
    root.implicitHeight = tipHeight

    root.anchorX = (targetItem.width - tipWidth) / 2
    root.anchorY = targetItem.height + 5

    root.visible = true
  }

  function hide() {
    tooltipTimer.stop()
    root.visible = false
    root.text = ""
  }

  function refreshText(text) {
    if (!visible || !targetItem) {
      return
    }

    root.text = text

    const tipWidth = tooltipRec.width
    const tipHeight = tooltipRec.implicitHeight
    root.implicitWidth = tipWidth
    root.implicitHeight = tipHeight

    root.anchorX = (targetItem.width - tipWidth) / 2

    Qt.callLater(() => {
      if (root.anchor && root.visible) {
        root.anchor.updateAnchor()
      }
    })
  }
}