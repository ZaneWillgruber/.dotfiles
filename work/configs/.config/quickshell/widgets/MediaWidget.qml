import QtQuick
import "../components" as Components
import "../theme" as Theme
import "../services" as Services

Components.BarWidget {
    id: root

    property var media: Services.Media

    // Wider to accommodate the media widget content
    width: 200

    // Album art background
    Image {
        id: albumArt
        anchors.fill: parent
        source: media.trackArtUrl || ""
        fillMode: Image.PreserveAspectCrop
        visible: media.trackArtUrl !== ""
        opacity: 0.3
    }

    // Dark overlay for readability
    Rectangle {
        anchors.fill: parent
        color: Theme.Theme.background
        opacity: 0.7
        radius: parent.radius
    }

    // Content row
    Row {
        id: contentRow
        anchors {
            fill: parent
            margins: Theme.Theme.spacingSmall
        }
        spacing: Theme.Theme.spacingSmall

        // Spotify icon
        Text {
            text: "🎵"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            visible: media.player !== null
        }

        // Track info column
        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            visible: media.player !== null

            // Track title
            Text {
                text: media.trackTitle || "No Track"
                color: Theme.Theme.text
                font {
                    family: Theme.Theme.fontFamily
                    pixelSize: Theme.Theme.fontSizeSmall
                    bold: true
                }
                elide: Text.ElideRight
                width: contentRow.width - 60
            }

            // Artist
            Text {
                text: media.trackArtist || ""
                color: Theme.Theme.textMuted
                font {
                    family: Theme.Theme.fontFamily
                    pixelSize: 10
                }
                elide: Text.ElideRight
                width: contentRow.width - 60
            }
        }

        // Play/Pause button
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: mouseArea.containsMouse ? Theme.Theme.accentHover : Theme.Theme.accent
            visible: media.canTogglePlaying

            Text {
                anchors.centerIn: parent
                text: media.isPlaying ? "⏸" : "▶"
                color: Theme.Theme.background
                font.pixelSize: 10
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: media.togglePlay()
            }
        }
    }

    // Progress bar at bottom
    Rectangle {
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            bottomMargin: 2
            leftMargin: Theme.Theme.spacing
            rightMargin: Theme.Theme.spacing
        }
        height: 2
        radius: 1
        color: Theme.Theme.backgroundSecondary
        visible: media.positionSupported && media.length > 0

        Rectangle {
            height: parent.height
            radius: parent.radius
            color: Theme.Theme.accent
            width: parent.width * (media.position / media.length)
        }
    }

    // Empty state when no player
    Text {
        anchors.centerIn: parent
        text: "No Media"
        color: Theme.Theme.textMuted
        font {
            family: Theme.Theme.fontFamily
            pixelSize: Theme.Theme.fontSizeSmall
        }
        visible: media.player === null
    }
}
