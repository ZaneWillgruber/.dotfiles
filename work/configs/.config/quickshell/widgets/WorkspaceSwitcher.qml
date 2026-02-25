import QtQuick
import Quickshell.Widgets
import "../theme" as Theme

Item {
    id: workspaceWidget
    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight

    IconImage {
        id: icon
        implicitWidth: 24
        implicitHeight: 24
        source: Theme.Theme.assetPath + "Windows11.svg"
    }
}
