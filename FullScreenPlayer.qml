import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0



Rectangle{
    id:mainrect
    Material.theme: Material.Dark
    color: "#242323"
    width: parent.width
    height: parent.height

    property int pbarleftx: allsong.passed / allsong.endPosition

    Image {
        id: background
        source: "image://imageprovider/"+allsong.playlistindex
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

    }




    Rectangle{
        width: parent.width/2
        height: parent.height
        color: "transparent"
        radius: 20
        anchors.left: parent.left
        id: songCover
        clip: true
        z:3

        Image {
            id:fullscreenimage
            width: parent.width/2
            height: width

            source: "image://imageprovider/"+allsong.playlistindex
            anchors.centerIn: parent
            //            z:2
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask{
                maskSource: mask
            }
            MouseArea{
                anchors.fill: fullscreenimage
                onClicked: mask.radius == 20 ? mask.radius = 0 : mask.radius = 20
                z:5
            }



        }
        Rectangle {
            id: mask
            width: fullscreenimage.width
            height:fullscreenimage.height
            radius: 20
            visible: false

            Behavior on radius {
                NumberAnimation{
                    duration: 200
                }
            }


        }


        Rectangle {
            z:4
            id: songinformation
            width: 200
            height: fullscreenimage.height
            anchors.left: fullscreenimage.right
            anchors.leftMargin: 20
            color: "transparent"
            anchors.verticalCenter:fullscreenimage.verticalCenter

            Column{
                anchors.verticalCenter:parent.verticalCenter
                spacing: 10

                Label{
                    padding: 5


                    text:"artist: "+ DataModel.songerName
                    font{
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle{
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }


                }
                Label{
                    padding: 5

                    text: "title: "+DataModel.songTitle
                    font{
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle{
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
                Label{
                    padding: 5

                    text: "album: "+DataModel.albumName
                    font{
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle{
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
                Label{
                    padding: 5

                    text:"year: "+ DataModel.songReleaseYear
                    font{
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle{
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
                Label{
                   padding: 5
                    text: "genre: "+DataModel.songGenre
                    font{
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle{
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
            }

        }



    }








    Rectangle{
        id:nextsong
        height: parent.height
        width: 90
        anchors.left: songCover.right
        color:"transparent"
        Label{
            anchors.centerIn: parent
            font{
                family: solidfont.name
                pixelSize:nextsong.width/5
                //                font.weight: Font.Black
                //                    font.styleName: "Solid" // this does the trick

            }
            text: "\uf051"
        }
        z:2
    }
    Rectangle{
        id:prevsong
        height: parent.height
        width: 90
        anchors.right: songCover.left
        color:"transparent"
        Label{
            anchors.centerIn: parent
            font{
                family: solidfont.name
                pixelSize:nextsong.width/5
                bold:true
            }
            text: "\uf048"
        }
        z:2
    }

//    DropShadow {
//        anchors.fill: songCover
//        horizontalOffset: 0
//        verticalOffset: 0
//        radius: 15
//        samples:15
//        color: "black"
//        source: songCover
//        z:2
//    }
    Rectangle{
        width: 90
        height: 90
        z:2
        color: "transparent"
        anchors{
            top: parent.top
            right: parent.right
        }
        Label{
            anchors.centerIn: parent

            text: "\uf103"
            font{
                family: solidfont.name
                bold:true
                pixelSize: parent.width/5
            }
        }


        MouseArea{
            anchors.fill: parent
            onClicked: {
                fullscreenDrawer.close();
            }
        }

    }


    Rectangle{
        id:pbar
        width: 200
        height: parent.height

        anchors.left: parent.left
    }

    FastBlur{
        id:blur
        anchors.fill: background
        source: background
        radius: 60

    }

//    ShaderEffectSource{
//        id:progresShader
//        sourceItem: blur
//        width: 200
//        height: background.height
//        live: true
//        anchors{
//            left: mainrect.left
//        }
//        sourceRect: Qt.rect(pbarleftx*mainrect.width ,y, mainrect.width, mainrect.height)
//    }

    Colorize {

        anchors.fill: blur
        source: blur
        hue: 0.0
        saturation: 0
        lightness: 0
    }
}

