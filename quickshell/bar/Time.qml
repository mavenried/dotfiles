import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "<b> hh:mm:ss</b> dd|M|yy ddd");
    }

    SystemClock {
        id: clock

        precision: SystemClock.Seconds
    }

}
