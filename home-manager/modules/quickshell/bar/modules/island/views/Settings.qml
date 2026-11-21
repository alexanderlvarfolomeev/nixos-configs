pragma ComponentBehavior: Bound

import QtQuick
import qs.modules.island.components
import qs.modules.island.config

Item {
    id: root

    required property var controller
    readonly property string selectedSection: "Appearance"
    readonly property var sections: [{ icon: "palette", name: "Appearance" }]

    Row {
        anchors.fill: parent

        Rectangle {
            width: 190
            height: parent.height
            color: Theme.surface

            Column {
                anchors {
                    fill: parent
                    margins: 12
                }
                spacing: 5

                StyledText {
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
                        color: Theme.accentSoft

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
                                color: Theme.accent
                            }

                            StyledText {
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 31
                                text: navItem.modelData.name
                                color: Theme.text
                                elide: Text.ElideRight
                                font { family: Theme.fontFamily; pixelSize: 11; weight: Font.Medium }
                            }
                        }

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

                    StyledText {
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
                        color: Theme.background
                        border.color: Theme.borderStrong

                        Row {
                            anchors.centerIn: parent
                            spacing: 8

                            Rectangle { width: 5; height: 5; radius: 3; color: Theme.accent }
                            StyledText {
                                text: "12:48"
                                color: Theme.text
                                font { family: Theme.monoFamily; pixelSize: 10; weight: Font.DemiBold }
                            }
                            IconLabel { text: "wifi"; iconSize: 13; color: Theme.textMuted }
                            IconLabel { text: "battery_5_bar"; iconSize: 14; color: Theme.textMuted }
                        }
                    }

                    StyledText {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 9
                        }
                        text: "Island preview"
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

                        StyledText {
                            text: "Island surface"
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

                            StyledText {
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
                            text: "palette"
                            iconSize: 25
                            color: Theme.accent
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 42
                            spacing: 2

                            StyledText {
                                text: "Session appearance"
                                color: Theme.text
                                font { family: Theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
                            }
                            StyledText {
                                width: parent.width
                                wrapMode: Text.WordWrap
                                text: "Changes apply immediately to this island for the current session."
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
