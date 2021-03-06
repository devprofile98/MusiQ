import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.3

Rectangle{


    function changeThumbnail(path){
        thumbnail.source = ""
        thumbnail.source = path
    }

    function durationToText(){
        var insecond =Math.floor((allsong.endPosition/1000))
        var second = (insecond % 60)
        var minute = ((insecond - second) / 60)

        var finalSecond = 0
        var finalMinute = 0
        if (second <10){
            finalSecond = "0" + second
        }
        else{
            finalSecond =  second
        }
        if (minute <10){
            finalMinute = "0" + minute
        }
        else{
            finalMinute =  minute
        }
        return finalMinute.toString() + ":" +finalSecond.toString()
    }


    function passedToText(){
        var insecond =Math.floor((allsong.passed/1000))
        var second = (insecond % 60)
        var minute = ((insecond - second) / 60)

        var finalSecond = 0
        var finalMinute = 0
        if (second <10){
            finalSecond = "0" + second
        }
        else{
            finalSecond =  second
        }

        if (minute <10){
            finalMinute = "0" + minute
        }
        else{
            finalMinute =  minute
        }

        return finalMinute.toString() + ":" +finalSecond.toString()
    }


    function changeOnPlayBtnPressed(play){
        if (play){

            allsong.pause()
            ppbtn.text = "\uf144"
        }
        else{
            allsong.play(allsong.currentpath,allsong.playlistindex)
            ppbtn.text = "\uf28b"
        }
        mainwindow.isPlaying =!mainwindow.isPlaying

    }
    function playPauseFromAllSong(){

        ppbtn.text = "\uf28b"
        mainwindow.isPlaying =!mainwindow.isPlaying
    }

    function openAddPopup(){
        addplaylistloader.active = true;
        addplaylistloader.item.open();
    }

    property real allsongend: allsong.endPosition
    onAllsongendChanged: {
        anim.stop();
        anim.duration = allsongend;
        console.log("the allsong end position is :", allsongend)
        durationcanvas.clear();
        anim.start();
    }

    property color btncolor: "#855dd4" //#7f05e3
    property string endPosition: "00:00"
    property int playbackmode: 0
    signal playBtnPressed(bool play);

    onPlaybackmodeChanged: {
        if (playbackmode === 4){
            shufflebtn.state = "shuffle_on"
        }
        else{
            shufflebtn.state = "shuffle_off"
        }
    }

    property color mainFront:globalstyle.mainFG
    property color mainBack:globalstyle.mainBG
    property color mainItem: globalstyle.itemBG


    onMainFrontChanged: {
        durationcanvas.clear();
        durationcanvas.requestPaint();
    }

    width:parent.width
    height:parent.height
    color: mainItem

    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {
                target: pbarlayout
                anchors.leftMargin: 200
            }
            PropertyChanges {
                target: thumbnailpic
                visible:true
            }
            PropertyChanges {
                target: durationcanvas
                visible:false
            }

        },
        State {
            name: "middle_mode"
            PropertyChanges {
                target: pbarlayout
                anchors.leftMargin: 30
                width:0
                visible:false
            }
            PropertyChanges {
                target: thumbnailpic
                visible:true

            }
            PropertyChanges {
                target: durationcanvas
                visible:false
            }

        },
        State {
            name: "mobile_mode"
            PropertyChanges {
                target: pbarlayout
                anchors.leftMargin: 30
                width:0
                Layout.preferredWidth: 0
                visible:false

            }
            PropertyChanges {
                target: thumbnailpic
                visible:false
                width:0

            }
            PropertyChanges {
                target: thumbnailinfo
                visible:false
                width:0

            }
            PropertyChanges {
                target: durationcanvas
                visible:true
            }

        }
    ]

    state:"desktop_mode"


    RowLayout{
        width:parent.width
        height:parent.height
        //       spacing: -100
        Rectangle{
            id:thumbnailpic

            MouseArea{
                anchors.fill: parent
                onEntered: {
                    //                    pa.start()
                }
            }

            Layout.preferredHeight: parent.height -20
            Layout.leftMargin: 10
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignVCenter
            color:"#d3aaf2"
            clip: true

            radius: 10

            Image {
                width: parent.width
                height: parent.height
                //                GaussianBlur:10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.width: 100
                sourceSize.height: 100
                id: thumbnail
                source: "image://imageprovider/"+allsong.playlistindex
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                smooth: true
                layer.enabled: true
                layer.effect: OpacityMask{
                    maskSource: mask
                }

            }

            Rectangle{
                id:mask
                width: thumbnail.width
                height: thumbnail.height
                radius: 10
                visible: false
            }


            visible: true
        }

        Item {
            id: thumbnailinfo
            Layout.preferredWidth: implicitHeight
            Layout.preferredHeight: parent.height
            Layout.rightMargin: 170

            Column{
                width: parent.width
                spacing: 10
                rightPadding: 20
                anchors.verticalCenter: parent.verticalCenter
                Label{


                    id:singerinfo
                    text:DataModel.songerName

                    wrapMode: Label.WordWrap
                    font{
                        bold:true
                        pixelSize: 12
                        family: ubold.name
                    }

                }

                Label{
                    id:songname

                    font{
                        bold:true
                        pixelSize: 12
                        family: ubold.name

                    }

                    anchors{
                        top: thumbnailinfo.bottom

                    }

                    text:DataModel.songTitle
                }

            }
        }

        //         controler panel
        Rectangle{
            id:controlpanel
            color: "transparent"
            Layout.fillHeight: true
            Layout.preferredWidth: height*3
            Layout.leftMargin: 0 //height


            Row{
                anchors.fill: parent
                // previous song button
                Label{
                    id:prev
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            allsong.preSong()
                        }
                    }
                    anchors.right: ppbtn.left
                    anchors.rightMargin: parent.height/4
                    anchors.verticalCenter: parent.verticalCenter
                    text:"\uf048"

                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/4
                    }
                }

                //play and pause button
                Label{
                    id:ppbtn
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{

                            playBtnPressed(!isPlaying)

                        }
                    }
                    anchors.centerIn: parent
                    text:"\uf28b"
                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/2
                    }

                }


                // next song button
                Label{
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            allsong.nextSong()
                        }
                    }

                    id:nextbtn
                    anchors.left:ppbtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf051"

                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/4
                    }
                }

                //repeat button
                Label{
                    id:rptbtn
                    anchors.left:nextbtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf2f9"

                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/5
                    }

                    MouseArea{

                        anchors.fill: parent
                        onClicked: {
                            allsong.changePlaybackMode();
                        }
                    }

                }

                //shuffle button
                Label{
                    id:shufflebtn
                    anchors.left:rptbtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf074"

                    font{

                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/5
                    }
                    MouseArea{

                        anchors.fill: parent
                        onClicked: {
                            if (playbackmode===4){
                                allsong.changePlaybackMode();
                            }
                            else{
                                allsong.changePlaybackMode(4);
                            }
                        }
                    }

                    state: "shuffle_off"

                    states: [

                        State {
                            name: "shuffle_on"
                            PropertyChanges {
                                target: shufflebtn
                                color:mainFront

                            }
                        },
                        State {
                            name: "shuffle_off"

                            PropertyChanges {
                                target: shufflebtn
                                color:"white"
                            }
                            PropertyChanges {
                                target: shufflebtn.font
                                pixelSize:parent.height/5 +100

                            }
                        }

                    ]

                    transitions: [
                        Transition {
                            from: "shuffle_off"
                            to: "shuffle_on"

                            ParallelAnimation{
                                ColorAnimation {
                                    from: "white"
                                    to: mainFront
                                    duration: 100
                                }
                                PropertyAnimation{
                                    target: shufflebtn.font
                                    properties: "pixelSize"
                                    easing.type: Easing.InOutQuad
                                }
                            }


                        },
                        Transition {
                            from: "shuffle_on"
                            to: "shuffle_off"

                            ColorAnimation {
                                to: "white"
                                duration: 100
                            }

                        }
                    ]


                }

                //add to favorite
                Button{
                    id:likebtn
                    anchors.left:shufflebtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf004"
                    background:Rectangle {
                        color: "transparent";
                    }

                    onClicked: {
                        console.log(allsong.currentpath)
                        DBManager.likeAsong(allsong.currentpath);
                    }

                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/5
                    }
                }

                //add to playlist or anything addable
                Label{
                    id:addbtn
                    anchors.left:likebtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf0fe"

                    font{
                        bold:true
                        family:solidfont.name
                        pixelSize: parent.height/5
                    }


                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
//                            DBManager.creatPlaylist("new playlist");
                            openAddPopup();
                        }
                    }
                }
                Canvas{
                    id:durationcanvas
                    property real duration: 0

                    function clear(){
                        var ctx = getContext("2d");
                        ctx.clearRect(durationcanvas.x,durationcanvas.y,durationcanvas.x+durationcanvas.width,durationcanvas.y+durationcanvas.height)

                    }

                    NumberAnimation on duration {
                        id:anim
                        from: 1
                        to:3
                        duration: allsongend

                    }

                    width: ppbtn.width+ 10
                    height: ppbtn.height+10
                    anchors.verticalCenter: ppbtn.verticalCenter
                    anchors.horizontalCenter: ppbtn.horizontalCenter
                    z:200

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.fillStyle = globalstyle.mainFG
                        //            ctx.arc(100, 100, 50, 0, 2 * Math.PI,true)
                        ctx.lineWidth = 1;
                        ctx.beginPath();
                        ctx.strokeStyle = globalstyle.mainFG
                        ctx.lineWidth=4
                        ctx.arc(width/2, height/2, ppbtn.width/2+2.5,Math.PI,3*Math.PI,true)
                        //Number(slider.value)
                        ctx.stroke();

                    }

                    Component.onCompleted: {
                        console.log(ppbtn.x, ppbtn.y,ppbtn.width,ppbtn.height)
                    }
                }

            }
        }

        //progress bar
        Row{
            id:pbarlayout
            //            anchors.leftMargin: 200
            Layout.leftMargin: 200
            height: 90
            width: height*10
            //            anchors.left: controlpanel.right
            Layout.alignment: Qt.AlignLeft
            //Label for progres
            Label{
                text: passedToText()
                anchors.verticalCenter: parent.verticalCenter
                font{
                    bold: true
                    pixelSize: 12
                }
            }

            //show song progress
            Slider{
                id:slider
                //                Layout.fillWidth: true
                width: 400
                anchors.verticalCenter: parent.verticalCenter
                Material.accent: mainFront
                value: allsong.passed  // allsong.endPosition
                from:0
                to:allsong.endPosition

                onMoved: {
                    allsong.setSongPos(value)
                }


            }
            //Label for duration
            Label{
                text: durationToText();
                width: parent.width/6
                anchors.verticalCenter: parent.verticalCenter
                font{
                    bold: true
                    pixelSize: 12
                }
            }
        }


        //blank space
        Item {
            id: blank
            Layout.fillWidth: true
        }

        Label{
            id:fullscrbtn
            //            anchors.right: parent.right
            //            anchors.verticalCenter: parent.verticalCenter
            //            anchors.rightMargin: parent.height/4
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: parent.height/4


            text:"\uf102"

            font{
                bold:true
                family:solidfont.name
                pixelSize: parent.height/5
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainwindow.toggleDrawer()
                    ;                }
            }
        }



    }

    Component.onCompleted: {
        playBtnPressed.connect(changeOnPlayBtnPressed)
    }


}
