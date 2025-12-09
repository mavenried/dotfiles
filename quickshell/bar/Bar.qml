import QtQuick
import QtQuick.Layouts
import Quickshell
import qs

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root

            required property var modelData

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
                    command: ["zsh", "-c", "checkupdates | wc -l | awk '{printf \"%3s\\n\", $0}'"]
                    template: " {}"
                    label: " ---"
                    interval: 5000
                }

                Module {
                    label: Time.time
                    labelColor: Theme.clck
                }

                ActiveWindow {
                    labelColor: Theme.clck
                }

            }

            Row {
                padding: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5

                SysInfo {
                }

            }

            Row {
                padding: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                spacing: 5

                CommandMonitor {
                    labelColor: Theme.wifi
                    command: [".config/quickshell/scripts/qs-online"]
                    label: "󰖟 --"
                    interval: 1000
                }

                CommandMonitor {
                    labelColor: Theme.uptm
                    command: [".config/quickshell/scripts/qs-uptime"]
                    label: " --:--:--:--"
                }

                PowerProfileSelector {
                }

                IdleInhibitor {
                    labelColor: Theme.idle
                }

            }

        }

    }

}
