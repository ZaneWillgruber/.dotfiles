// MPRIS Media Player Service
pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root

    // The primary/active player (first available)
    readonly property MprisPlayer player: Mpris.players.length > 0 ? Mpris.players[0] : null

    // Track metadata
    readonly property string trackTitle: player ? player.trackTitle : ""
    readonly property string trackArtist: player ? player.trackArtist : ""
    readonly property string trackAlbum: player ? player.trackAlbum : ""
    readonly property string trackArtUrl: player ? player.trackArtUrl : ""

    // Playback state
    readonly property bool isPlaying: player ? player.isPlaying : false
    readonly property bool canTogglePlaying: player ? player.canTogglePlaying : false
    readonly property bool canSeek: player ? player.canSeek : false

    // Position and length (in seconds)
    readonly property real position: player ? player.position : 0
    readonly property real length: player && player.lengthSupported ? player.length : 0
    readonly property bool positionSupported: player ? player.positionSupported : false

    // Toggle play/pause
    function togglePlay() {
        if (player && player.canTogglePlaying) {
            player.isPlaying = !player.isPlaying
        }
    }

    // Seek to position (0.0 to 1.0)
    function seekTo(progress) {
        if (player && player.canSeek && player.length > 0) {
            player.position = progress * player.length
        }
    }

    // Timer to update position while playing
    Timer {
        running: root.isPlaying && root.positionSupported
        interval: 1000
        repeat: true
        onTriggered: {
            if (root.player) {
                root.player.positionChanged()
            }
        }
    }
}
