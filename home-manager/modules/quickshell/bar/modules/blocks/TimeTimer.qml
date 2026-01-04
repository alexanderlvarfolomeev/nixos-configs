pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // Process {
    //     id: dateProc
    //     command: ["date", "+%R"]
    //     running: true

    //     stdout: SplitParser {
    //         onRead: data => { time = data }
    //     }
    // }

    // Timer {
    //     interval: 1000
    //     running: true
    //     repeat: true
    //     onTriggered: dateProc.running = true
    // }
}