pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import qs.utils

Singleton {
    id: root

    property var unknownState: "?"
    property string chargingState: ""
    property var batteryEmoji: ["", "", "", "", ""]

    function batteryStateText(state, chargeLevel): string {
        if (state === UPowerDeviceState.FullyCharged) {
            return batteryEmoji[batteryEmoji.length - 1]
        } else if (state === UPowerDeviceState.Empty) {
            return batteryEmoji[0]
        } else if (state === UPowerDeviceState.Unknown) {
            return unknownState
        } else if (![UPowerDeviceState.Charging, UPowerDeviceState.Discharging, UPowerDeviceState.PendingCharge, UPowerDeviceState.PendingDischarge].includes(state)) {
            return unknownState
        }
        let percentage = Math.round(100 * chargeLevel)
        if (state === UPowerDeviceState.Charging) {
            return chargingState + " " + percentage + "%"
        } else if (state === UPowerDeviceState.Discharging) {
            return Utils.getBinValue(batteryEmoji, chargeLevel) + " " + percentage + "%"
        }
        return unknownState + " " + percentage + "%"
    }

    function tooltipText(): string {
        const toFull = UPower.displayDevice.timeToFull
        const toEmpty = UPower.displayDevice.timeToEmpty
        if (toFull > 0) {
            return "Full in " + Utils.secondsToHumanReadable(toFull)
        } else if (toEmpty > 0) {
            return "Empty in " + Utils.secondsToHumanReadable(toEmpty)
        } else {
            return ""
        }
    }

}
