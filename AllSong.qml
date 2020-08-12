import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    id:mainrect
    function nextSong(){
        songmodel.next()
        print("after calling next")
    }
    function preSong(){
        songmodel.previous()
    }
    function play(){
        songmodel.playIndex()
    }
    function pause(){
        songmodel.pause()
    }
    function getPath(){
        return listvi.model.path
    }
    function setSongPos(value){
        songmodel.m_setPosition(value)
    }
    function changePlaybackMode(value){
        songmodel.m_ChangePlaybackMode(value);
    }




    property color clickColor: "transparent"
    property int progress: songmodel.progress
    property int playlistindex: 0
    property string currentpath: ""
    property real endPosition: songmodel.duration
    property real passed: songmodel.passed

    signal duration()
    signal playBtnIconChanged()

    onEndPositionChanged:{
        print("i have changed")
        controller.durationToText();
    }

    onProgressChanged: {
    }

    width: parent.width
    height: parent.height
    radius: 10
    color:Qt.rgba(61,61, 58,0.05)
    //        anchors.bottom: controller.top
    anchors.verticalCenter: fillingitem.verticalCenter
    anchors.rightMargin: 20

    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {
                target: mainrect
                width : 400
            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {
                target: mainrect
                width : 400
            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {
                target: mainrect
                width : mainwindow.width
                anchors.rightMargin:0
                anchors.leftMargin: 20
                anchors.right: mainwindow.right
                anchors.left: mainwindow.left
            }
        }
    ]
    state:"dektop_mode"

    transitions:[
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation{
                targets:[mainrect]
                properties: "width";duration: 300
            }

        }



    ]














    Rectangle{
        id:labelrect
        width: parent.width
        height: 45
        color: "transparent"
        Label{
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            id:sectionlabel
            text: "All Songs "
            anchors.top:parent.top
            font.bold: true
        }

    }
    Component {
        id: highlight

        Rectangle {
            width: listvi.width; height: 90
            color: "#3d3d3a"; radius: 5
            y: listvi.currentItem.y
            Behavior on y {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }
    ListView{
        id:listvi
        width:parent.width -20
        height: parent.height -45
        anchors.top: labelrect.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        model: Songfinder{id:songmodel}
        clip: true
        boundsBehavior: Flickable.FollowBoundsBehavior
        snapMode: ListView.SnapToItem
        header: labelrect
        spacing:10
        highlight: highlight
        highlightFollowsCurrentItem: false
        delegate: Rectangle{
            height: 90
            width: parent.width
            radius: 10
            color: model.selected ? "#3d3d3a" : "transparent"
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {

                    if (mainwindow.isPlaying === true){
                        playBtnIconChanged()
                    }

                    listvi.currentIndex = model.index
                    playlistindex = model.index
                    currentpath = model.path
                    endPosition = model.duration
                    songmodel.play(model.path,model.index);
                    mainrect.duration()
                    print("AFTER CHECKING PLAYER")
                    isPlaying : true
                }

            }

            Row{
                spacing: 10
                width: parent.width
                height: parent.height

                Image {
                    id:rowimage
                    height: parent.height -10
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    asynchronous: true

                }

                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.name.toString().split(".mp3")[0]
                    font{
                        family: antapan.name
                    }
                    color: "white"
                }
            }
        }

    }
}
