import QtQuick
import qs.components
import qs.config

Item {
    id: root

    required property var controller
    property string selectedSection: "Control Center"
    readonly property var sections: [
        { icon: "view_day", name: "Bar & Island" },
        { icon: "music_note", name: "Media" },
        { icon: "schedule", name: "Clock & Date" },
        { icon: "palette", name: "Appearance" },
        { icon: "animation", name: "Motion" },
        { icon: "search", name: "Launcher" },
        { icon: "notifications", name: "Notifications" },
        { icon: "tune", name: "Control Center" },
        { icon: "lock", name: "Lock Screen" },
        { icon: "memory", name: "System" }
    ]

    Row {
        anchors.fill: parent

        Rectangle {
            width: 190
            height: parent.height
            color: "#b50b0d12"

            Column {
                anchors {
                    fill: parent
                    margins: 12
                }
                spacing: 5

                Text {
                    width: parent.width
                    height: 32
                    text: "Island settings"
                    color: Theme.text
                    verticalAlignment: Text.AlignVCenter
                    font { family: Theme.fontFamily; pixelSize: 15; weight: Font.DemiBold }
                }

                Repeater {
                    model: root.sections

                    delegate: Rectangle {
                        id: navItem
                        required property var modelData

                        width: parent.width
                        height: 36
                        radius: 11
                        color: root.selectedSection === modelData.name
                            ? Theme.accentSoft
                            : (navPointer.hovered ? Theme.raisedHover : "transparent")

                        Row {
                            anchors {
                                fill: parent
                                leftMargin: 10
                                rightMargin: 8
                            }
                            spacing: 10

                            IconLabel {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 21
                                text: navItem.modelData.icon
                                iconSize: 17
                                color: root.selectedSection === navItem.modelData.name ? Theme.accent : Theme.textMuted
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 31
                                text: navItem.modelData.name
                                color: root.selectedSection === navItem.modelData.name ? Theme.text : Theme.textMuted
                                elide: Text.ElideRight
                                font { family: Theme.fontFamily; pixelSize: 11; weight: Font.Medium }
                            }
                        }

                        HoverHandler { id: navPointer }
                        TapHandler { onTapped: root.selectedSection = navItem.modelData.name }
                    }
                }
            }
        }

        Item {
            width: parent.width - 190
            height: parent.height

            Column {
                anchors {
                    fill: parent
                    margins: 18
                }
                spacing: 14

                Item {
                    width: parent.width
                    height: 34

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: root.selectedSection
                        color: Theme.text
                        font { family: Theme.fontFamily; pixelSize: 18; weight: Font.DemiBold }
                    }

                    IconButton {
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                        icon: "close"
                        onClicked: root.controller.closeIsland()
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 112
                    radius: 18
                    color: Theme.raised
                    border.color: Theme.border
                    border.width: 1

                    Rectangle {
                        anchors.centerIn: parent
                        width: root.controller.compactPreviewWidth
                        height: 30
                        radius: 15
                        color: "#ff07090d"
                        border.color: Theme.borderStrong

                        Row {
                            anchors.centerIn: parent
                            spacing: 8

                            Rectangle { width: 5; height: 5; radius: 3; color: Theme.accent }
                            Text {
                                text: "12:48"
                                color: Theme.text
                                font { family: Theme.monoFamily; pixelSize: 10; weight: Font.DemiBold }
                            }
                            IconLabel { text: "wifi"; iconSize: 13; color: Theme.textMuted }
                            IconLabel { text: "battery_5_bar"; iconSize: 14; color: Theme.textMuted }
                        }
                    }

                    Text {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 9
                        }
                        text: "Live island preview"
                        color: Theme.textMuted
                        font { family: Theme.fontFamily; pixelSize: 9 }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 168
                    radius: 18
                    color: Theme.raised
                    border.color: Theme.border
                    border.width: 1

                    Column {
                        anchors {
                            fill: parent
                            margins: 13
                        }
                        spacing: 6

                        Text {
                            text: root.selectedSection === "Control Center" ? "Control Center surface" : "Island surface"
                            color: Theme.text
                            font { family: Theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
                        }

                        SliderRow {
                            width: parent.width
                            icon: "opacity"
                            label: "Opacity"
                            value: root.controller.panelOpacity
                            from: 0.72
                            to: 1
                            onValueMoved: value => root.controller.panelOpacity = value
                        }

                        SliderRow {
                            width: parent.width
                            icon: "rounded_corner"
                            label: "Corners"
                            value: root.controller.cornerRadius
                            from: 14
                            to: 32
                            onValueMoved: value => root.controller.cornerRadius = value
                        }

                        Item {
                            width: parent.width
                            height: 38

                            Text {
                                anchors {
                                    left: parent.left
                                    verticalCenter: parent.verticalCenter
                                }
                                text: "Collapse after pointer leaves"
                                color: Theme.text
                                font { family: Theme.fontFamily; pixelSize: 11 }
                            }

                            IconButton {
                                anchors {
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                }
                                buttonSize: 28
                                icon: root.controller.autoCollapse ? "check" : "close"
                                checked: root.controller.autoCollapse
                                onClicked: root.controller.autoCollapse = !root.controller.autoCollapse
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 78
                    radius: 18
                    color: Theme.accentSoft
                    border.color: Theme.accent
                    border.width: 1

                    Row {
                        anchors {
                            fill: parent
                            margins: 14
                        }
                        spacing: 12

                        IconLabel {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30
                            text: root.selectedSection === "Control Center" ? "tune" : "construction"
                            iconSize: 25
                            color: Theme.accent
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 42
                            spacing: 2

                            Text {
                                text: root.selectedSection === "Control Center"
                                    ? "Hover-first control center"
                                    : root.selectedSection + " module"
                                color: Theme.text
                                font { family: Theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
                            }
                            Text {
                                width: parent.width
                                wrapMode: Text.WordWrap
                                text: root.selectedSection === "Control Center"
                                    ? "Native audio, Bluetooth, battery and media services stay idle until needed."
                                    : "The module boundary is ready for this page without coupling it to qsbar."
                                color: Theme.textMuted
                                font { family: Theme.fontFamily; pixelSize: 9 }
                            }
                        }
                    }
                }
            }
        }
    }
}
