import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Rectangle{
    id:mainrect

    property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]

    visible: false
    radius: 10
    //    anchors.fill: parent
    color: globalstyle.itemBG
    //    color:"/*red*/"
    clip:true
    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {

            }
            AnchorChanges{

            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {

            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {


            }


        }

    ]

    state: "desktop_mode"
    RowLayout{
        id:killersec
        width: implicitWidth
        height: implicitHeight
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        spacing: 10
        Tumbler{
            id:htumbler
            model:12
            font
            {
                bold:true
            }
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignLeft

        }
        Tumbler{
            id:mtumbler
            model:59
            font
            {
                bold:true
            }
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignLeft
        }
        Tumbler{
            id:stumbler
            model:59
            font
            {
                bold:true
            }
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignRight
        }

        Rectangle{
            id:terminatebtn
            width: 40
            height: 40
            Layout.alignment: Qt.AlignCenter
            color:"transparent"
            Label{
                text:"\uf144"
                font{
                    pixelSize: 25
                    family: solidfont.name

                }
                color:globalstyle.mainFG
                MouseArea{
                    anchors.fill: parent

                    onClicked:{
                        terminatetimer.interval = htumbler.currentIndex *(60*60*1000) + mtumbler.currentIndex*(60*1000) + stumbler.currentIndex*(1000)
                        terminatetimer.start()

                    }

                }

                anchors.centerIn: parent
            }

            Timer{
                id:terminatetimer
                running: false
                onTriggered: {
                    controller.changeOnPlayBtnPressed(!mainwindow.isPlaying)
                }
            }
        }

    }

    //    RowLayout{
    //        id:frontColorsec
    //        anchors.top:killersec.bottom
    //        anchors.horizontalCenter: killersec.horizontalCenter
    //        anchors.topMargin: 20

    //    }

    Row{

        id:settingsep
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: killersec.bottom
        anchors.topMargin: 20
        width: parent.width - 100
        spacing: 20

        Label{
            id:lblid
            text: "Appearence"
            font{
                bold: true
            }
            color:Qt.rgba(61,61, 58,0.5)
            width: implicitWidth
        }

        Rectangle{

            width: settingsep.width - lblid.width
            anchors.verticalCenter: lblid.verticalCenter

            height: 2
            color:Qt.rgba(61,61, 58,0.5)
        }
    }


    ListView{
        height: 100
        width: 6*60
        id: frontColorSec
        anchors.top:settingsep.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        anchors.topMargin: 20
        orientation: Qt.Horizontal
        model: 6
        spacing:10


        delegate: Rectangle {
            height: 50
            width: 50
            radius: frontColorSec.currentIndex === model.index ? 15 : 25
            color: colors[model.index]

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    globalstyle.mainFG = colors[model.index];
            }
        }
            NumberAnimation on radius {
                duration: 200

            }

    }


}
}
