import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import qs.base as Base


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
    }

    Repeater {
        id: workspaceRepeater

        model: ScriptModel {
            values: AppSingleton.workspaceModels
            objectProp: "id"
        }

        Base.MouseRec {
            id: workspaceRec
            required property var modelData
            property bool isExists: modelData.exists
            property bool isActive: modelData.active
            property bool containApps: modelData.topLevels.length > 0

            anchors {
                top: root.top
                bottom: root.bottom
            }
            width: workspaceRow.width + 10 * 2
            height: root.height
            radius: 5

            color: {
                isExists ? (isActive ? "#0071c5" : (hovered ? "#c0003b5b" : "#2800b4d8")) : (hovered ? "#c0003b5b" : "transparent")
            }

            Row {
                id: workspaceRow

                spacing: 10
                anchors {
                    centerIn: parent
                }

                Text {
                    id: workspaceText
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                    text: modelData.special ? "S" : modelData.id
                    font.pixelSize: 24
                    font.bold: true
                    font.family: "JetBrains Mono NF"

                    color: isActive ? "#241b20" : "#00b4d8"
                }

                Rectangle {
                    id: appsRectangle

                    visible: containApps

                    color: isActive ? "#90FFFFFF" : "#50FFFFFF"

                    anchors {
                        verticalCenter: parent.verticalCenter
                    }

                    width: appsRow.width + 8 * 2
                    height: 30
                    radius: 10

                    Row {
                        id: appsRow

                        spacing: -6

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
            }

            onClicked: function() {
                if (!isActive) {
                    modelData.workspace.activate()
                }
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
    }
}
