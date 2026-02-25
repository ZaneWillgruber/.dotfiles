import QtQuick
import "../theme" as Theme
import "../services" as Services

Text {
    text: Services.Time.time
    color: Theme.Theme.text
    font {
        family: Theme.Theme.fontFamily
        pixelSize: 12
    }
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
