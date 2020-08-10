import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.3



Rectangle{
    property color btncolor: "#855dd4" //"#7f05e3"
    color: "#3d3d3a"
    width: parent.width
    height:parent.height

//    FontLoader{
//        source: "qrc:/fonts/Font Awesome 5 Free-Regular-400.otf"
//        id:brandfont
//    }




    TabBar{
        id:sandp
        anchors.verticalCenter: parent.verticalCenter
        height:6* home.height
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        Material.accent: "transparent"

        TabButton{
            id:home
            width: 100
            height: 100
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
                    pixelSize: parent.width/4
                }
                text: '\uf015'

            }
        }

        TabButton{
            id:favorite
            width: 100
            height: 100
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
                    pixelSize: parent.width/4
                }
                text: '\uf004'

            }
        }
        TabButton{
            id:artist
            width: 100
            height: 100
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
                    pixelSize: parent.width/4
                }
                text: '\uf007'

            }
        }
        TabButton{
            id:songs
            width: 100
            height: 100
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
                    pixelSize: parent.width/4
                }
                text: '\uf001'

            }
        }
        TabButton{
            id:recent
            width: 100
            height: 100
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
                    pixelSize: parent.width/4
                }
                text: '\uf017'

            }
        }
        Rectangle {
            z:2
            anchors.left: home.left
            anchors.top: recent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100; height: 100
            color: "purple";
            y: sandp.y
            Behavior on y {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
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


