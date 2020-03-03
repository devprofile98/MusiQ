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

    property color btncolor: "#7f05e3"

    width:parent.width
    height:parent.height
    color: "transparent"

    RowLayout{
        width:parent.width
        height:parent.height
        //       spacing: -100
        Rectangle{
            id:thumbnailpic
            color: "transparent"
            Layout.fillHeight: true
            Layout.preferredWidth: height
            radius: 50
            Image {
                //                GaussianBlur:10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width*(3/4)
                height: width
                id: thumbnail
                source: "image://live/image?id="+allsong.getPath()
            }

        }

        // controler panel
        Rectangle{
            color: "transparent"
            Layout.fillHeight: true
            Layout.preferredWidth: height*3
            Layout.leftMargin: height
            Row{
                anchors.fill: parent
                // previous song button
                Label{
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
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
                        family:solidfont
                        pixelSize: parent.height/4
                    }
                }

                //play and pause button
                Label{
                    id:ppbtn
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            allsong.pause()
                            //                            tools.m_pauseRequested()

                        }
                    }
                    anchors.centerIn: parent
                    text:"\uf144"

                    font{
                        bold:true
                        family:solidfont
                        pixelSize: parent.height/2
                    }
                }

                // next song button
                Label{
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.error(allsong.nextSong())
                            //                            tools.m_pauseRequested()

                        }
                    }

                    id:nextbtn
                    anchors.left:ppbtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf051"

                    font{
                        bold:true
                        family:solidfont
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
                        family:solidfont
                        pixelSize: parent.height/5
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
                        family:solidfont
                        pixelSize: parent.height/5
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
                        family:solidfont
                        pixelSize: parent.height/5
                    }
                }

                //add to favorite
                Label{
                    id:addbtn
                    anchors.left:likebtn.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: parent.height/4

                    text:"\uf0fe"

                    font{
                        bold:true
                        family:solidfont
                        pixelSize: parent.height/5
                    }
                }

            }
        }

        //progress bar
        RowLayout{
            Layout.fillHeight: true
            Layout.preferredWidth: height*10
            Layout.maximumWidth: height*10
            Layout.leftMargin: 200
            //Label for progres
            Label{
                text: "03:58"
                width: parent.width/6
                anchors.verticalCenter: parent.verticalCenter
                font{
                    bold: true
                    pixelSize: 12
                }
            }
            //show song progress
            Slider{
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                Material.accent: btncolor
                value: allsong.progress /200


            }
            //Label for duration
            Label{
                text: "04:31"
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
                family:solidfont
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




}
