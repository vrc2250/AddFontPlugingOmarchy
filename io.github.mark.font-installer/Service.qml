pragma Singleton

// Service.qml — headless singleton for Font Installer.
//
// No font logic lives here; the `font-installer` bash script is the single
// source of truth. This service only locates the script and shells out to it
// via Quickshell's Process, exposing simple callables + status to the UI.
//
// NOTE: This targets Omarchy 3's Quickshell-based shell. QML APIs should be
// verified against your installed Quickshell version.

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Absolute path to the bash workhorse shipped alongside this plugin.
    readonly property string pluginDir: Qt.resolvedUrl(".").toString().replace("file://", "")
    readonly property string cli: pluginDir + "font-installer"

    // Simple status surface for the UI to bind to.
    property bool busy: false
    property string lastOutput: ""
    property int lastExitCode: 0

    // Install one or more font files (absolute paths).
    function install(paths) {
        run(["install"].concat(paths))
    }

    // Install every font found under a directory (recursive).
    function installDir(dir) {
        run(["install-dir", dir])
    }

    // Remove installed fonts matching a name substring.
    function remove(name) {
        run(["remove", name])
    }

    // Rebuild the font cache.
    function refresh() {
        run(["refresh"])
    }

    // --- internal -----------------------------------------------------------

    function run(args) {
        proc.command = [root.cli].concat(args)
        root.busy = true
        proc.running = true
    }

    Process {
        id: proc
        running: false

        stdout: StdioCollector {
            onStreamFinished: root.lastOutput = this.text
        }

        onExited: function(exitCode, exitStatus) {
            root.lastExitCode = exitCode
            root.busy = false
        }
    }
}
