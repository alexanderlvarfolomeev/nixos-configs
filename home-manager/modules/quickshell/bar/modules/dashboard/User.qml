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

      padding: 10
      spacing: 32

      Rectangle {
        height: userInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        // TODO: avatar

        StyledText {
          id: userInfo
          anchors {
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTextSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "User: " + SystemSingleton.user
        }
      }

      Rectangle {
        height: generalInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        StyledText {
          id: generalInfo
          anchors {
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTextSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "OS: " + SystemSingleton.osNameString + "\n" +
            "DE: " + SystemSingleton.wm
        }
      }

      Rectangle {
        height: kernelInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        StyledText {
          id: kernelInfo
          anchors {
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTextSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "Kernel: " + SystemSingleton.kernel + "\n" +
            (SystemSingleton.kernelCustom ? ("Extra: " + SystemSingleton.kernelCustom + "\n") : "")
        }
      }

      Rectangle {
        height: uptimeInfo.height + Config.userInnerVerticalPadding * 2
        width: resources.width - resources.padding * 2

        color: Config.userInnerBgColor

        radius: Config.userControlRadius

        StyledText {
          id: uptimeInfo
          anchors {
            verticalCenter: parent.verticalCenter
            leftMargin: Config.userTextSpacing
            left: parent.left
          }

          color: Config.userTextColor

          text: "Uptime: " + SystemSingleton.uptimeString
        }
      }
    }
  }
}
