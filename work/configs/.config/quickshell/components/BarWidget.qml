import QtQuick
import Qt5Compat.GraphicalEffects
import "../theme" as Theme

Row {
    id: root
    spacing: 0
    leftPadding: -8
    rightPadding: -8
    default property alias content: contentContainer.children

    // Configurable properties
    property bool transparent: false

    height: Theme.Theme.barHeight

    // Left circle with inverse mask (square with hole)
    Item {
        width: root.height
        height: width

        Rectangle {
            id: leftSquare
            anchors.fill: parent
            color: Theme.Theme.background
            visible: false
        }

        Rectangle {
            id: leftCircleMask
            anchors.fill: parent
            topRightRadius: width / 2
            color: "black"
            visible: false
        }

        OpacityMask {
            anchors.fill: parent
            source: leftSquare
            maskSource: leftCircleMask
            invert: true
        }
    }

    // Main content rectangle
    Rectangle {
        id: barBackground
        color: transparent ? "transparent" : Theme.Theme.background
        bottomLeftRadius: Theme.Theme.widgetRadius
        bottomRightRadius: Theme.Theme.widgetRadius
        height: root.height
        width: contentContainer.implicitWidth + Theme.Theme.spacingLarge * 2

        // Content container
        Item {
            id: contentContainer
            anchors.centerIn: parent
            x: Theme.Theme.spacingLarge
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
        }
    }

    // Right circle with inverse mask (square with hole)
    Item {
        width: root.height
        height: width

        Rectangle {
            id: rightSquare
            anchors.fill: parent
            color: Theme.Theme.background
            visible: false
        }

        Rectangle {
            id: rightCircleMask
            anchors.fill: parent
            topLeftRadius: width / 2
            color: "black"
            visible: false
        }

        OpacityMask {
            anchors.fill: parent
            source: rightSquare
            maskSource: rightCircleMask
            invert: true
        }
    }
}
