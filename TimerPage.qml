import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0



Canvas {
    id: canvas
    anchors.fill: parent
    antialiasing: true
    property color primaryColor: "#FF9800"
    property color secondaryColor: "#03A9F4"
    property bool centerTextStatus: myTimer.running
    property bool isTextNull: false
    property bool textFildFocus: false

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: (Math.min(canvas.width > canvas.height?canvas.height:canvas.width ) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10)/1.5

    property real minimumValue: 0
    property real maximumValue: myTimer.qmlSec
    property double currentValue: myTimer.second

    // this is the angle that splits the circle in two arcs
    // first arc is drawn from 0 radians to angle radians
    // second arc is angle radians to 2*PI radians
    property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

    // we want both circle to start / end at 12 o'clock
    // without this offset we would start / end at 9 o'clock
    property real angleOffset: -Math.PI / 2

    property int text

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

        // fills the mouse area when pressed
        // the fill color is a lighter version of the
        // secondary color



        // First, thinner arc
        // From angle to 2*PI

        ctx.beginPath();
        ctx.lineWidth = 1;
        ctx.strokeStyle = primaryColor;
        ctx.arc(canvas.centerWidth,
                canvas.height/1.5,
                canvas.radius,
                angleOffset + canvas.angle,
                angleOffset + 2*Math.PI);
        ctx.stroke();


        // Second, thicker arc
        // From 0 to angle

        ctx.moveTo(20,20)
        ctx.beginPath();
        ctx.lineWidth = 10;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.height/1.5 ,
                canvas.radius,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angle);

        ctx.stroke();

        ctx.restore();
    }
    Text {
        id:statusText
        x:parent.width/2 - width/2
        y:parent.height/1.5 - height/2
        text:"Start"
        PropertyAnimation {id: statusTextAnimText; target: statusText; properties: "text";from:centerTextStatus?"Start":"Stop"; to:centerTextStatus? "Start":"Stop"; duration: 500}
        color: canvas.primaryColor
    }

    Text {
        id:counterText
        x:parent.width/2 - width/2
        y:parent.height/1.5 - height/2
        text:myTimer.second<59000?(myTimer.second/1000).toFixed(2):myTimer.showTime
        opacity: 0
        PropertyAnimation {id: counterTextAnim; target: counterText; properties: "opacity";from:!centerTextStatus?1:0; to:centerTextStatus?0:1; duration: 500;running: false}
        color: canvas.primaryColor
    }


    Tumbler {
        id:hourTumber
        x:canvas.width/2 - width*1.5
        y:canvas.height/10
        model: 24
        visibleItemCount: 5
        onCurrentIndexChanged: {

            if(centerTextStatus == true)
            {
                statusTextAnimText.start()
                statusTextAnim.start()
                counterTextAnim.start()
                myTimer.stop()
                myTimer.second=0
                centerTextStatus=false

            }

        }
    }
    Text {
        x:canvas.width/2 - hourTumber.width - width/2
        y:canvas.height/10 - height
        text:"H"
        color: canvas.primaryColor
    }
    Tumbler {
        id:minTumber
        x:canvas.width/2 - width/2
        y:canvas.height/10
        model: 60
        visibleItemCount: 5
        onCurrentIndexChanged: {

            if(centerTextStatus == true)
            {
                statusTextAnimText.start()
                statusTextAnim.start()
                counterTextAnim.start()
                myTimer.stop()
                myTimer.second=0
                centerTextStatus=false

            }

        }
    }
    Text {
        x:canvas.width/2 - width/2
        y:canvas.height/10 - height
        text:"M"
        color: canvas.primaryColor
    }
    Tumbler {
        id:secTumber
        x:canvas.width/2 + width/2
        y:canvas.height/10
        model: 60
        visibleItemCount: 5
        onCurrentIndexChanged: {

            if(centerTextStatus == true)
            {
                statusTextAnimText.start()
                statusTextAnim.start()
                counterTextAnim.start()
                myTimer.stop()
                myTimer.second=0
                centerTextStatus=false

            }

        }
    }
    Text {
        x:canvas.width/2 + secTumber.width - width/2
        y:canvas.height/10 - height
        text:"S"
        color: canvas.primaryColor
    }
    Button{
        width: canvas.radius *2
        height: canvas.radius *2

        x:parent.width/2 - width/2
        y:parent.height/1.5 - canvas.radius
        background: Rectangle{
            radius: canvas.radius
            color:"transparent"


        }
        onReleased:
        {


            if(true)
            {

                statusTextAnim.start()
                if(!centerTextStatus)
                {

                    statusTextAnimText.start()
                    counterTextAnim.start()
                    myTimer.start(hourTumber.currentIndex,minTumber.currentIndex,secTumber.currentIndex)
                    centerTextStatus =true

                }
                else
                {
                    statusTextAnimText.start()
                    counterTextAnim.start()
                    myTimer.stop()
                    myTimer.second=0
                    centerTextStatus=false

                }
            }
            else
            {
                isTextNull= true
            }

        }
    }

    NumberAnimation {
        id:statusTextAnim
        target: statusText
        property: "y"
        to:!centerTextStatus?parent.height/1.5  - 5*statusText.height/2 : parent.height/1.5 - statusText.height/2
        duration: 500
        easing.type: Easing.Linear
    }


}


