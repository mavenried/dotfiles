pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "<b> hh:mm</b> dd|M|yy ddd");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
