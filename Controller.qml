import QtQuick 2.0
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
        print("chap")
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
            console.log(allsong.playlistindex,allsong.currentpath)

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

}


    property color btncolor: "#855dd4" //#7f05e3
    property string endPosition: "00:00"
    signal playBtnPressed(bool play);

    width:parent.width
    height:parent.height
    color: "transparent"


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

                //                GaussianBlur:10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.width: parent.width
                sourceSize.height: parent.width
                id: thumbnail
                source:"qrc:/new/prefix1/thumbnail.svg"

            }
            visible: true
        }

        // controler panel
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
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            isPlaying = true

                            allsong.preSong()

                            //                            tools.m_pauseRequested()

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
                            if (mainwindow.isPlaying)
                            playBtnPressed(false)
                            else{
                                playBtnPressed(true)
                            }

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
                            console.log("clicked on me")
                            isPlaying = true
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
                            allsong.changePlaybackMode(0);
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
                            allsong.changePlaybackMode(4);
                        }
                    }
                }

                //add to favorite
                Label{
                    id:likebtn
                    anchors.left:shufflebtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf004"

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
                }

            }
        }

        //progress bar
        Row{
            id:pbarlayout
            anchors.leftMargin: 200
            height: 90
            width: height*10
            anchors.left: controlpanel.right

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
                Material.accent: btncolor
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
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: parent.height/4

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
