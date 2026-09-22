// Menu.qml — summoned menu for Font Installer.
//
// A minimal UI: type/paste a path to a font file or a folder of fonts, then
// install. All work is delegated to Service.qml (which calls the bash script).
//
// This is intentionally lean scaffolding — style it to match your Omarchy
// theme and swap the TextField for a proper file picker when ready.

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "." as Plugin

Item {
    id: menu
    implicitWidth: 480
    implicitHeight: 220

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Label {
            text: "Install fonts (.ttf / .otf / .ttc)"
            font.bold: true
        }

        TextField {
            id: pathField
            Layout.fillWidth: true
            placeholderText: "/path/to/font.ttf  or  /path/to/fonts-folder"
        }

        RowLayout {
            spacing: 8

            Button {
                text: "Install file"
                enabled: !Plugin.Service.busy && pathField.text.length > 0
                onClicked: Plugin.Service.install([pathField.text])
            }

            Button {
                text: "Install folder"
                enabled: !Plugin.Service.busy && pathField.text.length > 0
                onClicked: Plugin.Service.installDir(pathField.text)
            }

            Button {
                text: "Refresh cache"
                enabled: !Plugin.Service.busy
                onClicked: Plugin.Service.refresh()
            }

            Item { Layout.fillWidth: true }

            BusyIndicator {
                running: Plugin.Service.busy
                visible: Plugin.Service.busy
            }
        }

        Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: Plugin.Service.lastOutput
            color: Plugin.Service.lastExitCode === 0 ? "green" : "red"
        }
    }
}
