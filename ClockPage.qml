import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "Clocks"
Item {
    anchors.fill: parent

    //setting Matrial property
    Material.theme:Material.Dark
    Material.accent: Material.LightBlue
    Material.foreground: Material.Cyan

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Page{
            UsualClock{
            }
        }


        Page{
            CircularClock{

            }
        }
        Page {
            BinaryClock{
                anchors.centerIn: parent
                text:"Binary"

            }
        }





    }


    TabBar {
        anchors.bottom: parent.bottom
        width: parent.width
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Usual")
        }
        TabButton {
            text: qsTr("Circular")
        }
        TabButton {
            text: qsTr("Binary")
        }



    }
}
