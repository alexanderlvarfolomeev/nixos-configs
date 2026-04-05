import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
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
        // Layout.fillHeight: true
    }

    Repeater {
        id: workspaceRepeater

        model: AppSingleton.workspaceModels

        property bool hoverUnlocked: false
        property var timer: Timer {
            interval: 100
            running: false
            repeat: false
            onTriggered: workspaceRepeater.hoverUnlocked = true
        }

        onModelChanged: {
            workspaceRepeater.hoverUnlocked = false
            workspaceRepeater.timer.start()
        }

        Base.MouseRec {
            id: workspaceRec
            required property var modelData
            property bool isExists: modelData.exists
            property bool isActive: modelData.active
            property bool containApps: modelData.topLevels.length > 0

            extraHoveredCondition: workspaceRepeater.hoverUnlocked

            anchors {
                top: root.top
                bottom: root.bottom
            }
            width: workspaceRow.width + 10 * 2
            height: root.height
            radius: 5
            // TODO: make it work
            // Layout.rightMargin: modelData.special ? 10.0 : 0.0

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
                    // Layout.alignment: Qt.AlignBaseline
                    // center the bar in its parent component (the window)
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                    text: modelData.special ? "S" : modelData.id 
                    font.pixelSize: 24
                    font.bold: true
                    font.family: "JetBrains Mono NF"

                    color: isActive ? "#241b20" : "#00b4d8"
                }

                // Rectangle {
                //     anchors {
                //         top: parent.top
                //         bottom: parent.bottom
                //     }
                //     visible: containApps
                //     implicitWidth: 2
                //     color: isActive ? "#241b20" : "#00b4d8"
                // }

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

            // Rectangle {
            //     id: appsRectangle

            //     color: isActive ? "#90FFFFFF" : "#40FFFFFF"

            //     anchors {
            //         bottom: parent.bottom
            //         bottomMargin: 2
            //         left: workspaceText.right
            //         // right: parent.right
            //         leftMargin: 4
            //         rightMargin: 4
            //     }

            //     width: appsRow.width + 8 * 2
            //     height: 24
            //     radius: 12

            //     visible: containApps

            //     Row {
            //         id: appsRow

            //         spacing: -6

            //         anchors {
            //             centerIn: parent
            //         }

            //         Repeater {
            //             id: appsRepeater

            //             model: modelData.topLevels

            //             IconImage {
            //                 id: appIcon
            //                 required property string modelData

            //                 implicitSize: 20
            //                 source: Quickshell.iconPath(AppSingleton.guessIcon(modelData))
            //             }
            //         }
            //     }
            // }
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
