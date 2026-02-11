import QtQuick
import "../components" as Components
import "../theme" as Theme
import "../services" as Services

Components.BarWidget {
    id: root

    property var notifications: Services.Notifications

    Row {
        anchors.centerIn: parent
        spacing: 4

        // Bell icon
        Text {
            id: bellIcon
            text: "🔔"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }

        // Count badge
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: countText.width + 8
            height: 16
            radius: 8
            color: notifications.hasNotifications ? Theme.Theme.warning : Theme.Theme.backgroundSecondary
            visible: notifications.count > 0

            Text {
                id: countText
                anchors.centerIn: parent
                text: notifications.count
                color: Theme.Theme.background
                font {
                    family: Theme.Theme.fontFamily
                    pixelSize: 10
                    bold: true
                }
            }
        }
    }
}
