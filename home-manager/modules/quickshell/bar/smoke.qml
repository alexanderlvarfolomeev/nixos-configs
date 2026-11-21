import QtQuick
import Quickshell
import qs.base
import qs.services
import qs.modules.devices as Devices
import qs.modules.general as General
import qs.modules.island.services as IslandServices
import qs.modules.island.components as IslandComponents

ShellRoot {
    id: root
    property var controller: IslandServices.IslandController { registry: root.registry }
    property var registry: IslandServices.PageRegistry {
        controller: root.controller
        systemModel: SystemState
    }
    property int clicks: 0
    property int holds: 0
    FloatingWindow {
        implicitWidth: 1000
        implicitHeight: 650
        Item {
            width: parent.width
            height: 40
            Row {
                anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                General.Icon {}
                General.Time {}
            }
            Row {
                anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
                Devices.DeviceRow { id: devices }
                General.Language {}
                General.Power {}
            }
        }
        Loader {
            id: page
            y: 50
            width: root.controller.currentPage.width
            height: root.controller.currentPage.height
            sourceComponent: root.controller.currentPage.view
        }
        IslandComponents.CollapsedIsland {
            id: compact
            y: 560
            height: implicitHeight
            width: implicitWidth
            expanded: false
            sourceComponent: root.controller.currentPage.compactView
        }
        MouseRec {
            id: button
            width: 30
            height: 30
            onClicked: root.clicks++
            onPressAndHold: root.holds++
        }
        ToolTip { id: tip }
    }
    function check(condition, message) {
        if (!condition) throw new Error(message);
    }
    property int step: 0
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            try {
                root.check(page.status === Loader.Ready && compact.status === Loader.Ready, "page/compact load");
                if (root.step === 0) {
                    root.check(devices.children[1].enabled, "disabled Bluetooth remains clickable");
                    root.check(devices.width > 100, "device status layout has width");
                    button.clicked({wasHeld: false});
                    button.pressAndHold({wasHeld: true});
                    root.check(root.clicks === 1 && root.holds === 1, "separate click and hold signals");
                    KeyboardLayout.loadLayoutMappings("! layout\n us English (US)\n ru Russian\n! variant\n winkeys ru: Russian (Windows)");
                    KeyboardLayout.currentLayoutName = "Russian (Windows)";
                    root.check(SystemState.keyboardLayout === "RU", "shared Russian layout");
                    KeyboardLayout.currentLayoutName = "English (US)";
                    root.check(SystemState.keyboardLayout === "US", "shared English layout");
                    tip.delay = 0;
                    tip.prepareToShow(button, "Tooltip test");
                }
                if (++root.step < root.registry.entries.length) {
                    root.controller.openPage(root.registry.entries[root.step].key);
                    return;
                }
                root.check(tip.visible, "tooltip opens");
                tip.hide();
                console.log("QSBAR_REFACTOR_CHECK_OK");
                Qt.quit();
            } catch (error) {
                console.error("QSBAR_REFACTOR_CHECK_FAILED", error);
                Qt.exit(1);
            }
        }
    }
}
