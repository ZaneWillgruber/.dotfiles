import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "../theme" as Theme

RowLayout {
    id: soundWidget
    spacing: 0
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    property var sink: Pipewire.defaultAudioSink
    property var audio: sink?.audio ?? null
    property real volume: audio?.volume ?? 0
    property bool muted: audio?.muted ?? false

    function volumeIcon(): string {
        if (muted || volume === 0) {
            return Theme.Theme.iconPath + "/audio-volume-muted-symbolic";
        } else if (volume > 1.0) {
            return Theme.Theme.iconPath + "/audio-volume-overamplified-symbolic";
        } else if (volume > 0.66) {
            return Theme.Theme.iconPath + "/audio-volume-high-symbolic";
        } else if (volume > 0.33) {
            return Theme.Theme.iconPath + "/audio-volume-medium-symbolic";
        } else {
            return Theme.Theme.iconPath + "/audio-volume-low-symbolic";
        }
    }

    IconImage {
        implicitWidth: Theme.Theme.iconSize
        implicitHeight: Theme.Theme.iconSize
        source: soundWidget.volumeIcon()
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            if (soundWidget.audio) {
                soundWidget.audio.muted = !soundWidget.audio.muted;
            }
        }
        onWheel: function (event) {
            if (soundWidget.audio) {
                var delta = event.angleDelta.y > 0 ? 0.05 : -0.05;
                soundWidget.audio.volume = Math.max(0, Math.min(1.5, soundWidget.audio.volume + delta));
            }
        }
    }
}
