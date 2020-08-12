import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0

ApplicationWindow {

    id:mainwindow
    visible: true
    width: screen.width
    height: screen.height
    visibility: "Maximized"
    title: qsTr("MusiQ")
    Material.theme: Material.Dark
    Material.background:  "#3d3d3a"

    onWidthChanged: {
        if (width > 1000){
            sap.state = "desktop_mode";
            allsong.state = "desktop_mode";
            controller.state = "desktop_mode";
        }
        else if (width <= 1000 && width >700 ){
            sap.state = "middle_mode";
            allsong.state ="middle_mode";
            controller.state ="middle_mode";
        }
        else{
            sap.state = "mobile_mode";
            allsong.state = "mobile_mode";
            controller.state = "mobile_mode";
        }
    }


    FontLoader{
        //        source: "qrc:/fonts/Font Awesome 5 Free-Regular-400.otf"
        source: "/fonts/Font Awesome 5 Free-Solid-900.otf"
        name :"solidfont"
        id:solidfont
    }

    FontLoader{
        //        source: "qrc:/fonts/Font Awesome 5 Free-Regular-400.otf"
        source: "qrc:/fonts/Antapani-ExtraBold.otf"
        name :"antapan"
        id:antapan
    }

    property bool isPlaying: true


    SettingAndPrefrences{
        id:sap
        //    Layout.alignment: Qt.AlignLeft
        anchors.left: parent.left
        //    Layout.fillHeight: true
        height: parent.height
        //    Layout.preferredWidth: parent.width > 700 ? 90 : 0
//        width: parent.width > 700 ? 90 : 0
        //    Layout.maximumWidth: 400

        state: "desktop_mode"

    }


    SystemTrayIcon{
        visible: true
        iconSource: "qrc:/new/prefix1/thumbnail.svg"
        tooltip: "MusiQ"


        menu: Menu {
            MenuItem {
                id:itemsd
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }



        onActivated: {
            if (reason == 4){
                menu.open()
            }
        }

        onMessageClicked: console.log("Message clicked")
        Component.onCompleted: showMessage("Message title", "Something important came up. Click this to know more.",iconSource)
    }


    Home{

        id:home
        visible: true
        anchors.left:sap.right
        Layout.fillWidth: true
        Layout.fillHeight: true
        //        x:10
        y:-90
    }
    Controller{
        id:controller
        anchors.top: home.bottom
        width: parent.width
        height: 90


    }

    Drawer{
        id:fullscreenDrawer
        FullScreenPlayer{id:fullscreenplayer}
        edge: Qt.BottomEdge
        width: parent.width
        height: parent.height
        modal: false
    }

    AllSong{
        //            width: parent.width -20
        //            height: parent.height -20
        id:allsong
        anchors.right: parent.right
//        width: parent.width > 500 ? parent.width/4 : parent.width
        height: parent.height - 130
        //            anchors.centerIn: parent
        Component.onCompleted: {
            onDuration: controller.durationToText()
            playBtnIconChanged.connect(controller.playPauseFromAllSong)

        }
    }

    Item {
        id: fillingitem
        height: parent.height-90
    }

    SplashScreen{
        anchors.fill:parent
    }

    //functions

    function toggleDrawer(){
        if (fullscreenDrawer.opened){
            fullscreenDrawer.exit();
        }
        else{
            fullscreenDrawer.open();
        }
    }

    //


    //    Monitor{
    //        id:monitor
    //        anchors.left:setting.right
    //        Layout.preferredWidth: 0
    //        Layout.fillHeight: true
    //        Material.background: "pink"
    //        padding: 5
    //    }
    //    Frame{
    //        padding: 2
    //        anchors.top: parent.top
    //        anchors.bottom: parent.bottom
    //        anchors.margins: 15
    //        ToolBar{
    //            id:toolb
    //            width: parent.width
    //            height: Math.max(parent.height/10,10)
    //            anchors.top: parent.top
    //            background: Rectangle{
    //                border.color:"transparent"
    //                radius: 10
    //                color: "#edbe6d"

    //            }


    //            RowLayout{
    //                height: toolb.height
    //                width: toolb.width
    //                anchors.verticalCenter: parent.verticalCenter

    //                ToolButton{
    //                    padding: 5
    //                    icon.source:"qrc:/icons8-collapse-96.png"

    //                    icon.width: toolb.height
    //                    Layout.fillHeight: true
    //                }

    //                Label{
    //                    Material.foreground: "white"
    //                    text: "setting"
    //                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    //                    font.pixelSize: toolb.width/10
    //                }
    //            }

    //        }
    //        Material.accent: "white"
    //        Material.elevation: 60
    //        Material.background: Material.DeepOrange
    //        background: Rectangle{
    //            border.color:"transparent"
    ////            color: "#00f5a7"
    //                gradient: Gradient{
    //                GradientStop{position: 0.0;color:"#00f5a7"}

    //                GradientStop{position: 1;color:"#dcf500"}
    //            }
    //            radius: 15
    //        }

    //        id:setting
    //        width: parent.width/4
    //        height: parent.height
    //        anchors.left: musiclist.right

    //        Dial{
    //            from:0
    //            to:1
    //            height: parent.height/2
    //            width: parent.width
    //            value: 0.5
    //            anchors.top: toolb.bottom
    //            onValueChanged: {
    //                monitor.vol = value
    //                volText.text = Math.round( value*100)
    //            }

    //        }
    //        Text {
    //            id: volText
    //            text: qsTr("50")
    //            font.pixelSize: setting.width/5
    //            width: implicitWidth
    //            height: implicitHeight
    //            color: "white"
    //            anchors.horizontalCenter: parent.horizontalCenter
    //            y:setting.height/4

    //        }
    //    }
    //    Player{
    //        id:player
    //        Layout.preferredWidth: parent.width/2
    //        Layout.fillHeight: true
    ////        anchors.right:parent.right
    ////        Layout.alignment: Qt.AlignRight
    ////        anchors.left: setting.right
    ////        anchors.top: parent.top
    ////        anchors.bottom: parent.bottom
    ////        anchors.margins: 15
    //    }
}
//}
