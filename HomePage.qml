import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import roundedrect 1.0
Page{
    property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]
    property real elementSize: 200
    property color mainFront: globalstyle.mainFG
    property color mainBack: globalstyle.mainBG
    property color mainItem: globalstyle.itemBG

    id: mainView
    clip: true
    background: RoundedRect{
        color:mainItem//Qt.rgba(61,61, 58,0.05)
        toprightRadius: 20
        topleftRadius: 20
        bottomleftRadius: 20
        bottomrightRadius: 20
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
            Layout.preferredHeight: elementSize //mainView.width/5
            Layout.alignment: Qt.AlignVCenter
            Layout.margins: 20
            Layout.topMargin: 40
            orientation: ListView.Horizontal
            model:10
            spacing: 10
            delegate: Rectangle{
                radius: 10
//                anchors.verticalCenter: mostplayed.verticalCenter
                anchors.margins: 20
                width: mostplayed.currentIndex === model.index ?elementSize : elementSize
                height: width
                color:mainView.colors[Math.floor(Math.random()*6)]

                Behavior on width {
                    NumberAnimation{
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mostplayed.currentIndex = model.index;
                        queue.currentIndex = -1;
                    }
                }
            }
        }


        ListView{
            id:queue
            currentIndex: 2
            Layout.fillWidth: true
            Layout.preferredHeight: elementSize //mainView.width/5
            Layout.alignment: Qt.AlignVCenter
            Layout.margins: 20
            Layout.topMargin: 20
            orientation: ListView.Horizontal
            model:4
            spacing: 10
            delegate: Rectangle{
                radius: 10
//                anchors.verticalCenter: queue.verticalCenter
                anchors.margins: 20
                anchors.topMargin: 0
                width: queue.currentIndex === model.index ?elementSize : elementSize
                height: width
                color:mainView.colors[Math.floor(Math.random()*6)]

                Behavior on width {
                    NumberAnimation{
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        queue.currentIndex = model.index;
                        mostplayed.currentIndex = -1;
                    }
                }
            }
        }

    }



}
