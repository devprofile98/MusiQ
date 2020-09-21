import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.3



Rectangle{
    property color btncolor: "#855dd4" //"#7f05e3"
    property int btnsize: 100
    property int iconsize: width/4
    id:root
    color: "#3d3d3a"
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

            Rectangle {
                id:highlite
                z:2
                anchors.left: parent.left
                width: 8; height: parent.height/2

                color: btncolor;
                y: home.height/4
                Behavior on y {
                    SpringAnimation {
                        spring: 4
                        damping: 0.3

                    }
                }
            }

            onClicked: {
                highlite.y= inseq*root.btnsize +root.btnsize/4

                if (mainstackview.currentItem != homepage){
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
//                highlite.y= inseq*100 + home.height/4
                highlite.y= inseq*root.btnsize +root.btnsize/4


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
//                highlite.y= inseq*100 + home.height/4
                highlite.y= inseq*root.btnsize +root.btnsize/4

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
//                highlite.y= inseq*100 + home.height/4
                highlite.y= inseq*root.btnsize +root.btnsize/4

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
                    //                    bold  :true
                    pixelSize: iconsize
                }
                text: '\uf017'

            }

            onClicked: {
//                highlite.y= inseq*100 + home.height/4
                highlite.y= inseq*root.btnsize +root.btnsize/4

                mainstackview.replace(timing)
            }
        }
    }
    Component.onCompleted: {
        state:"desktop_mode"

    }



//    Column{
//        width: parent.width
//        anchors.topMargin: 20
//        anchors.leftMargin: 20
//        anchors.verticalCenter: parent.verticalCenter

//        Rectangle{
//            width: parent.width
//            height: width
//            color:"transparent"

//            Label{
//                id:homelabel
//                anchors.centerIn: parent
//                font{
//                    family: solidfont.name
//                    bold  :true
//                    pixelSize: parent.width/4
//                }
//                text: '\uf015'

//            }
//            ToolTip{
//                id:hometip
//                delay: 1000
//                text: "home"
//                parent: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true
//                onEntered: {
//                    homelabel.color = btncolor
////                    hometip.visible = true

//                }
//                onExited: {
//                    homelabel.color = 'white'
//                    hometip.visible = false

//                }

//            }
//        }


//        Rectangle{
//            id:favoritebtn
//            color:"transparent"
//            width: parent.width
//            height: width
//            //            anchors.topMargin: 20
//            Label{
//                id:favoritelabel
//                anchors.centerIn: parent
//                font{
//                    family: solidfont.name
//                    //                bold  :true
//                    pixelSize: parent.width/4
//                }
//                text: '\uf004'

//            }
//            ToolTip{
//                id:liketip
//                delay: 1000
//                text: "home"
//                parent: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true
//                onEntered: {
//                    favoritelabel.color = btncolor
//                    favoritelabel.font.bold = true
////                    liketip.visible = true

//                }
//                onExited: {
//                    favoritelabel.font.bold = false
//                    favoritelabel.color = 'white'
//                    liketip.visible = false

//                }

//            }
//        }

//        Rectangle{
//            width: parent.width
//            height: width
//            color:"transparent"
//            Label{
//                id:artistlabel
//                anchors.centerIn: parent
//                font{
//                    family: solidfont.name
//                    bold  :true
//                    pixelSize: parent.width/4
//                }
//                text: '\uf007'

//            }
//            ToolTip{
//                id:artisttip
//                delay: 1000
//                text: "home"
//                parent: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true
//                onEntered: {
//                    artistlabel.color = btncolor
////                    artisttip.visible = true

//                }
//                onExited: {
//                    artistlabel.color = 'white'
//                    artisttip.visible = false

//                }

//            }
//        }


//        Rectangle{
//            width: parent.width
//            height: width
//            color:"transparent"
//            Label{
//                id:songslabel
//                anchors.centerIn: parent
//                font{
//                    family: solidfont.name
//                    bold  :true
//                    pixelSize: parent.width/4
//                }
//                text: '\uf001'

//            }
//            ToolTip{
//                id:songstip
//                delay: 1000
//                text: "home"
//                parent: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true
//                onEntered: {
//                    songslabel.color = btncolor
////                    songstip.visible = true

//                }
//                onExited: {
//                    songslabel.color = 'white'
//                    songstip.visible = false

//                }

//            }
//        }
//        Rectangle{

//            width: parent.width
//            height: width
//            color:"transparent"
//            Label{
//                id:recentlylabel
//                anchors.centerIn: parent
//                font{
//                    family: solidfont.name
//                    //                    bold  :true
//                    pixelSize: parent.width/4
//                }
//                text: '\uf017'

//            }
//            ToolTip{
//                id:recentlytip
//                delay: 1000
//                text: "home"
//                parent: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true
//                onEntered: {
//                    recentlylabel.color = btncolor
////                    recentlytip.visible = true

//                }
//                onExited: {
//                    recentlylabel.color = 'white'
//                    recentlytip.visible = false

//                }

//            }
//        }
//    }

}


