import QtQuick
import Quickshell.Io

Item {
    id: root

    property string label: "^-^"
    property string template: "%s"
    property color labelColor
    property int interval: 500
    property list<string> command
    property bool drawBox: true

    function fmt(template, value) {
        return template.replace(/%(-?\d*)s/g, function(_, widthSpec) {
            const width = parseInt(widthSpec, 10);
            if (!width || isNaN(width))
                return value;
 // plain %s
            if (width > 0)
                return value.toString().padStart(width, " ");

            if (width < 0)
                return value.toString().padEnd(-width, " ");

            return value;
        });
    }

    width: content.width
    height: content.height

    Module {
        id: content

        label: root.label
        labelColor: root.labelColor
        drawBox: root.drawBox
    }

    Process {
        id: updater

        running: true
        command: root.command

        stdout: StdioCollector {
            onStreamFinished: root.label = root.fmt(root.template, this.text.trim())
        }

    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: updater.running = true
    }

}
