pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: root
    property var state: undefined
    Process {
        command: ["mavencore", "listen"]
        onRunningChanged: {
            if (!running)
                running = true;
        }

        Component.onCompleted: running = true

        stdout: SplitParser {
            onRead: function (data) {
                root.state = JSON.parse(data)
            }
        }
    }
}
