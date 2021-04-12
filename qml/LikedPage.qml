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
        toprightRadius: 10
        topleftRadius: 10
        bottomleftRadius: 10
        bottomrightRadius: 10
    }

    header: Rectangle
    {
        id:maintitle

        width:parent.width
        Label{
            text: "Liked"
            font{
                bold:true
            }
            color:Qt.rgba(61,61, 58,0.5)
        }
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:10
    }

    GridView{
        id:queue
        //        anchors.top: mainView.top
        //        anchors.left: mainView.left
        //        anchors.right: mainView.right
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.topMargin: 40
        anchors.leftMargin: 15


        width: mainView.width
        height: mainView.height
        cellWidth: mainView.width / 6 -10
        cellHeight: cellWidth

        //        currentIndex: 2
        model:40
        delegate:
            Item{
            width: mainView.width / 6 - 10
            height: width
            Rectangle{
                radius: 10
                width: parent.width - 10 //queue.currentIndex === model.index ?elementSize : elementSize
                anchors.centerIn: parent
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




