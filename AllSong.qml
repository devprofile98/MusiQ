import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    //        anchors.top: parent.top
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

    onProgressChanged: {
        console.log("\n\n\n +++++++++\n\n\n\n")
    }

    width: parent.width
    height: parent.height
    radius: 10
    color:Qt.rgba(61,61, 58,0.05)
    //        anchors.bottom: controller.top
    anchors.verticalCenter: fillingitem.verticalCenter
    anchors.rightMargin: 20
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
        MouseArea{
            anchors.fill: parent
            onClicked: {
//                songmodel.next();
                songmodel.setProgress(3);

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
        spacing:10
        delegate: Rectangle{
            height: 90
            width: parent.width
            //        anchors.bottomMargin: 10
            radius: 10
            color: model.selected ? "#3d3d3a" : "transparent"
//            color: model.duration
            MouseArea{
                property color btnColor: "transparent"
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {

//                    rowimage.source ="image://live/image?id="+model.path
                    controller.changeThumbnail("image://live/image?id="+model.path)
//                    fullscreenplayer.setImages("image://live/image?id="+model.path)
                    clickColor = "#3d3d3a"
//                    parent.color = clickColor
                    model.selected = true;
                    playlistindex = model.index
                    currentpath = model.path
                    endPosition = model.duration
                    print(model.index , model.path)
                    songmodel.play(model.path,model.index);
                    print("AFTER CHECKING PLAYER")
                    isPlaying : true
                }
                onEntered: {
//                    console.log(model.selected)
                    if (!model.selected){
                    parent.color = "#3d3d3a"
                    }
                }
                onExited: {
                    parent.color = model.selected ? "#3d3d3a" : "transparent"
                    clickColor = clickColor


                }

            }

            Row{
                spacing: 10
                //                anchors.fill: parent
                width: parent.width
                height: parent.height

                Image {
                    id:rowimage
//                    source: "/../Pictures/sign/Crazy Big Gun - Overdose.jpg"
                    source: "image://live/image?id="+model.path
//                    source: model.pic_url
                    onSourceChanged: {
                        console.log(model.pic_url+"sdfsdfsdfsfsdf")
                        rowimage.source = model.pic_url

                    }


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
//                        bold:true
                    }
                    color: "white"
                }


            }
        }

    }

}
