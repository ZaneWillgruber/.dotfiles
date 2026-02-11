import QtQuick
import "../theme" as Theme

Rectangle {
    id: root
    default property alias content: contentContainer.children

    // Configurable properties
    property bool transparent: false

    // Styling
    color: transparent ? "transparent" : Theme.Theme.background
    radius: Theme.Theme.widgetRadius
    height: parent ? parent.height : Theme.Theme.barHeight
    width: contentContainer.implicitWidth + Theme.Theme.spacingLarge * 2

    // Content container
    Item {
        id: contentContainer
        anchors.verticalCenter: parent.verticalCenter
        x: Theme.Theme.spacingLarge
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}
