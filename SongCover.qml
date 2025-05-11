import QtQuick

Item {
    id: root
    width: 600
    height: 340
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 80

    property var songs: []
    property int selectedIndex: 0
    property real skewRate: 180 / 720
    property string imagePath: ""

    Connections {
        target: root
        onSongsChanged: updateImage()
        onSelectedIndexChanged: updateImage()
    }

    function updateImage() {
        if (songs.length > 0 && songs[selectedIndex] && songs[selectedIndex]["Picture"])
            imagePath = songs[selectedIndex]["Picture"]
        else
            imagePath = ""
    }

    onImagePathChanged: {
        canvas.requestPaint()
    }

    Image {
        id: img
        source: (songs.length > 0 && songs[selectedIndex] && songs[selectedIndex]["Picture"]) ? songs[selectedIndex]["Picture"] : ""
        visible: false
        asynchronous: true
        cache: true
        onStatusChanged: {
            if (status === Image.Ready)
                canvas.requestPaint()
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            const ctx = getContext("2d")
            ctx.reset()
            const dx = height * skewRate
            if (songs.length === 0 || !imagePath || img.status !== Image.Ready) {
                ctx.fillStyle = "#80000000"
                ctx.beginPath()
                ctx.moveTo(dx, 0)
                ctx.lineTo(width, 0)
                ctx.lineTo(width - dx, height)
                ctx.lineTo(0, height)
                ctx.closePath()
                ctx.fill()

                ctx.fillStyle = "#ccc"
                ctx.font = "28px sans-serif"
                ctx.textAlign = "center"
                ctx.textBaseline = "middle"
                ctx.fillText(songs.length === 0 ? "暂无项目文件" : "暂无曲绘", width / 2, height / 2)
                return
            }

            ctx.save()
            ctx.beginPath()
            ctx.moveTo(dx, 0)
            ctx.lineTo(width, 0)
            ctx.lineTo(width - dx, height)
            ctx.lineTo(0, height)
            ctx.closePath()
            ctx.clip()

            const imgRatio = img.paintedHeight / img.paintedWidth
            const targetWidth = width
            const targetHeight = targetWidth * imgRatio
            const offsetY = (height - targetHeight) / 2

            ctx.drawImage(img, 0, offsetY, targetWidth, targetHeight)
            ctx.restore()
        }

        Component.onCompleted: requestPaint()
    }
}
