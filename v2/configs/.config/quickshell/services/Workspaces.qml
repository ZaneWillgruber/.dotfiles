// Dynamic Hyprland workspace service
pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root
    
    // Expose Hyprland workspaces ObjectModel
    property var workspaces: Hyprland.workspaces
    
    // Current focused workspace
    property var currentWorkspace: Hyprland.focusedWorkspace
    
    // Switch to workspace using Hyprland API
    function switchTo(workspace) {
        if (workspace && workspace.activate) {
            workspace.activate()
        }
    }
}
