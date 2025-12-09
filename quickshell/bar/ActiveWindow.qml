import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property var focusName: "----"
    property color labelColor

    width: content.width
    height: content.height

    Module {
        id: content

        label: root.focusName
        labelColor: root.labelColor
    }

    Process {
        id: pythonScript

        running: true
        command: [".config/quickshell/scripts/qs-niri-window-watch"]
        onRunningChanged: {
            if (!running)
                running = true;

        }
        Component.onCompleted: running = true

        stdout: SplitParser {
            onRead: function(data) {
                focusName = data;
            }
        }

    }

}
