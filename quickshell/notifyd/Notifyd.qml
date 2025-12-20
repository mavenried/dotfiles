import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import Quickshell.Io
import qs

Scope {
    id: root

    IpcHandler {
        target: "notifyd"
        function clear() {
            console.log("Clearing all notifications.");
            while (server.trackedNotifications.values.length > 0) {
                server.trackedNotifications.values.forEach(function (notif: Notification) {
                    console.log(notif.summary);
                    notif.tracked = false;
                });
            }
        }
    }

    property bool showToasts: server.trackedNotifications.values.length > 0

    function resolveIcon(value) {
        if (!value || value === "")
            return "";

        if (value.startsWith("/") || value.startsWith("image://"))
            return value;

        return "";
    }

    NotificationServer {
        id: server

        bodySupported: true
        actionsSupported: true
        persistenceSupported: true
        onNotification: function (notification) {
            notification.tracked = true;
            notification.timestamp = Date.now();
            console.log("Got: [" + notification.appIcon + ", " + notification.image + "]: " + notification.summary + " | " + notification.body);
        }
    }

    LazyLoader {
        id: toastLoader

        active: root.showToasts

        PanelWindow {
            id: toastPanel

            implicitHeight: toastColumn.implicitHeight
            implicitWidth: toastColumn.implicitWidth
            anchors.bottom: true
            anchors.right: true
            margins.right: 10
            margins.bottom: 10
            exclusiveZone: 0
            color: "transparent"

            ColumnLayout {
                id: toastColumn

                spacing: 5
                Layout.margins: 10

                Repeater {
                    id: repeater

                    model: server.trackedNotifications

                    delegate: Rectangle {
                        id: toastBox

                        required property Notification modelData

                        Layout.preferredWidth: 350
                        Layout.preferredHeight: row.implicitHeight
                        radius: Theme.radius
                        color: Theme.bgnd
                        border.color: Theme.acct
                        border.width: 2

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
                                    radius: Theme.radius

                                    Image {
                                        id: img

                                        source: {
                                            if (toastBox.modelData.image.length > 0)
                                                return resolveIcon(toastBox.modelData.image);
                                            else if (toastBox.modelData.appIcon.length > 0)
                                                return resolveIcon(toastBox.modelData.appIcon);
                                            else
                                                return "";
                                        }
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
                                    width: 250
                                    wrapMode: Text.Wrap
                                    font.pixelSize: 16
                                    font.family: "JetbrainsMono Nerd Font"
                                }

                                Text {
                                    text: toastBox.modelData.body
                                    color: Theme.clck
                                    width: 250
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
