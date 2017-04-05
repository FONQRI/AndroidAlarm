import QtQuick 2.7
import QtQuick.Window 2.0


Canvas {
    id: canvas
    anchors.fill: parent
    antialiasing: true


    property color primaryColor: "#FF9800"
    property color secondaryColor: "#3d5afe"

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real  hourCircleWidth: 10
    property real  minCircleWidth: 5
    property real  secCircleWidth: 2
    property real radiusHour: Math.min(canvas.width > canvas.height?canvas.height:canvas.width) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10
    property real radiusMin: Math.min(canvas.width > canvas.height?canvas.height:canvas.width) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10 - hourCircleWidth
    property real radiusSec:Math.min(canvas.width > canvas.height?canvas.height:canvas.width) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10 - 2*hourCircleWidth

    //hour values
    property real minimumValueHour: 0
    property real maximumValueHour: 12
    property double currentValueHour: myTime.hour < 12?myTime.hour :myTime.hour - 12

    //min values
    property real minimumValueMin: 0
    property real maximumValueMin: 60
    property double currentValueMin: myTime.min

    //sec values
    property real minimumValueSec: 0
    property real maximumValueSec: 60
    property double currentValueSec: myTime.sec

    // this is the angle that splits the circle in two arcs
    // first arc is drawn from 0 radians to angle radians
    // second arc is angle radians to 2*PI radians
    property real angleHour: (currentValueHour - minimumValueHour) / (maximumValueHour - minimumValueHour) * 2 * Math.PI
    property real angleMin: (currentValueMin - minimumValueMin) / (maximumValueMin - minimumValueMin) * 2 * Math.PI
    property real angleSec: (currentValueSec - minimumValueSec) / (maximumValueSec - minimumValueSec) * 2 * Math.PI

    // we want both circle to start / end at 12 o'clock
    // without this offset we would start / end at 9 o'clock
    property real angleOffset: -Math.PI/2



    signal clicked()

    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onMinimumValueHourChanged: requestPaint()
    onMaximumValueHourChanged: requestPaint()
    onCurrentValueHourChanged: requestPaint()
    onCurrentValueSecChanged: requestPaint()
    onCurrentValueMinChanged: requestPaint()
    onPaint: {
        var ctx = getContext("2d");
        ctx.save();

        ctx.clearRect(0, 0, canvas.width, canvas.height);


        //circle for hour
        ctx.beginPath();
        ctx.lineWidth = hourCircleWidth;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.centerHeight ,
                canvas.radiusHour,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angleHour);
        ctx.stroke();

        //moving to begin

        //corcle for min
        ctx.beginPath();
        ctx.lineWidth = minCircleWidth;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.centerHeight ,
                canvas.radiusMin,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angleMin);
        ctx.stroke();



        //moving to begin

        //circle for sec
        ctx.beginPath();
        ctx.lineWidth = secCircleWidth;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.centerHeight ,
                canvas.radiusSec,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angleSec);
        ctx.stroke();


        ctx.restore();
    }
    Text {
        anchors.centerIn: parent
font.pixelSize: parent.width/10
        text: myTime.hour <12 ?"AM":"PM"
        color: canvas.primaryColor
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: canvas.clicked()
        onPressedChanged: canvas.requestPaint()
    }

}

