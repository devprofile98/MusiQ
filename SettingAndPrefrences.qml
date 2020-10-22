import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.3

import roundedrect 1.0


Rectangle{
//    property color btncolor: globalstyle.mainFG //"#7f05e3"

    property color mainFront: globalstyle.mainFG
    property color mainBack: globalstyle.mainBG
    property color mainItem: globalstyle.itemBG

    property int btnsize: 100
    property int iconsize: width/4
    property int listCurrentIndex: 0

    onListCurrentIndexChanged: {
        if (listCurrentIndex!==-1){

            settinglbl.color="white"
            highlite.visible = true
        }
        else{
            settinglbl.color = globalstyle.mainFG;
            highlite.visible = false;
        }
    }


    function settingbtncolor(){
        settinglbl.color = globalstyle.mainFG;
    }






    id:root
    color: mainItem
    width: parent.width
    height:parent.height

    states: [
        State{
            name:"desktop_mode"
            PropertyChanges {
                target: root
                width:90
                btnsize:100
                iconsize: root.width/4

            }
            PropertyChanges {
                target: highlite
                width:8

            }
        },
        State{
            name:"mobile_mode"
            PropertyChanges {
                target: root
                width:50
                btnsize:50
                iconsize: 20
            }
            PropertyChanges {
                target: highlite
                width:6

            }
        },
        State{
            name:"middle_mode"
            PropertyChanges {
                target: root
                width:90
                btnsize:100
                iconsize: root.width/4
            }
            PropertyChanges {
                target: highlite
                width:8

            }
        }

    ]

    transitions:[
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation{
                targets:[root]
                properties: "width";duration: 300
            }

        }
    ]
    Rectangle{
//        property int inseq: 0
        id:settingbtn
        width: btnsize; height: btnsize
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        Label{
            id:settinglbl
            anchors.centerIn: parent
            font.family: solidfont.name
            text: "\uf013"
            font.pixelSize: iconsize
        }
        MouseArea{
            anchors.fill: parent

            onClicked: {


                mainstackview.replace(settingpage);
                listCurrentIndex= -1;
                highlite.y= home.inseq*root.btnsize +root.btnsize/4
            }

        }
    }

    Rectangle{
        anchors{
            top:settingbtn.bottom
            topMargin: 5
            horizontalCenter: root.horizontalCenter

        }

        width:btnsize*(3/4)
        height: 1
        color: Qt.rgba(61, 61, 58,0.1)
    }

    TabBar{
        id:sandp
        anchors.verticalCenter: parent.verticalCenter
        height:5* home.height
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        Material.accent: "transparent"

        TabButton{
            id:home
            property int inseq: 0
            property real indicatory: y + height/4
            width: btnsize
            height: btnsize
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }

            Label{
                id:homelabel
                anchors.centerIn: parent
                font{
                    family: solidfont.name
                    bold  :true
                    pixelSize: iconsize
                }
                text: '\uf015'

            }

            RoundedRect {
                id:highlite
                z:2
                anchors.left: parent.left
                width: 8; height: parent.height/2

                toprightRadius: 8
                bottomrightRadius: 8

                color: globalstyle.mainFG;
                clip: true
                y: home.height/4
                Behavior on y {
                    SpringAnimation {
                        spring: 4
                        damping: 0.3

                    }
                }

            }

            onClicked: {
                highlite.visible = true
                highlite.y= inseq*root.btnsize +root.btnsize/4
                listCurrentIndex=0;
                if (mainstackview.currentItem !== homepage){
                    mainstackview.replace(homepage)
                }



            }
        }

        TabButton{
            id:favorite
            property int inseq: 1
            width: btnsize
            height: btnsize
            anchors{
                top:home.bottom
                left: parent.left
                horizontalCenter: parent.horizontalCenter
            }
            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }

            Label{
                id:favoritelabel
                anchors.centerIn: parent
                font{
                    family: solidfont.name
                    //                bold  :true
                    pixelSize: iconsize
                }
                text: '\uf004'

            }
            onClicked: {
                highlite.y= inseq*root.btnsize +root.btnsize/4
                listCurrentIndex=1;

            }
        }
        TabButton{
            id:artist
            property int inseq:2
            width: btnsize
            height: btnsize
            anchors{
                top:favorite.bottom
                left: parent.left
                horizontalCenter: parent.horizontalCenter
            }
            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }

            Label{
                id:artistlabel
                anchors.centerIn: parent
                font{
                    family: solidfont.name
                    bold  :true
                    pixelSize: iconsize
                }
                text: '\uf007'

            }
            onClicked: {
                highlite.y= inseq*root.btnsize +root.btnsize/4
                listCurrentIndex=2;

            }
        }
        TabButton{
            id:songs
            property int inseq: 3
            width: btnsize
            height: btnsize
            anchors{
                top:artist.bottom
                left: parent.left
                horizontalCenter: parent.horizontalCenter
            }

            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }
            Label{
                id:songslabel
                anchors.centerIn: parent
                font{
                    family: solidfont.name
                    bold  :true
                    pixelSize: iconsize
                }
                text: '\uf001'

            }

            onClicked: {
                highlite.y= inseq*root.btnsize +root.btnsize/4
                listCurrentIndex=3;

            }
        }
        TabButton{
            id:recent
            property int inseq: 4
            width: btnsize
            height: btnsize
            anchors{
                top:songs.bottom
                left: parent.left
                horizontalCenter: parent.horizontalCenter
            }

            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }
            Label{
                id:recentlylabel
                anchors.centerIn: parent
                font{
                    family: solidfont.name
                    pixelSize: iconsize
                }
                text: '\uf017'

            }

            onClicked: {
                highlite.y= inseq*root.btnsize +root.btnsize/4
                listCurrentIndex=4;
                mainstackview.replace(timing)
            }
        }
    }
    Component.onCompleted: {
        state:"desktop_mode"

    }
}

