import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0

Canvas {
    id: canvas
    anchors.fill: parent
    antialiasing: true


    property color primaryColor: "#FF9800"
    property color secondaryColor: "#03A9F4"

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(canvas.width > canvas.height?canvas.height:canvas.width ) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10

    property real minimumValue: 0
    property real maximumValue: 100
    property double currentValue: 100

    // this is the angle that splits the circle in two arcs
    // first arc is drawn from 0 radians to angle radians
    // second arc is angle radians to 2*PI radians
    property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

    // we want both circle to start / end at 12 o'clock
    // without this offset we would start / end at 9 o'clock
    property real angleOffset: -Math.PI / 2

    property string text

    signal clicked()

    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onMinimumValueChanged: requestPaint()
    onMaximumValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        ctx.beginPath();
        ctx.lineWidth = 10;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.centerHeight ,
                canvas.radius,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angle);
        ctx.stroke();

        ctx.restore();
    }
    Text{
        color:"#3d5afe"
        anchors.centerIn: parent
        text:myTime.hour+ " : "+ myTime.min +" : "+ myTime.sec
        font{
            pixelSize: parent.width/10
        }

    }



}

