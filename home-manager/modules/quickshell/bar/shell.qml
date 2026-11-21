//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme default
//@ pragma Env QT_QUICK_WHEEL_DECELERATION=1000

import Quickshell
import qs.config
import qs.components
import qs.modules.island as Island

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        BarPanel {
            required property var modelData
            screen: modelData
        }
    }

    Island.Island {
        barHeight: Config.barHeight
    }
}
