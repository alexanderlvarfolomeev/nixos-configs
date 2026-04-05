import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "../utils" as Utils

Rectangle {
  id: root
  color: "transparent"

  readonly property real outerRadius: 10
  readonly property real innerRadius: 5

  Rectangle {
    id: wrapper

    color: "#69b1e2"

    anchors.centerIn: parent
    implicitHeight: 0.95 * parent.implicitHeight
    implicitWidth: 0.95 * parent.implicitWidth

    topLeftRadius: root.outerRadius
    topRightRadius: root.outerRadius
    bottomLeftRadius: root.outerRadius
    bottomRightRadius: root.outerRadius

    Column {
      id: resources
      anchors {
        top: parent.top
        verticalCenter: parent.verticalCenter
      }
      width: parent.implicitWidth

      padding: 8
      spacing: 75

      Rectangle {
        height: userInfo.height + 2 + 6
        width: resources.width - resources.padding * 2

        color: "#A0FFFFFF"

        topLeftRadius: root.innerRadius
        topRightRadius: root.innerRadius
        bottomLeftRadius: root.innerRadius
        bottomRightRadius: root.innerRadius

        // TODO: avatar

        Text {
          id: userInfo
          anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
          }

          color: "black"
          font.pixelSize: 20
          font.bold: true
          font.family: "JetBrains Mono NF"

          text: "User: " + Utils.SystemSingleton.user
        }
      }

      Rectangle {
        height: osInfo.height + 2 + 6
        width: resources.width - resources.padding * 2

        color: "#A0FFFFFF"

        topLeftRadius: root.innerRadius
        topRightRadius: root.innerRadius
        bottomLeftRadius: root.innerRadius
        bottomRightRadius: root.innerRadius

        Text {
          id: osInfo
          anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            

            leftMargin: 10
          }

          color: "black"
          font.pixelSize: 20
          font.bold: true
          font.family: "JetBrains Mono NF"

          text: "OS: " + Utils.SystemSingleton.osNameString + "\n" +
            "DE: " + Utils.SystemSingleton.wm + "\n" +
            "Kernel: " + Utils.SystemSingleton.kernel + "\n" +
            "Uptime: " + Utils.SystemSingleton.uptimeString
        }
      }
    }
  }
}
