import QtQuick
import QtQuick.Controls
import Quickshell
import qs.base
import qs.config
import qs.utils

Rectangle {
  id: root
  color: "transparent"

  Rectangle {
    id: wrapper

    color: Config.resourcesBgColor

    anchors.centerIn: parent
    implicitHeight: Config.dashboardInnerContainerRatio * parent.implicitHeight
    implicitWidth: Config.dashboardInnerContainerRatio * parent.implicitWidth

    radius: Config.dashboardBorderRadius

    Column {
      id: resources
      anchors.fill: parent

      padding: 8
      spacing: 20

      Rectangle {
        height: storageTitle.height + storage.height + Config.resourcesInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.resourcesInnerBgColor

        radius: Config.resourcesControlRadius

        Column {
          anchors.fill: parent

          spacing: 2
          padding: 5

          StyledText {
            id: storageTitle

            color: Config.resourcesTextColor
            font.pixelSize: Config.resourcesTitleFontSize

            text: "Storage: " + ResourceSingleton.storagePercentage + "%"
          }

          StyledText {
            id: storage

            color: Config.resourcesTextColor

            text: "Used: " + ResourceSingleton.kibToString(ResourceSingleton.storageUsed) + "\n" + 
              "Total: " + ResourceSingleton.kibToString(ResourceSingleton.storageTotal)
          }
        }
      }

      Rectangle {
        height: memoryTitle.height + memory.height + Config.resourcesInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.resourcesInnerBgColor

        radius: Config.resourcesControlRadius

        Column {
          anchors.fill: parent

          spacing: 2
          padding: 3

          StyledText {
            id: memoryTitle

            color: Config.resourcesTextColor
            font.pixelSize: Config.resourcesTitleFontSize

            text: "Memory: " + ResourceSingleton.memoryPercentage + "%"
          }

          StyledText {
            id: memory

            color: Config.resourcesTextColor

            text: "Used: " + ResourceSingleton.kibToString(ResourceSingleton.memoryUsed) + "\n" +
              "Size: " + ResourceSingleton.kibToString(ResourceSingleton.memoryTotal)
          }
        }
      }

      Rectangle {
        height: cpuTitle.height + cpu.height + Config.resourcesInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.resourcesInnerBgColor

        radius: Config.resourcesControlRadius

        Column {
          anchors.fill: parent

          padding: 3
          spacing: 2

          StyledText {
            id: cpuTitle

            color: Config.resourcesTextColor
            font.pixelSize: Config.resourcesTitleFontSize

            text: "CPU: " + ResourceSingleton.cpuPercentage + "%"
          }

          StyledText {
            id: cpu

            color: Config.resourcesTextColor

            text: ResourceSingleton.cpuName
          }
        }
      }
    }
  }  
}
