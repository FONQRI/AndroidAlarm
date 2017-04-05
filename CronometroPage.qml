import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Rectangle
            {

                Rectangle//Box
                {
                    id:box
                    //anchors.bottom: parent.bottom
                    //anchors.right: parent.right
                    width: 140
                    height:195;
                    y:parent.height
                    opacity: 0.7

                    color: "#000"
                    clip:true

                }//end Box
            }
