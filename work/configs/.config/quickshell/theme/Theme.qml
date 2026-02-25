// Unified theme singleton with runtime switching and persistence
pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // Reference to the config adapter (inside FileView)
    property var config: themeFile.adapter

    // Bar styling
    property int barHeight: 48
    property int barPadding: 8
    property int barMargin: 8

    // Fonts
    property string fontFamily: "Segoe UI Variable Static Text"
    property int fontSize: 14
    property int fontSizeSmall: 12

    // Icons
    property string iconPath: "file:///usr/share/icons/Win11-dark/status/symbolic/"
    property int iconSize: 18
    property string assetPath: "file:///home/zane/.config/quickshell/assets/"

    // Spacing
    property int spacing: 8
    property int spacingSmall: 4
    property int spacingLarge: 16

    // Widget styling
    property int widgetPadding: 8
    property int widgetRadius: 16
    property int pillRadius: 12

    // Palettes
    readonly property var palettes: ({
            dark: {
                background: "#80202020",
                backgroundSecondary: "#313244",
                text: "#FFFFFF",
                textMuted: "#a6adc8",
                accent: "#89b4fa",
                accentHover: "#b4befe",
                border: "#45475a",
                warning: "#f38ba8"
            },
            light: {
                background: "#eff1f5",
                backgroundSecondary: "#ccd0da",
                text: "#4c4f69",
                textMuted: "#6c6f85",
                accent: "#1e66f5",
                accentHover: "#7287fd",
                border: "#bcc0cc",
                warning: "#d20f39"
            }
        })

    // Computed color properties
    property color background: palettes[config.currentPalette].background
    property color backgroundSecondary: palettes[config.currentPalette].backgroundSecondary
    property color text: palettes[config.currentPalette].text
    property color textMuted: palettes[config.currentPalette].textMuted
    property color accent: palettes[config.currentPalette].accent
    property color accentHover: palettes[config.currentPalette].accentHover
    property color border: palettes[config.currentPalette].border
    property color warning: palettes[config.currentPalette].warning

    // Expose current palette name
    readonly property string currentPalette: config.currentPalette

    // Toggle between light and dark
    function toggle() {
        config.currentPalette = config.currentPalette === "dark" ? "light" : "dark";
    }

    // Set specific palette
    function setPalette(name) {
        if (palettes.hasOwnProperty(name)) {
            config.currentPalette = name;
        }
    }

    // FileView with JsonAdapter for persistence
    FileView {
        id: themeFile
        path: Quickshell.dataPath('theme.json')

        JsonAdapter {
            id: configAdapter
            property string currentPalette: "dark"
        }

        watchChanges: true
        onAdapterUpdated: writeAdapter()
        blockLoading: true
    }
}
