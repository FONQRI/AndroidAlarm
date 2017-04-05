import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0

Canvas {
    id: canvas
    anchors.fill: parent
    antialiasing: true

    property color primaryColor: "#FF9800"
    property color secondaryColor: "#03A9F4"
    property real timeHour: myTime.hour
    property real timeMin: myTime.min
    property real timeSec: myTime.sec

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(canvas.width > canvas.height?canvas.height:canvas.width ) / 2 - (canvas.width > canvas.height?canvas.height:canvas.width )/10

    //draw binary Clock circles
    property real miniCircleadius: radius/15

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

    onTimeSecChanged: requestPaint()
    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onMinimumValueChanged: requestPaint()
    onMaximumValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");

        var dahgan= 0;
        var yekan = 0;

        ctx.save();
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        //createmain circle
        ctx.beginPath();
        ctx.lineWidth = 10;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth ,
                canvas.centerHeight ,
                canvas.radius,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angle);
        ctx.stroke();

        //filling bits array
        var bitArray = new Array(6);
        for(var i=0;i<6;i++)
            bitArray[ i ] = new Array(4);

        for(var i=0;i<6;i++)
            for(var j=0;j<4;j++)
            {
                bitArray[i][j] = 0;
            }
        //calculate for sec************************************************************************
        //yekan
        yekan=myTime.sec%10
        dahgan =myTime.sec >9?( myTime.sec - myTime.sec%10)/10:0

        if(yekan >= 8)
        {
            bitArray[5][0]=1;
            yekan -=8
        }
        if(yekan >= 4)
        {
            bitArray[5][1]=1;
            yekan -=4
        }
        if(yekan >= 2)
        {
            bitArray[5][2]=1;
            yekan -=2
        }
        if(yekan == 1)
        {
            bitArray[5][3]=1;
            yekan =0
        }
        //dahgan


        if(dahgan >=8 )
        {
            bitArray[4][0]=1;
            dahgan -=8

        }
        if(dahgan >= 4)
        {
            bitArray[4][1]=1;
            dahgan -=4

        }
        if(dahgan >= 2)
        {
            bitArray[4][2]=1;
            dahgan -=2

        }
        if(dahgan == 1)
        {
            bitArray[4][3]=1;
            dahgan =0
        }

        //calculate for Min************************************************************************
        //yekan
        yekan=myTime.min%10
        dahgan =myTime.min >9?( myTime.min - myTime.min%10)/10:0

        if(yekan >= 8)
        {
            bitArray[3][0]=1;
            yekan -=8
        }
        if(yekan >= 4)
        {
            bitArray[3][1]=1;
            yekan -=4
        }
        if(yekan >= 2)
        {
            bitArray[3][2]=1;
            yekan -=2
        }
        if(yekan == 1)
        {
            bitArray[3][3]=1;
            yekan =0
        }
        //dahgan


        if(dahgan >=8 )
        {
            bitArray[2][0]=1;
            dahgan -=8

        }
        if(dahgan >= 4)
        {
            bitArray[2][1]=1;
            dahgan -=4

        }
        if(dahgan >= 2)
        {
            bitArray[2][2]=1;
            dahgan -=2

        }
        if(dahgan == 1)
        {
            bitArray[2][3]=1;
            dahgan =0
        }

        //calculate for hour************************************************************************
        //yekan
        yekan=myTime.hour%10
        dahgan =myTime.hour >9?( myTime.hour - myTime.hour%10)/10:0

        if(yekan >= 8)
        {
            bitArray[1][0]=1;
            yekan -=8
        }
        if(yekan >= 4)
        {
            bitArray[1][1]=1;
            yekan -=4
        }
        if(yekan >= 2)
        {
            bitArray[1][2]=1;
            yekan -=2
        }
        if(yekan == 1)
        {
            bitArray[1][3]=1;
            yekan =0
        }
        //dahgan


        if(dahgan >=8 )
        {
            bitArray[0][0]=1;
            dahgan -=8

        }
        if(dahgan >= 4)
        {
            bitArray[0][1]=1;
            dahgan -=4

        }
        if(dahgan >= 2)
        {
            bitArray[0][2]=1;
            dahgan -=2

        }
        if(dahgan == 1)
        {
            bitArray[0][3]=1;
            dahgan =0
        }



//        for(var i=0;i<6;i++)
//            console.log(bitArray[i])



        //drawing Binary clock base circles
        for (var i=-7.5*miniCircleadius + centerWidth , c1=0;i< 7.5*miniCircleadius+ centerWidth;i+=2*miniCircleadius , c1++)
        {
            if(c1 %2 == 0)
                i+=miniCircleadius;
            else
                i+=0.5*miniCircleadius;
            for(var j =-4.5*miniCircleadius + centerHeight,c2 = 0;j< 4.5*miniCircleadius+ centerHeight ;j+=3*miniCircleadius, c2++)
            {
                if(bitArray[c1][c2]  == 0 )
                    primaryColor ="#37474f"
                else
                    primaryColor = "#3d5afe"
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.fillStyle = primaryColor;
                ctx.arc(i ,j ,canvas.miniCircleadius,canvas.angleOffset, canvas.angleOffset + canvas.angle);
                ctx.fill();

            }
        }
    }


    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: canvas.clicked()
        onPressedChanged: canvas.requestPaint()
    }

}

