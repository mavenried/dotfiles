import QtQuick
import Quickshell.Widgets
import qs

Rectangle {
    id: textRoot

    property string label
    property color labelColor
    property bool drawBox: true

    color: drawBox ? Theme.bgnd : "transparent"
    border.color: Theme.acct
    border.width: drawBox ? 2 : 0
    radius: Theme.radius
    width: content.width
    height: content.height

    ClippingRectangle {
        id: content

        color: 'transparent'
        width: inner.width
        height: inner.height
        layer.enabled: true
        layer.smooth: false
        layer.mipmap: false

        Text {
            id: inner

            text: textRoot.label
            font.pixelSize: 16
            font.family: "JetbrainsMono Nerd Font"
            color: textRoot.labelColor
            padding: 8
            leftPadding: 13
            rightPadding: 13
        }

        Behavior on width {
            NumberAnimation {
                duration: 200 // Animation duration
            }

        }

    }

}
