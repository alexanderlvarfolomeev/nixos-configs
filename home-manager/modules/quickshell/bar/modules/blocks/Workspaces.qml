import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
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
        property int alwaysVisibleWorkspaces: 5

        function createModel(workspaces, avw) {
            let resultMap = new Map();
            workspaces.forEach(
                ws => resultMap.set(
                    ws.id, 
                    {
                        id: ws.id,
                        exists: true,
                        active: ws.focused,
                        special: ws.id < 0,
                    },
                )
            )
            for (let idx = 1; idx <= avw; idx++) {
                if (!resultMap.has(idx)) {
                    resultMap.set(
                        idx, 
                        {
                            id: idx,
                            exists: false,
                            active: false,
                            special: false,
                        },
                    )
                }
            }
            return Array.from(resultMap.keys()).sort().map(id => resultMap.get(id))
        }

        model: createModel(Hyprland.workspaces.values, alwaysVisibleWorkspaces)
        Rectangle {
            required property var modelData
            property bool isExists: modelData.exists
            property bool isActive: modelData.active

            anchors {
                top: root.top
                bottom: root.bottom
            }
            implicitWidth: 36
            height: root.height
            radius: 5
            // TODO: make it work
            // Layout.rightMargin: modelData.special ? 10.0 : 0.0

            color: isExists ? (isActive ? "#0071c5" : "#2800b4d8") : "transparent"

            Text {
                id: timeText
                // Layout.alignment: Qt.AlignBaseline
                // center the bar in its parent component (the window)
                anchors.centerIn: parent
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
