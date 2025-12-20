import QtQuick
import Quickshell
pragma Singleton

Singleton {
    readonly property color bg: Qt.rgba(0.16, 0.16, 0.16, 0.8)
    readonly property color red: "#cc241d"
    readonly property color green: "#b8bb26"
    readonly property color yellow: "#d79921"
    readonly property color blue: "#458588"
    readonly property color purple: "#d3869b"
    readonly property color aqua: "#689d6a"
    readonly property color gray: "#a89984"
    readonly property color orange: "#fe8019"
    readonly property color fg: "#ebdbb2"
    readonly property color bgnd: bg
    readonly property color cpuc: purple
    readonly property color mmry: blue
    readonly property color disk: aqua
    readonly property color name: orange
    readonly property color idle: yellow
    readonly property color powr: yellow
    readonly property color wifi: purple
    readonly property color dstr: green
    readonly property color wksp: purple
    readonly property color uptm: blue
    readonly property color clck: fg
    readonly property color sptr: bg
    readonly property color pfle: aqua
    readonly property color acct: Accent.acct
    readonly property color bat1: green
    readonly property color bat2: aqua
    readonly property color bat3: yellow
    readonly property color bat4: orange
    readonly property color bat5: red
    readonly property int radius: 15
}
