// Notification Service
pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    // Notification server instance
    readonly property NotificationServer server: NotificationServer {
        // Track all notifications
        onNotification: notification => {
            notification.tracked = true
        }
    }

    // List of tracked notifications
    readonly property var notifications: server.trackedNotifications

    // Count of active notifications
    readonly property int count: notifications ? notifications.count : 0

    // Check if there are any notifications
    readonly property bool hasNotifications: count > 0
}
