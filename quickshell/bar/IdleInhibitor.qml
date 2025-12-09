import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property bool active: false
    property color labelColor

    width: content.width
    height: content.height

    Process {
        id: proc

        running: false
        command: ["systemd-inhibit", "--what=sleep:idle", "--why=MavenCore Sleep Inhibit", "--mode=block", "sleep", "infinity"]
    }

    Module {
        id: content

        label: active ? "   on" : "  off"
        labelColor: root.labelColor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (proc.running) {
                proc.running = false;
                active = false;
            } else {
                proc.running = true;
                active = true;
            }
        }
    }

}
