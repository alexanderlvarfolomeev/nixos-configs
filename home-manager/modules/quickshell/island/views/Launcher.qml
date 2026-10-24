import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.config

Item {
    id: root

    required property var controller
    readonly property var matches: DesktopEntries.applications.values.filter(entry => {
        const query = search.text.trim().toLowerCase();
        if (query.length === 0) return true;
        return entry.name.toLowerCase().includes(query)
            || entry.genericName.toLowerCase().includes(query)
            || entry.keywords.join(" ").toLowerCase().includes(query);
    }).slice(0, 6)

    function launch(entry) {
        entry.execute();
        controller.closeIsland();
    }

    Column {
        anchors {
            fill: parent
            margins: 14
        }
        spacing: 10

        Rectangle {
            width: parent.width
            height: 44
            radius: 16
            color: Theme.raised
            border.color: search.activeFocus ? Theme.accent : Theme.border
            border.width: 1

            IconLabel {
                id: searchIcon
                anchors {
                    left: parent.left
                    leftMargin: 13
                    verticalCenter: parent.verticalCenter
                }
                text: "search"
                iconSize: 20
                color: Theme.textMuted
            }

            TextField {
                id: search
                anchors {
                    left: searchIcon.right
                    right: closeButton.left
                    top: parent.top
                    bottom: parent.bottom
                    leftMargin: 8
                    rightMargin: 8
                }
                focus: true
                placeholderText: "Search applications"
                color: Theme.text
                placeholderTextColor: Theme.textMuted
                font { family: Theme.fontFamily; pixelSize: 13 }
                background: Item {}
                selectByMouse: true

                Keys.onEscapePressed: root.controller.closeIsland()
                Keys.onReturnPressed: {
                    if (root.matches.length > 0) root.launch(root.matches[0]);
                }
            }

            IconButton {
                id: closeButton
                anchors {
                    right: parent.right
                    rightMargin: 6
                    verticalCenter: parent.verticalCenter
                }
                buttonSize: 31
                icon: "close"
                onClicked: root.controller.closeIsland()
            }
        }

        Text {
            width: parent.width
            text: search.text.length > 0 ? "Results" : "Applications"
            color: Theme.textMuted
            font { family: Theme.fontFamily; pixelSize: 10; capitalization: Font.AllUppercase; letterSpacing: 1.2 }
        }

        Column {
            width: parent.width
            spacing: 4

            Repeater {
                model: root.matches

                delegate: Rectangle {
                    id: appDelegate
                    required property var modelData

                    width: root.width - 28
                    height: 38
                    radius: 12
                    color: appPointer.hovered ? Theme.raisedHover : "transparent"

                    Row {
                        anchors {
                            fill: parent
                            leftMargin: 9
                            rightMargin: 9
                        }
                        spacing: 11

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 29
                            height: 29
                            radius: 9
                            color: "#16ffffff"

                            IconImage {
                                anchors {
                                    fill: parent
                                    margins: 5
                                }
                                source: Quickshell.iconPath(appDelegate.modelData.icon || "application-x-executable")
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 78
                            spacing: -1

                            Text {
                                width: parent.width
                                text: appDelegate.modelData.name
                                color: Theme.text
                                elide: Text.ElideRight
                                font { family: Theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
                            }

                            Text {
                                width: parent.width
                                text: appDelegate.modelData.genericName || appDelegate.modelData.comment
                                color: Theme.textMuted
                                elide: Text.ElideRight
                                font { family: Theme.fontFamily; pixelSize: 9 }
                            }
                        }

                        IconLabel {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 18
                            text: "north_east"
                            iconSize: 16
                            color: Theme.textMuted
                        }
                    }

                    HoverHandler { id: appPointer }
                    TapHandler { onTapped: root.launch(appDelegate.modelData) }
                }
            }
        }

        Text {
            width: parent.width
            visible: root.matches.length === 0
            text: "No matching applications"
            color: Theme.textMuted
            horizontalAlignment: Text.AlignHCenter
            font { family: Theme.fontFamily; pixelSize: 12 }
        }
    }

    Component.onCompleted: search.forceActiveFocus()
}
