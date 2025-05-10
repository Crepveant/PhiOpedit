import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: qsTr("PhiOpedit")

    Rectangle {
        anchors.fill: parent
        color: "#1a1a1a"

        SongStrip {
            id: strip
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
            onSelectedChanged: console.log("🎵 Selected:", strip.songs[strip.selectedIndex]["Name"])
            Component.onCompleted: {
                strip.songs = songLoader.loadSongs()
            }

        }
    }
    FontLoader {
        id: cmdysjFont
        source: "qrc:/fonts/cmdysj.ttf"
    }
    FontLoader {
        id: exoFont
        source: "qrc:/fonts/Exo-Regular.otf"
    }
}
