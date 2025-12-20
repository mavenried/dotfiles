pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland
import qs

Scope {
    id: root
    property bool open: false
    property list<var> apps: [
        {
            name: "Terminal"
        }
    ]

    Process {
        id: proc
        command: ["sh", "-c", "mavencore apps-list"]
        running: true
        stdout: SplitParser {
            onRead: function (data) {
            // root.apps.push(JSON.parse(data));
            }
        }
    }
    IpcHandler {
        target: "launcher"
        function open() {
            console.log("opening runner.");
            root.open = true;
            proc.running = true;
        }

        function close() {
            console.log("closing runner.");
            root.open = false;
        }
    }
    LazyLoader {
        active: root.open
        PanelWindow {
            id: runnerWindow
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            implicitHeight: 800
            anchors {
                bottom: true
                left: true
                right: true
            }
            exclusiveZone: -1
            color: "transparent"
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 700
                implicitHeight: 700
                anchors.margins: 10
                anchors.bottom: parent.bottom
                radius: Theme.radius
                color: Theme.bgnd
                border.color: Theme.acct
                border.width: 2
                Keys.onPressed: function (event) {
                    console.log("Key pressed:", event.key);
                    if (event.key === Qt.Key_Escape) {
                        console.log("Escape pressed!");
                        root.open = false;
                    }
                }
                ColumnLayout {
                    Repeater {
                        model: root.apps
                        height: 500
                        delegate: Rectangle {
                            property var modelData
                            height: inner.implicitHeight
                            width: parent.width
                            Text {
                                id: inner
                                text: "poop" + i
                                                               font.pixelSize: 20
                                font.family: "JetbrainsMono Nerd Font"
                                color: Theme.text
                            }
                        }
                    }
                }
                TextField {
                    id: text
                    padding: 10
                    focus: true
                    placeholderText: "Search..."
                    placeholderTextColor: Theme.bgText
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }
                    anchors.margins: 10
                    cursorVisible: false
                    font.pixelSize: 20
                    font.family: "JetbrainsMono Nerd Font"
                    color: Theme.text
                    background: Rectangle {
                        color: "transparent"
                    }
                    onTextChanged: function () {
                        console.log(this.text);
                    }
                }
            }
        }
    }
}
