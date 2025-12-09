import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property string label: "^-^"
    property string template: "{}"
    property color labelColor
    property int interval: 500
    property list<string> command

    width: content.width
    height: content.height

    Module {
        id: content

        label: root.label
        labelColor: root.labelColor
    }

    Process {
        id: updater

        running: true
        command: root.command

        stdout: StdioCollector {
            onStreamFinished: label = root.template.replace("{}", this.text)
        }

    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: updater.running = true
    }

}
