// BatteryWidget.qml
import QtQuick
import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick.Layouts
import "../theme" as Theme

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    property int pct: Math.round(UPower.displayDevice.percentage * 100)
    property bool charging: !UPower.onBattery

    RowLayout {
        id: row
        spacing: 6

        IconImage {
            width: Theme.Theme.iconSize
            height: Theme.Theme.iconSize
            source: Theme.Theme.iconPath + UPower.displayDevice.iconName
        }
    }
}
