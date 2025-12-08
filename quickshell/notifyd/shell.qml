import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

Scope {
    id: root

    NotificationServer {
        id: server

        bodySupported: true
        actionsSupported: true
        persistenceSupported: true

        onNotification: function (notification) {
            notification.tracked = true;
            notification.timestamp = Date.now();
        }
    }

    property bool showToasts: server.trackedNotifications.values.length > 0

    LazyLoader {
        id: toastLoader
        active: root.showToasts

        PanelWindow {
            id: toastPanel
            implicitHeight: toastColumn.implicitHeight
            implicitWidth: toastColumn.implicitWidth

            // Like the OSD example: compositor chooses the monitor
            anchors.bottom: true
            anchors.right: true
            margins.right: 10
            margins.bottom: 10

            exclusiveZone: 0
            color: "transparent"

            ColumnLayout {
                id: toastColumn
                spacing: 12
                Layout.margins: 10

                Repeater {
                    id: repeater
                    model: server.trackedNotifications

                    delegate: Rectangle {
                        id: toastBox
                        Layout.preferredWidth: 350
                        Layout.preferredHeight: row.implicitHeight
                        radius: 10
                        color: Theme.bgnd
                        border.color: Theme.acct
                        border.width: 2

                        required property Notification modelData

                        Row {
                            id: row
                            padding: 10
                            spacing: 15

                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                ClippingRectangle {
                                    visible: img.source.toString().length > 0
                                    height: img.height
                                    width: img.width
                                    radius: 10
                                    Image {
                                        id: img
                                        source: toastBox.modelData.image.length > 0 ? toastBox.modelData.image : toastBox.modelData.appIcon.length > 0 ? toastBox.modelData.appIcon : ""
                                        height: 60
                                        width: 60
                                    }
                                }
                            }

                            Column {
                                spacing: 4
                                anchors.verticalCenter: parent.verticalCenter
                                Text {
                                    text: toastBox.modelData.summary
                                    color: Theme.clck
                                    font.bold: true
                                    width: 280
                                    wrapMode: Text.Wrap

                                    font.pixelSize: 16
                                    font.family: "JetbrainsMono Nerd Font"
                                }

                                Text {
                                    text: toastBox.modelData.body
                                    color: Theme.clck
                                    width: 280
                                    wrapMode: Text.Wrap

                                    font.pixelSize: 14
                                    font.family: "JetbrainsMono Nerd Font"
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                toastBox.modelData.dismiss();
                            }
                        }
                        Timer {

                            interval: {
                                var timeout = toastBox.modelData.expireTimeout;
                                return timeout == -1 ? 10000 : timeout * 1000;
                            }

                            running: true
                            repeat: false
                            onTriggered: {
                                toastBox.modelData.expire();
                            }
                        }
                    }
                }
            }
        }
    }
}
