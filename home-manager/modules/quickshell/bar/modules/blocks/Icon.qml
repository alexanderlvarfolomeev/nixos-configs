import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

MouseRec {
    id: root
    implicitWidth: 40
    implicitHeight: 40
    color: "transparent"

    onClicked: function() {
        rofi.running = true
    }
    // Layout.leftMargin: 8
    Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        source: Quickshell.iconPath("nix-snowflake")
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Rectangle {
        anchors.fill: parent
        color: root.hovered ? "#40000000" : "transparent"

    }

    // MouseArea {
    //     anchors.fill: parent
    //     onClicked: function() {
    //         rofi.running = true
    //     }
    //     hoverEnabled: true
    // }

    Process {
        id: rofi
        running: false
        command: [ "rofi", "-show", "drun"]
    }

    // // Menu popup that opens when the logo is clicked
    // Menu {
    //     id: mainMenu
    //     // Place the menu below the bar's left edge; adjust as you like
    //     x: 0
    //     y: panel.height

    //     MenuItem {
    //         text: "Settings"
    //         onTriggered: console.log("Settings clicked")
    //     }
    //     MenuItem {
    //         text: "About"
    //         onTriggered: console.log("About clicked")
    //     }
    //     MenuSeparator {}
    //     MenuItem {
    //         text: "Quit Quickshell"
    //         onTriggered: Qt.quit()
    //     }
    // }
}

// BarBlock {
//     id: root
//     Layout.preferredWidth: 40

//     content: Text {
//             text: ""
//             font.pointSize: 20
//             anchors.horizontalCenterOffset: -2
//     }

//     Item {
//         id: contentContainer
//         implicitWidth:  logo.implicitWidth
//         implicitHeight: logo.implicitHeight
//         anchors.centerIn: parent
//         children: logo
//     }

//     IconImage {
//         id: logo
//         anchors.fill: parent
//         source: "nix-snowflake.svg"
//         // fillMode: Image.PreserveAspectFit
//         visible: true
//     }

//     color: "transparent"

//     Process {
//         id: rofi
//         running: false
//         command: [ "rofi", "-show", "drun"]
//     }

//     MouseArea {
//         id: mouseArea
//         anchors.fill: root
//         hoverEnabled: true
//         acceptedButtons: Qt.LeftButton
//         onClicked: function() {
//             rofi.running = true
//         }
//     }
// }