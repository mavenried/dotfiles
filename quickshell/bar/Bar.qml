import QtQuick
import Quickshell
import qs

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root

            required property var modelData

            function truncate(str) {
                if (str.length > 37) {
                    return str.slice(0, 36) + "…";
                }
                return str;
            }

            screen: modelData
            color: "transparent"
            implicitHeight: row.implicitHeight

            anchors {
                top: true
                left: true
                right: true
            }

            Row {
                id: row

                anchors.verticalCenter: parent.verticalCenter
                padding: 5
                bottomPadding: 0
                spacing: 5

                CommandMonitor {
                    labelColor: Theme.dstr
                    command: ["zsh", "-c", "checkupdates | wc -l "]
                    template: " %3s"
                    label: " ---"
                    interval: 5000
                }

                Module {
                    label: Time.time
                    labelColor: Theme.clck
                }
                Rectangle {
                    implicitHeight: inner.implicitHeight
                    implicitWidth: inner.implicitWidth
                    color: Theme.acct
                    border.width: 2
                    border.color: Theme.acct
                    radius: Theme.radius
                    Row {
                        id: inner
                        spacing:-4;
                        Module {
                            label:  "<b>" +(CompositorIpc.state.workspaces.indexOf(CompositorIpc.state.workspace_id) + 1) + "</b"
                            labelColor: Theme.wksp
                            drawBox: false
                        }
                        Module {
                            label: root.truncate(CompositorIpc.state.window_name)
                            labelColor: Theme.name
                            color: Theme.wksp
                            drawBox: true
                        }
                    }
                }
            }

            Row {
                padding: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                bottomPadding: 0

                SysInfo {}
            }

            Row {
                padding: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                spacing: 5
                bottomPadding: 0

                CommandMonitor {
                    labelColor: Theme.wifi
                    command: ["zsh", "-c", "~/.config/quickshell/scripts/qs-online"]
                    label: "󰖟 offline"
                    interval: 1000
                }

                CommandMonitor {
                    labelColor: Theme.uptm
                    command: ["mavencore", "uptime"]
                    template: " %s"
                    label: " --:--:--:--"
                }

                PowerProfileSelector {}

                IdleInhibitor {
                    labelColor: Theme.idle
                }
            }
        }
    }
}
