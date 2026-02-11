import QtQuick
import Quickshell
import "../theme" as Theme
import "../widgets" as Widgets

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: Theme.Theme.barMargin
                left: Theme.Theme.barMargin
                right: Theme.Theme.barMargin
            }

            implicitHeight: Theme.Theme.barHeight
            color: 'transparent'

            // Left section - Workspace Switcher
            Widgets.WorkspaceSwitcher {
                id: workspaceSwitcher
                anchors {
                    left: parent.left
                    leftMargin: Theme.Theme.barPadding
                    verticalCenter: parent.verticalCenter
                }
            }

            // Center section - Arch Logo, Media, Notifications
            Row {
                anchors.centerIn: parent
                spacing: Theme.Theme.spacing

                Widgets.ArchLogo {}
                Widgets.MediaWidget {}
                Widgets.NotificationBell {}
            }

            // Right section - Clock and Theme Toggle
            Row {
                anchors {
                    right: parent.right
                    rightMargin: Theme.Theme.barPadding
                    verticalCenter: parent.verticalCenter
                }
                spacing: Theme.Theme.spacing

                Widgets.ClockWidget {}
                Widgets.ThemeToggle {}
            }
        }
    }
}
