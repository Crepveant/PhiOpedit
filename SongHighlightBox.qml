import QtQuick
Canvas {
    width: 400
    height: 90
    onPaint: {
        const ctx = getContext("2d")
        ctx.fillStyle = "#80000000"
        const dx = height * (180/720)
        ctx.beginPath()
        ctx.moveTo(dx, 0)
        ctx.lineTo(width, 0)
        ctx.lineTo(width - dx, height)
        ctx.lineTo(0, height)
        ctx.closePath()
        ctx.fill()
    }
}
