import QtQuick
import "../theme" as Theme
import "../services" as Services
import "../components" as Components

Components.BarWidget {
    id: root

    property var workspaces: Services.Workspaces

    color: Theme.Theme.background
    radius: Theme.Theme.widgetRadius

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: Theme.Theme.spacingSmall

        Repeater {
            model: root.workspaces.workspaces

            Rectangle {
                id: workspaceButton
                required property var modelData
                property bool hovered: false

                anchors.verticalCenter: parent.verticalCenter
                visible: modelData.id > 0  // Hide special workspaces (negative IDs)
                width: modelData.focused ? 20 : 13
                height: modelData.focused ? 20 : 13

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.5
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.5
                    }
                }

                radius: Theme.Theme.pillRadius

                // Determine color based on workspace state
                color: {
                    if (modelData.focused)
                        return Theme.Theme.accent;
                    if (modelData.urgent)
                        return Theme.Theme.warning;
                    if (hovered)
                        return Theme.Theme.backgroundTertiary;
                    return Theme.Theme.backgroundSecondary;
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                    }
                }

                Canvas {
                    anchors.centerIn: parent
                    width: parent.width * 0.7
                    height: parent.height * 0.7
                    opacity: workspaceButton.modelData.focused ? .75 : (workspaceButton.hovered ? .4 : .15)

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutBack
                            easing.overshoot: 1.5
                        }
                    }

                    onPaint: {
                        var ctx = getContext('2d');
                        var w = width;
                        var h = height;
                        var cx = w / 2;
                        var cy = h / 2;
                        var radius = Math.min(w, h) * 0.4;
                        var shapeColor = workspaceButton.modelData.focused ? Theme.Theme.background : Theme.Theme.text;

                        ctx.strokeStyle = shapeColor;
                        ctx.lineWidth = 2;
                        ctx.lineCap = 'round';
                        ctx.lineJoin = 'round';

                        var id = workspaceButton.modelData.id;

                        if (id === 1) {
                            // Circle
                            ctx.beginPath();
                            ctx.arc(cx, cy, radius, 0, 2 * Math.PI);
                            ctx.stroke();
                        } else if (id === 2) {
                            // Horizontal line
                            ctx.beginPath();
                            ctx.moveTo(cx - radius, cy);
                            ctx.lineTo(cx + radius, cy);
                            ctx.stroke();
                        } else {
                            // Polygon shapes (3-9)
                            var sides = id;
                            var startAngle = -Math.PI / 2;
                            var angleStep = 2 * Math.PI / sides;

                            ctx.beginPath();
                            for (var i = 0; i < sides; i++) {
                                var angle = startAngle + i * angleStep;
                                var x = cx + radius * Math.cos(angle);
                                var y = cy + radius * Math.sin(angle);
                                if (i === 0) {
                                    ctx.moveTo(x, y);
                                } else {
                                    ctx.lineTo(x, y);
                                }
                            }
                            ctx.closePath();
                            ctx.stroke();
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: workspaces.switchTo(modelData)
                    onEntered: workspaceButton.hovered = true
                    onExited: workspaceButton.hovered = false
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
