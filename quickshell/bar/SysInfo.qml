import QtQuick
import Quickshell.Io
import qs

Rectangle {
    id: root

    property string cpu: " ---%"
    property string ram: " ---%"
    property string dsk: "󰋊 ---%"
    property string bat: "󰁾 ---%"
    property string bat_icon;
    property string pow: "󱐋 --W"

    function getBatteryColor() {
        var num = battery.label.replace(/[^\d]/g, "");
        if (10 > num)
            return Theme.bat5;
        else if (25 > num)
            return Theme.bat4;
        else if (50 > num)
            return Theme.bat3;
        else if (75 > num)
            return Theme.bat2;
        else if (100 >= num)
            return Theme.bat1;
    }

    color: Theme.bgnd
    border.color: Theme.acct
    border.width: 2
    radius: Theme.radius
    width: content.implicitWidth
    height: content.implicitHeight

    Row {
        id: content

        spacing: 0

        CommandMonitor {
            label: root.cpu
            labelColor: Theme.cpuc
            drawBox: false
            template: " %3s%"
            command: ["mavencore", "cpu"]
        }

        CommandMonitor {
            label: root.ram
            labelColor: Theme.mmry
            drawBox: false
            template: " %3s%"
            command: ["mavencore", "memory"]
        }

        CommandMonitor {
            label: root.dsk
            labelColor: Theme.disk
            drawBox: false
            template: "󰋊 %3s%"
            command: ["mavencore", "disk", "/mnt/DATA/"]
        }

        CommandMonitor {
            id: battery

            label: root.bat
            labelColor: root.getBatteryColor()
            drawBox: false
            template: root.bat_icon + " %3s%"
            command: ["mavencore", "battery", "/sys/class/power_supply/BAT1"]
        }

        CommandMonitor {
            label: root.pow
            labelColor: Theme.powr
            drawBox: false
            template: "󱐋 %2sW"
            command: ["mavencore", "power", "/sys/class/power_supply/BAT1"]
        }

    }

    // Connections {
    //     target: battery
    //     onLabelChanged: root.bat = battery.label
    // }

    Process {
        id: updater

        running: true
        command: ["mavencore", "battery-icon", "/sys/class/power_supply/BAT1"]

        stdout: StdioCollector {
            onStreamFinished: root.bat_icon = this.text.trim()
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: updater.running = true
    }

}
