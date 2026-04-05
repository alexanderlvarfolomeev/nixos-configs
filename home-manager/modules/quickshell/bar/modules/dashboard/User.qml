import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.base
import qs.config
import qs.modules.common

Rectangle {
  id: root
  color: "transparent"

  Rectangle {
    id: wrapper

    color: Config.userBgColor

    anchors.centerIn: parent
    implicitHeight: Config.dashboardInnerContainerRatio * parent.implicitHeight
    implicitWidth: Config.dashboardInnerContainerRatio * parent.implicitWidth

    radius: Config.dashboardBorderRadius

    Column {
      id: resources
      anchors {
        top: parent.top
        verticalCenter: parent.verticalCenter
      }
      width: parent.implicitWidth

      padding: 8
      spacing: 78

      Rectangle {
        height: userInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        // TODO: avatar

        StyledText {
          id: userInfo
          anchors{
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTitleSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "User: " + SystemSingleton.user
        }
      }

      Rectangle {
        height: osInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        StyledText {
          id: osInfo
          anchors{
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTitleSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "OS: " + SystemSingleton.osNameString + "\n" +
            "DE: " + SystemSingleton.wm + "\n" +
            "Kernel: " + SystemSingleton.kernel + "\n" +
            "Uptime: " + SystemSingleton.uptimeString
        }
      }
    }
  }
}
