import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0



Frame{
    id:mainframe
    width: mainwindow.width/2
    height: mainwindow.height
    background: Rectangle{
        border.color:"transparent"
        color: "#f5006e"
        radius: 15
        gradient: Gradient{
            GradientStop{position: 0.0;color:"#F45C43"}
            GradientStop{position: 1;color:"#EB3349"}
        }
    }
    property real end: Math.PI/10000
    property real pos: 0


    onEndChanged: {
        progressCanvas2.requestPaint()
    }

    Frame{

        id:imageparent
        width: parent.width
        height: parent.height*(5/6)/*-50*/
        anchors.top: parent.top
        background: Rectangle{
            border.color: "transparent"
            opacity: 0
        }

        Image {
            id: coverArt
            source: "qrc:/../Downloads/rezasadeghi.jpg"

            anchors.centerIn: parent
            width: mainframe.height/2
            height: width



            layer.enabled: true

            layer.effect: OpacityMask{
                maskSource: Item {
                    width: coverArt.width
                    height: coverArt.height
                    Rectangle{
                        anchors.fill: parent
                        radius: width/2
                    }
                }
            }
        }
    }
    Frame{
        width: parent.width
        height: parent.height*(5/6)/*-50*/
        anchors.top: parent.top
        background: Rectangle{
            color: "#f5006e"
            border.color: "transparent"
            opacity: 0
        }
        padding: 0
        anchors.margins: 0

        Canvas{
            z:7
            anchors.fill: parent
            anchors.centerIn: parent
            id:progressCanvas
            onPaint: {
                var dpi = Screen.devicePixelRatio
                var ctx =getContext("2d");
                ctx.clearRect(x,y,x+width,y+height)
                ctx.width = dpi*width
                ctx.height = dpi*height
                ctx.beginPath();
                //                ctx.moveTo(coverArt.width/2,coverArt.height/2);
                ctx.lineWidth = 4
                ctx.fillStyle = "white"
                ctx.strokeStyle = "white"
                ctx.arc(x+width/2,y+height/2,(coverArt.width/2)+14,-Math.PI/4,Math.PI+Math.PI/4,false)
                ctx.stroke()

            }
        }
        Canvas{
            anchors.fill: progressCanvas
            id:topprogressCanvas
            onPaint: {
                var ctx =getContext("2d");
                ctx.beginPath();
                ctx.moveTo(x,y+50);
            }
        }
    }
    Frame{
        width: parent.width
        height: parent.height*(5/6)/*-50*/
        anchors.top: parent.top
        background: Rectangle{
            color: "#f5006e"
            border.color: "transparent"
            opacity: 0
        }
        padding: 0
        anchors.margins: 0

        Canvas{
            z:8
            anchors.fill: parent
            anchors.centerIn: parent
            id:progressCanvas2
            onPaint: {
                var ctx =getContext("2d");
                ctx.clearRect(x,y,x+width,y+height)
                ctx.beginPath();
                ctx.lineWidth = 8
                ctx.fillStyle = "white"
                ctx.strokeStyle = "#6b0580"
                ctx.arc(x+width/2,y+height/2,(coverArt.width/2)+14,Math.PI+Math.PI/4,Math.PI+Math.PI/4-end,true)
                ctx.stroke()

            }
        }
    }
    MouseArea{
        anchors.fill:parent
        onClicked:{
            if (monitor.played == true){
                monitor.played = false
            }
            else{
                monitor.played = true
            }
        }
    }

    Frame{
        id:controlPanel
        height: mainframe.height/6
        width: mainframe.width
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        background: Rectangle{
            border.width: 0
            color:"#F45C43"
            radius: 15

        }

        RowLayout{
            width: parent.width
            height: parent.height
            spacing: 10
            Rectangle{
                anchors.right: playbtn.left
                anchors.verticalCenter: parent.verticalCenter
                width: controlPanel.height/1.75
                height: controlPanel.height/1.75
                anchors.rightMargin: 10
                color: "#E44D26"
                radius: width/2


                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        tools.setNowPlayList(monitor.psource);
                    }
                }
            }
            Rectangle{
                id:playbtn
                //                Layout.alignment: Qt.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: controlPanel.height/1.25
                height: controlPanel.height/1.25
                z:20
                color: "#E44D26"
                radius: width/2

                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        if (monitor.played == true){
                            monitor.played = false
                        }
                        else{
                            monitor.played = true
                        }
                    }
                }
            }
            Rectangle{
                anchors.left: playbtn.right
                anchors.verticalCenter: parent.verticalCenter
                width: controlPanel.height/1.75
                height: controlPanel.height/1.75
                anchors.leftMargin: 10
                color: "#E44D26"
                radius: width/2
                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        var getedsource =tools.getNowPlayList();
                        if (getedsource!=="null"){
                            monitor.psource=getedsource;
                        }

                    }
                }
            }


        }
    }

}

