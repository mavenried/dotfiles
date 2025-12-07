import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    property string label
    property color labelColor
    color: Theme.bgnd
    border.color: Theme.acct
    border.width: 2
    radius: 10
    width: content.width
    height: content.height

    Row {
        id: content
        Text {
            text: label
            font.pixelSize: 16
            font.family: "JetbrainsMono Nerd Font"
            color: labelColor
            padding: 8
            leftPadding: 13
            rightPadding: 13
        }
    }
}
