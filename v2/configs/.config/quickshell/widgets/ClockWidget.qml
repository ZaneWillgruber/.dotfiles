import QtQuick
import "../components" as Components
import "../theme" as Theme
import "../services" as Services

Components.BarWidget {
    Text {
        text: Services.Time.time
        color: Theme.Theme.text
        font {
            family: Theme.Theme.fontFamily
            pixelSize: Theme.Theme.fontSize
            bold: true
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
