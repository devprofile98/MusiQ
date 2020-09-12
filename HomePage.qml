import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Page{
    property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]

    id: mainView
    clip: true
    background: Rectangle{
        color:Qt.rgba(61,61, 58,0.05)
        radius: 10
    }

    header: Rectangle
    {

        width:parent.width
        Label{
            text: "Home"
            font{
                bold:true

            }
            color:Qt.rgba(61,61, 58,0.5)
        }
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:10

    }


    ColumnLayout{
        anchors.top: mainView.top
        anchors.left: mainView.left
        anchors.right: mainView.right
        anchors.topMargin: 50
        spacing: 10
        width: mainView.width
        height: mainView.height/4

        ListView{
            id:mostplayed
            currentIndex: 4
            Layout.fillWidth: true
            Layout.preferredHeight: mainView.width/5
            Layout.margins: 20
            Layout.topMargin: 40
            //            anchors.topMargin: 100
            orientation: ListView.Horizontal
            model:10
            spacing: 10
            delegate: Rectangle{
                //                state: mostplayed.currentIndex === model.index ? "selected" : "default"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 20
                width: mostplayed.currentIndex === model.index ?mostplayed.height+20 : mostplayed.height
                height: width
                color:mainView.colors[Math.floor(Math.random()*6)]


                Behavior on width {
                    NumberAnimation{
//                        to:20
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: mostplayed.currentIndex = model.index;
                }

            }



        }

    }



}
