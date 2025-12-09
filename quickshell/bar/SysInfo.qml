import QtQuick
import Quickshell.Io
import qs

Rectangle {
    id: root

    property string cpu: " ---%"
    property string ram: " ---%"
    property string dsk: "󰋊 ---%"
    property string bat: "󰁾 ---%"
    property string pow: "󱐋 --W"

    color: Theme.bgnd
    border.color: Theme.acct
    border.width: 2
    radius: Theme.radius
    width: content.implicitWidth
    height: content.implicitHeight

    Row {
        id: content

        spacing: 20
        padding: 8
        leftPadding: 13
        rightPadding: 13

        Text {
            text: root.cpu
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            color: Theme.cpuc
        }

        Text {
            text: root.ram
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            color: Theme.mmry
        }

        Text {
            text: root.dsk
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            color: Theme.disk
        }

        Text {
            text: root.bat
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            color: {
                var num = root.bat.trim().replace(/[^\d]/g, "");
                if (10 > num)
                    return Theme.bat5;
                else if (30 > num)
                    return Theme.bat4;
                else if (50 > num)
                    return Theme.bat3;
                else if (80 > num)
                    return Theme.bat2;
                else if (100 >= num)
                    return Theme.bat1;
            }
        }

        Text {
            text: root.pow
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            color: Theme.powr
        }

    }

    Process {
        id: pythonScript

        running: true
        command: ["/mnt/DATA/scripts/qs-sysinfo"]
        onRunningChanged: {
            if (!running)
                running = true;

        }
        Component.onCompleted: running = true

        stdout: StdioCollector {
            onStreamFinished: {
                var val = this.text.trim().split(" | ");
                cpu = val[0];
                ram = val[1];
                dsk = val[2];
                bat = val[3];
                pow = val[4];
            }
        }

    }

}
