import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0
ApplicationWindow {


    visible: true

    width: Screen.width>Screen.height?480:Screen.width
    height: Screen.width>Screen.height?750:Screen.height
//    x:Screen.width>Screen.height?Screen.width/2 - width/2:0
//    y:Screen.width>Screen.height?Screen.height/2 - height/2:0
    title: qsTr("Alarm")

    //setting Matrial property
    Material.theme:Material.Dark
    Material.accent: Material.LightBlue
    Material.foreground: Material.Blue
    Shortcut {
        sequence:"Ctrl+Q"
        onActivated: Qt.quit()
    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page{
             ClockPage{

             }
        }


Page{
     AlarmPage{


     }
}
        Page {
            TimerPage{

            }
        }


    Page {
        CronometroPage{

        }
    }
}


    TabBar {
        id: tabBar
        anchors.top: parent.top
        width: parent.width
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Clock")
        }
        TabButton {
            text: qsTr("Alarm")
        }
        TabButton {
            text: qsTr("Timer")
        }
        TabButton {
            text: qsTr("Cronometro")
        }
    }
}
