import QtQuick
import Quickshell.Io
import Quickshell

Item {
    id: root
    property var focusName: "----"
    property color labelColor

    Module {
        id: content
        label: root.focusName
        labelColor: root.labelColor
    }

    width: content.width
    height: content.height

    Process {
        id: pythonScript
        running: true
        command: ["/usr/bin/python3", "/mnt/DATA/scripts/qs-niri-window-watch"]
        onRunningChanged: if (!running)
            running = true
        stdout: SplitParser {
            onRead: focusName = data
        }
        Component.onCompleted: running = true
    }
}
