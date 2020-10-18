import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Rectangle{
    id:mainrect

    property var colors: ["#855dd4","#f7af6f","#f76fd3","#5ae089","#FFAB91","#80CBC4"]

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
            target: settingsep
            width: parent.width - 100
            }
            PropertyChanges {
            target: timersep
            width: parent.width - 100
            }
            AnchorChanges{

            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {
                target: settingsep
                width: mainrect.width - 100
            }
            PropertyChanges {
            target: timersep
            width: parent.width - 100
            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {

                target: settingsep
                width: mainrect.width - 20
            }
            PropertyChanges {
            target: timersep
            width: parent.width - 20
            }


        }

    ]

    state: "desktop_mode"


    Row{
        id:timersep
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: mainrect.top
        anchors.topMargin: 20
        width: parent.width - 100
        spacing: 20

        Label{
            id:timerlbl
            text: "Stop In"
            font{
                bold: true
            }
            color:Qt.rgba(61,61, 58,0.4)
            width: implicitWidth
        }

        Rectangle{

            width: timersep.width - timerlbl.width
            anchors.verticalCenter: timerlbl.verticalCenter
            height: 2
            color:Qt.rgba(61,61, 58,0.5)
        }
    }


    RowLayout{
        id:killersec
        width: implicitWidth
        height: implicitHeight
        anchors.top: timersep.bottom
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
            color:Qt.rgba(61,61, 58,0.4)
            width: implicitWidth
        }

        Rectangle{

            width: settingsep.width - lblid.width
            anchors.verticalCenter: lblid.verticalCenter
            anchors.right: mainrect.right
            anchors.rightMargin: 10
            height: 2
            color:Qt.rgba(61,61, 58,0.5)
        }
    }


    ListView{
        height: 100
        width: parent.width // 6*60
        id: frontColorSec

        anchors{
            top:settingsep.bottom
            horizontalCenter: parent.horizontalCenter
            left: parent.left
            right: parent.right
            margins: 10
            topMargin: 20
        }

        orientation: Qt.Horizontal
        model: 6
        spacing:10


        delegate: Rectangle {
            height: 50
            width: 50
            border{
                color: Qt.rgba(255, 255, 255,0.5)
                width: 1

            }

            radius: frontColorSec.currentIndex === model.index ? 15 : 25
            color: colors[model.index]

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    frontColorSec.currentIndex = model.index;
                    globalstyle.mainFG = colors[model.index];
                    sap.settingbtncolor();
            }
        }
            NumberAnimation on radius {
                duration: 600
            }

    }


}
}
