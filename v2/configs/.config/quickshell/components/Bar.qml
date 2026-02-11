import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
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

            implicitHeight: Theme.Theme.barHeight + Theme.Theme.barMargin
            color: 'transparent'

            Column {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Item {
                    width: parent.width
                    height: Theme.Theme.barMargin
                    RectangularShadow {
                        anchors.fill: topSpacer
                        offset.x: -10
                        offset.y: -5
                        blur: 20
                        spread: 10
                        radius: topSpacer.radius
                        color: Qt.darker(topSpacer.color)
                    }

                    Rectangle {
                        id: topSpacer
                        width: parent.width
                        height: Theme.Theme.barMargin
                    }
                }

                // Left section - Workspace Switcher
                RowLayout {
                    spacing: 0
                    anchors {
                        left: parent.left
                    }
                    Widgets.WorkspaceSwitcher {
                        id: workspaceSwitcher
                    }
                    Widgets.WorkspaceSwitcher {
                        id: workspaceSwitcher2
                    }
                }
            }
        }
    }
}
