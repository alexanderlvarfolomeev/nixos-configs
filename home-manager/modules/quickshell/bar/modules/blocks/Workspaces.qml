import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts


Row {
    id: root
    spacing: 3

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        implicitWidth: 5
        color: "#0071c5"
        // Layout.fillHeight: true
    }

    Repeater {
        model: AppSingleton.workspaceModels
        Rectangle {
            required property var modelData
            property bool isExists: modelData.exists
            property bool isActive: modelData.active
            property bool containApps: modelData.topLevels.length > 0

            anchors {
                top: root.top
                bottom: root.bottom
            }
            width: containApps ? appsRectangle.width + workspaceText.width + 18 : (workspaceText.width + 10 * 2)
            height: root.height
            radius: 5
            // TODO: make it work
            // Layout.rightMargin: modelData.special ? 10.0 : 0.0

            color: isExists ? (isActive ? "#0071c5" : "#2800b4d8") : "transparent"

            Rectangle {
                id: appsRectangle

                color: isActive ? "#90FFFFFF" : "#40FFFFFF"

                anchors {
                    bottom: parent.bottom
                    left: workspaceText.right
                    // right: parent.right
                    leftMargin: 4
                    rightMargin: 4
                }

                width: appsRow.width + 8 * 2
                height: 24
                radius: 12

                visible: containApps

                Row {
                    id: appsRow
                    spacing: 0

                    anchors {
                        centerIn: parent
                    }

                    Repeater {
                        id: appsRepeater

                        model: modelData.topLevels

                        IconImage {
                            id: appIcon
                            required property string modelData

                            implicitSize: 20
                            source: Quickshell.iconPath(AppSingleton.guessIcon(modelData))
                        }
                    }
                }
            }

            Text {
                id: workspaceText
                // Layout.alignment: Qt.AlignBaseline
                // center the bar in its parent component (the window)
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                }
                text: modelData.special ? "S" : modelData.id 
                font.pixelSize: 24
                font.bold: true
                font.family: "JetBrains Mono NF"

                color: isActive ? "#241b20" : "#00b4d8"
            }
        }
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        implicitWidth: 5
        color: "#0071c5"
        // Layout.fillHeight: true
    }
}
