import QtQuick
import Quickshell
import "../theme" as Theme

Rectangle {
    id: root
    
    property int size: 24
    
    width: size
    height: size
    radius: Theme.Theme.widgetRadius
    color: mouseArea.containsMouse ? Theme.Theme.backgroundSecondary : "transparent"
    border.color: Theme.Theme.border
    border.width: 1
    
    Text {
        anchors.centerIn: parent
        text: Theme.Theme.currentPalette === "dark" ? "🌙" : "☀️"
        font.pixelSize: 14
        color: Theme.Theme.text
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Theme.Theme.toggle()
    }
}
