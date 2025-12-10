import QtQuick
import Quickshell.Services.UPower
import qs

Item {
    id: root

    function getIcon() {
        var mode = PowerProfiles.profile;
        if (mode == PowerProfile.PowerSaver)
            return "󰾆 ps";
        else if (mode == PowerProfile.Performance)
            return "󰓅 pf";
        else if (mode == PowerProfile.Balanced)
            return "󰾅 bl";
    }

    function setNextMode() {
        var mode = PowerProfiles.profile;
        if (mode == PowerProfile.PowerSaver)
            PowerProfiles.profile = PowerProfile.Balanced;
        else if (mode == PowerProfile.Performance)
            PowerProfiles.profile = PowerProfile.PowerSaver;
        else if (mode == PowerProfile.Balanced)
            PowerProfiles.profile = PowerProfile.Performance;
    }

    width: content.width
    height: content.height

    Module {
        id: content

        label: root.getIcon()
        labelColor: Theme.pfle
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.setNextMode()
    }

}
