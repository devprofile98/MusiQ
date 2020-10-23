import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0



ApplicationWindow {

    id:mainwindow
    visible: true
    width: screen.width
    height: screen.height
    visibility: "Maximized"
    title: qsTr("MusiQ")
    Material.theme: Material.Dark
    Material.background:globalstyle.itemBG
//    flags:  Qt.FramelessWindowHint
//    flags: /*Qt.FramelessWindowHint |*/
////           Qt.WindowMinimizeButtonHint |
//           Qt.Window


    onWidthChanged: {
        if (width > 1000){
            sap.state = "desktop_mode";
            allsong.state = "desktop_mode";
            controller.state = "desktop_mode";
            fullscreenplayer.state="desktop_mode";
            mainstackview.state="desktop_mode";
            settingpage.state = "desktop_mode";
            timing.state = "desktop_mode";
        }
        else if (width <= 1000 && width >700 ){
            sap.state = "middle_mode";
            allsong.state ="middle_mode";
            controller.state ="middle_mode";
            fullscreenplayer.state="middle_mode"
            mainstackview.state = "middle_mode";
            settingpage.state = "middle_mode";
            timing.state = "middle_mode";
        }
        else{
            sap.state = "mobile_mode";
            allsong.state = "mobile_mode";
            controller.state = "mobile_mode";
            fullscreenplayer.state="mobile_mode"
            mainstackview.state = "mobile_mode";
            settingpage.state = "mobile_mode";
            timing.state = "mobile_mode";

            closebtn.visible = false;
            closebtn.width=0;
            minimizebtn.visible = false;
            minimizebtn.width=0;
        }
    }


    FontLoader{
        source: "/fonts/Font Awesome 5 Free-Solid-900.otf"
        name :"solidfont"
        id:solidfont
    }

    FontLoader{
        source: "qrc:/fonts/Antapani-ExtraBold.otf"
        name :"antapan"
        id:antapan
    }
    FontLoader{
        source: "qrc:/fonts/Ubuntu-Bold.ttf"
        name :"ubold"
        id:ubold
    }


    Styles{
        id:globalstyle
    }


    property bool isPlaying: false

    Rectangle{
        id:closebtn
        width: 20
        height: width
        color:"#242323"
//        anchors.right: parent.right
        anchors.top: parent.top
        anchors.right: allsong.right

        z:10
        radius: 3
        anchors.margins: 5

        Label{
            text:"X"
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 15
            color: globalstyle.mainFG
        }

        MouseArea{
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }
    Rectangle{
        id:minimizebtn
        width: 20
        height: width
        color:"#242323"
//        anchors.right: parent.right
        anchors.top: parent.top
        anchors.right: closebtn.left

        z:10
        radius: 3
        anchors.margins: 5

        Label{
            text:"-"
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 18
            color: globalstyle.mainFG
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {mainwindow.width = 500;mainwindow.height=500}

        }
    }

    SettingAndPrefrences{
        id:sap
        anchors.left: parent.left
        height: parent.height
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
            MenuItem {
                id:secondmenu
                text: qsTr("play")
                onTriggered: Qt.quit()
            }
        }



        onActivated: {
            if (reason === 4){
                menu.open()
            }
        }

        onMessageClicked: console.log()
        Component.onCompleted: showMessage("Message title", "Something important came up. Click this to know more.",iconSource)
    }


    Home{
        id:home
        visible: true
        anchors.left:sap.right
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

    StackView{
        id:mainstackview
        anchors.right: allsong.left
        anchors.left: sap.right
        anchors.bottom: controller.top
        anchors.top: allsong.top
        anchors.margins: 15
        anchors.topMargin: 0
        visible: true

        states:[
            State {
                name: "desktop_mode"
                PropertyChanges {
                    target: mainstackview
//                    anchors.topMargin: 5
                    anchors.rightMargin: 20
                }
                AnchorChanges{
                    target: mainstackview
                    anchors.right: allsong.left
                    anchors.top: allsong.top
                }
            },
            State {
                name: "middle_mode"
                PropertyChanges {
                    target: mainstackview
//                    anchors.topMargin: 5
                    anchors.rightMargin: 20
                }
                AnchorChanges{
                    target: mainstackview
                    anchors.right: allsong.left
                    anchors.top: allsong.top

                }
            },
            State {
                name: "mobile_mode"
                PropertyChanges {
                    target: mainstackview
                    visible:sap.listCurrentIndex !== 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                }
                AnchorChanges{
                    target: mainstackview
                    anchors.right: controller.right
                    anchors.top: sap.top

                }
            }

        ]

        state:"desktop_mode"

        initialItem: homepage
        pushEnter: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 0
                     to:1
                     duration: 2000
                 }
             }
             pushExit: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 1
                     to:0
                     duration: 2000
                 }
             }

             popEnter: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 0
                     to:1
                     duration: 2000
                 }
             }

             popExit: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 1
                     to:0
                     duration: 2000
                 }
             }

             replaceEnter: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 0
                     to:1
                     duration: 200
                 }
             }

             replaceExit: Transition {
                 PropertyAnimation {
                     property: "opacity"
                     from: 1
                     to:0
                     duration: 200
                 }
             }
    }

    TimingPage{
        id:timing
        visible: false
    }

    HomePage{
        id:homepage
    }
    SettingPage{
        id:settingpage
    }

    AllSong{
        id:allsong
        anchors.right: parent.right
        anchors.top: closebtn.bottom
        anchors.bottom: controller.top
        height: parent.height - 130
        anchors.margins: 20
        anchors.topMargin: 5

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

    function toggleDrawer(){
        if (fullscreenDrawer.opened){
            fullscreenDrawer.exit();
        }
        else{
            fullscreenDrawer.open();
        }
    }
}

