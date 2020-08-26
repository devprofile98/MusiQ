import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    id:mainrect
    function nextSong(){
        songmodel.next()
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
    property int playlistindex: listvi.currentIndex
    property string currentpath: ""
    property real endPosition: songmodel.duration
    property real passed: songmodel.passed


    signal duration()
    signal playBtnIconChanged()

    onEndPositionChanged:{
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
    anchors.leftMargin: 20
    anchors.right: parent.right

    states:[
        State {
            name: "desktop_mode"
            AnchorChanges {
                target: mainrect
                //                anchors.right: parent.right
                anchors.left: undefined
            }
            PropertyChanges {
                target: mainrect
                width : 400
            }

        },
        State {
            name: "middle_mode"
            AnchorChanges {
                target: mainrect
                //                anchors.right: parent.right
                anchors.left: undefined
            }
            PropertyChanges {
                target: mainrect
                width : 400
                anchors.leftMargin: 20

            }

        },
        State {
            name: "mobile_mode"
            AnchorChanges {
                target: mainrect
                //                anchors.right: parent.right
                anchors.left: parent.left
            }
            PropertyChanges {
                target: mainrect
                anchors.leftMargin: 20


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
            width: listvi.width; height: 70
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
        width:parent.width - 40
        height: parent.height - 45
        anchors.top: labelrect.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        model: Songfinder{
            id:songmodel
            onSongchanged: {
                listvi.currentIndex = index;
            }
        }
        clip: true
        boundsBehavior: Flickable.FollowBoundsBehavior
        snapMode: ListView.SnapToItem
        header: labelrect
        spacing:10

        highlight: highlight
        highlightFollowsCurrentItem: false
        delegate: Rectangle{
            height: 70
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
                    DataModel.extractSongInfo(model.index);
                    listvi.currentIndex = model.index
                    playlistindex = model.index
                    currentpath = model.path
                    endPosition = model.duration
                    songmodel.play(model.path,model.index);
                    mainrect.duration()
                    isPlaying : true
                }

            }

            Row{
                spacing: 10
                width: parent.width
                height: parent.height
                leftPadding: 10

                property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]

                Rectangle{
                    height: parent.height -10
                    width: height
                    anchors.verticalCenter: parent.verticalCenter

                    color: parent.colors[Math.floor(Math.random()*6)]
                    radius: 5
                    Image {
                        id:rowimage
                        height: parent.height
                        width: parent.width
                        anchors.fill: parent
                        anchors.centerIn: parent
                        source: "image://imageprovider/" + model.index
                        asynchronous: true
                        smooth: true

                        layer.enabled: true
                        layer.effect: OpacityMask{

                            maskSource: mask
                        }

                    }

                    Rectangle{
                        visible: false
                        id:mask
                        width: rowimage.width
                        height: rowimage.height
                        radius: 5

                    }


                    MouseArea{
                        anchors.fill: parent
                    }
                }
                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: rowimage.right
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
