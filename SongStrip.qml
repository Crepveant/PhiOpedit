import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property var songs: []
    property int selectedIndex: 0
    property var songItems: []
    property int baseOffset: 180
    property real skewRate: baseOffset / height
    signal selectedChanged()

    width: 540
    height: 720
    focus: true
    Keys.priority: Keys.BeforeItem

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Up) {
            if (selectedIndex > 0) {
                selectedIndex--
                selectedChanged()
            }
            event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            if (selectedIndex < songs.length - 1) {
                selectedIndex++
                selectedChanged()
            }
            event.accepted = true
        }
    }

    Canvas {
        id: bg
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d")
            ctx.reset()
            ctx.fillStyle = "#0fffffff"
            const dx = height * root.skewRate;
            ctx.beginPath();
            ctx.moveTo(dx, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width - dx, height);
            ctx.lineTo(0, height);
            ctx.closePath();
            ctx.fill();
        }
    }

    SongHighlightBox {
        id: highlight
        visible: songs.length > 0
        width: 400
        height: 90
        x: 105
        y: 175
        z: 5
    }

    Repeater {
        model: songs
        delegate: Rectangle {
            id: songItem
            width: Math.max(nameText.paintedWidth, authorText.paintedWidth) + 40
            height: 100
            color: "transparent"

            Behavior on x {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            Behavior on y {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }

            x: calculateX(index)
            y: calculateY(index)
            z: 10

            Text {
                id: nameText
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: modelData["Name"] ?? "未命名作品"
                color: index === selectedIndex ? "white" : "#aaa"
                font.family: cmdysjFont.name
                font.pixelSize: index === selectedIndex ? 28 : 26
            }

            Text {
                id: authorText
                visible: index === selectedIndex
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                color: "white"
                text: (modelData["Composer"] ?? "") + (modelData["Charter"] ? (" / " + modelData["Charter"]) : "")
                font.family: cmdysjFont.name
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.selectedIndex = index
                    root.selectedChanged()
                }
            }

            Component.onCompleted: songItems[index] = songItem
        }
    }

    function calculateX(index) {
        const yDiff = calculateY(index) - highlight.y
        return 140 - yDiff * root.skewRate
    }

    function calculateY(index) {
        if (index === selectedIndex) {
            return highlight.y - 20
        } else if (index < selectedIndex) {
            return highlight.y - (selectedIndex - index) * 80
        } else {
            return highlight.y + (index - selectedIndex) * 80
        }
    }

    Text {
        anchors.centerIn: parent
        visible: songs.length === 0
        text: "暂无项目文件"
        color: "#888"
        font.family: cmdysjFont.name
        font.pixelSize: 24
    }
}
