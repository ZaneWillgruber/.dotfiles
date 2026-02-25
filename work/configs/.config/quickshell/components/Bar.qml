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
                bottom: true
                left: true
                right: true
            }

            implicitHeight: Theme.Theme.barHeight + Theme.Theme.barMargin
            color: Theme.Theme.background

            Item {
                anchors.fill: parent
                anchors.leftMargin: Theme.Theme.barMargin
                anchors.rightMargin: Theme.Theme.barMargin

                Item {
                    anchors.fill: parent
                    RowLayout {
                        id: leftRow
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        Widgets.WorkspaceSwitcher {}
                    }
                    RowLayout {
                        id: centerRow
                        anchors.centerIn: parent
                    }
                    RowLayout {
                        id: rightRow
                        spacing: 8
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        Widgets.NetworkWidget {}
                        Widgets.AudioWidget {}
                        Widgets.BatteryWidget {}
                        Widgets.ClockWidget {}
                    }
                }
            }
        }
    }
}
