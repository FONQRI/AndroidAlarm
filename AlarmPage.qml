import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Item {
    width: 300
    height: 300
    Rectangle{
        anchors.fill: parent
        color:"white"
        RadialGradient {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: "black" }
            }
        }
    }
}
