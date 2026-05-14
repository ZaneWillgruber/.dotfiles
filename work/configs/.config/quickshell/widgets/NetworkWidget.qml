import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Networking
import "../theme" as Theme

Item {
    id: networkWidget
    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight
    property string connectionType: NetworkState.devices.values[0].type
    property string connectionState: Networking.devices.values[0].nmState
    function networkIcon(): string {
        connectionType = "wifi";

        if (connectionState != 100)
            return Theme.Theme.iconPath + "/network-offline-symbolic";
        if (connectionType === DeviceType.Wifi)
            return Theme.Theme.iconPath + "/nm-signal-symbolic";
        return Theme.Theme.iconPath + "/network-wired-symbolic";
    }

    IconImage {
        id: icon
        implicitWidth: Theme.Theme.iconSize
        implicitHeight: Theme.Theme.iconSize
        source: networkWidget.networkIcon()
    }
}
