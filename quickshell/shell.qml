// Bar.qml
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: root
            required property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 42

            Row {
                spacing: 0
                bottomPadding: 0
                width: parent.width
                height: parent.height
                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    spacing: 10

                    CommandMonitor {
                        labelColor: Theme.dstr
                        command: ["bash", "-c", "checkupdates | wc -l"]
                        template: " {}"
                        label: " --"
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
                    spacing: 10

                    SysInfo {}
                }

                Row {
                    padding: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    spacing: 10
                    CommandMonitor {
                        labelColor: Theme.wifi
                        command: ["/mnt/DATA/scripts/qs-online"]
                        interval: 1000
                    }
                    CommandMonitor {
                        labelColor: Theme.uptm
                        command: ["/mnt/DATA/scripts/uptime"]
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
}
