import QtQuick
import QtQuick.Controls
import Quickshell
import qs.config
import qs.utils

Rectangle {
  id: root
  color: "transparent"

  readonly property real innerRadius: 5

  Rectangle {
    id: wrapper

    color: "#0071c5"

    anchors.centerIn: parent
    implicitHeight: Config.dashboardInnerContainerRatio * parent.implicitHeight
    implicitWidth: Config.dashboardInnerContainerRatio * parent.implicitWidth

    radius: Config.dashboardBorderRadius

    Column {
      id: resources
      anchors.fill: parent

      padding: 8
      spacing: 17

      Rectangle {
        height: storageTitle.height + storage.height + 2 + 6
        width: resources.width - resources.padding * 2

        color: "#A0FFFFFF"

        radius: root.innerRadius

        Column {
          anchors.fill: parent

          spacing: 2
          padding: 5

          Text {
            id: storageTitle

            color: "black"
            font.pixelSize: 24
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: "Storage: " + ResourceSingleton.storagePercentage + "%"
          }

          Text {
            id: storage

            color: "black"
            font.pixelSize: 20
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: "Used: " + ResourceSingleton.kibToString(ResourceSingleton.storageUsed) + "\n" + 
              "Total: " + ResourceSingleton.kibToString(ResourceSingleton.storageTotal)
          }
        }
      }

      Rectangle {
        height: memoryTitle.height + memory.height + 2 + 6
        width: resources.width - resources.padding * 2

        color: "#A0FFFFFF"

        radius: root.innerRadius

        Column {
          anchors.fill: parent

          spacing: 2
          padding: 3

          Text {
            id: memoryTitle

            color: "black"
            font.pixelSize: 24
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: "Memory: " + ResourceSingleton.memoryPercentage + "%"
          }

          Text {
            id: memory

            color: "black"
            font.pixelSize: 20
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: "Used: " + ResourceSingleton.kibToString(ResourceSingleton.memoryUsed) + "\n" +
              "Size: " + ResourceSingleton.kibToString(ResourceSingleton.memoryTotal)
          }
        }
      }

      Rectangle {
        height: cpuTitle.height + cpu.height + 2 + 6
        width: resources.width - resources.padding * 2

        color: "#A0FFFFFF"

        radius: root.innerRadius

        Column {
          anchors.fill: parent

          padding: 3
          spacing: 2

          Text {
            id: cpuTitle

            color: "black"
            font.pixelSize: 24
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: "CPU: " + ResourceSingleton.cpuPercentage + "%"
          }

          Text {
            id: cpu

            color: "black"
            font.pixelSize: 20
            font.bold: true
            font.family: "JetBrains Mono NF"

            text: ResourceSingleton.cpuName
          }
        }
      }
    }
  }  
}
