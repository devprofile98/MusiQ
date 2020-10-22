import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import QtQuick.Layouts 1.3

Rectangle{
    id:mainrect

    function nextSong(){
        if (mainwindow.isPlaying === true){
            playBtnIconChanged()
        }
        songmodel.next()

    }
    function preSong(){
        if (mainwindow.isPlaying === true){
            playBtnIconChanged()
        }
        songmodel.previous()

    }
    function play(){
        songmodel.playIndex()
    }
    function pause(){
//        mainwindow.isPlaying = !mainwindow.isPlaying
//        playBtnIconChanged();
        songmodel.pause()
    }
    function getPath(){
        return listvi.model.path
    }
    function setSongPos(value){
        songmodel.m_setPosition(value)
    }
    function changePlaybackMode(mode){
        songmodel.m_ChangePlaybackMode(mode);
    }


    property color clickColor: "transparent"
    property int progress: songmodel.progress
    property int playlistindex: listvi.currentIndex
    property string currentpath: ""
    property real endPosition: songmodel.duration
    property real passed: songmodel.passed
    property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]

    property color mainFront: globalstyle.mainFG
    property color mainBack: globalstyle.mainBG
    property color mainItem: globalstyle.itemBG


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
    color: mainItem //Qt.rgba(61,61, 58,0.05)
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
                anchors.right: controller.right
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
                anchors.right: controller.right
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
//                anchors.left: parent.left
                anchors.left: sap.right
                anchors.right:mainwindow.right
                anchors.top:sap.top


            }
            PropertyChanges {
                target: mainrect
                visible:sap.listCurrentIndex === 0;


                anchors.leftMargin: 15
                anchors.topMargin: 0
                anchors.bottomMargin: 15
                anchors.rightMargin: 15

            }

            PropertyChanges {
                target:mainrect
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
                    spring: 4
                    damping: 0.3
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
                playlistindex = index
                DataModel.extractSongInfo(index)
            }

            onDurationChanged: {
                endPosition = value;
                controller.durationToText();
            }
            onPlaybackmodeChanged: {
                controller.playbackmode = playbackmode;
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
            width: listvi.width
            radius: 10
            color:  "transparent" //model.selected ? "#3d3d3a" :
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {}
            }

            RowLayout{
                spacing: 10
                width: parent.width
                height: parent.height

//                property var colors: ["#EF9A9A","#F48FB1","#9FA8DA","#B39DDB","#FFAB91","#80CBC4"]

                Rectangle{
                    id:thumbrect
                    //                    height: parent.height -10
                    Layout.preferredHeight: parent.height -10
                    Layout.preferredWidth: height
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 5
                    //                    anchors.verticalCenter: parent.verticalCenter
//                    color: parent.colors[Math.floor(Math.random()*6)]
                    radius: 5

                    Image {
                        id:rowimage
                        height: parent.height
                        width: parent.width
                        anchors.fill: parent
                        anchors.centerIn: parent
                        source: "image://imageprovider/" + model.index
                        sourceSize: {
                            width:rowimage.width
                            height:rowimage.height
                        }

                        asynchronous: true
                        smooth: true
                        layer.enabled: true
                        layer.effect: OpacityMask{
                            maskSource: mask
                        }
                        onStatusChanged: {
                            if(rowimage.status === Image.Ready ){
                                thumbrect.color="transparent"
                            }
                            else{
                                thumbrect.color = mainrect.colors[Math.floor(Math.random()*6)]
                            }
                        }

                    }

                    Rectangle{
                        visible: false
                        id:mask
                        width: rowimage.width
                        height: rowimage.height
                        radius: 5

                    }

                }

                Label{
                    Layout.fillWidth: implicitWidth
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                    text: model.name.toString().split(".mp3")[0]
                    font{
                        family: ubold.name
                        bold:true
                    }
                    color: "white"
                }

                MouseArea{
                    anchors.fill: parent


                    onClicked: {
                        if (mainwindow.isPlaying === true){
                            playBtnIconChanged()
                        }
                        playlistindex = model.index
                        currentpath = model.path
                        endPosition = model.duration
                        songmodel.play(model.path,model.index);
                        mainrect.duration()

//                        isPlaying : true
                    }
                }
            }
        }
    }
}
