import QtQuick
import Quickshell.Io
import Quickshell

Item {
    id: root
    property string label: "^-^"
    property string template: "{}"
    property color labelColor
    property int interval: 500
    property list<string> command

    Module {
        id: content
        label: root.label
        labelColor: root.labelColor
    }

    width: content.width
    height: content.height

    Process {
        id: updater
        running: true
        command: root.command
        stdout: StdioCollector {
            onStreamFinished: label = root.template.replace("{}", this.text.trim())
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: updater.running = true
    }
}
