import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0



Rectangle
{
    id:mainrect
    Material.theme: Material.Dark
    color: "#242323"
    width: parent.width
    height: parent.height

    property int pbarleftx: allsong.passed / allsong.endPosition

    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {
                target: songCover
                width: mainrect.width/2
            }
            PropertyChanges {
                target: fullscreenimage
                width:songCover.width/2
                anchors.centerIn: songCover
                height:width
            }
            AnchorChanges{
                target:songCover
                anchors.left: undefined
                anchors.right:undefined
            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {
                target: songCover
                width: mainrect.width/2
            }
            AnchorChanges{
                target:songCover
                anchors.left: undefined
                anchors.right:undefined
            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {
                target: songCover
                width: mainrect.width
                anchors.right: mainrect.right
                anchors.left: mainrect.left
                anchors.leftMargin: 30
                anchors.rightMargin: 30

            }
            PropertyChanges {
                target: fullscreenimage
                width:songCover.width
                height:width
            }

        }

    ]

    state: "desktop_mode"


    Image
    {
        id: background
        source: "image://imageprovider/"+allsong.playlistindex
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle
    {
        id: songCover
        width: parent.width/2
        height: parent.height
        color: fullscreenimage.source ? "transparent" : "orange"
        radius: 15
        clip: true
        z:3

        Image
        {
            id:fullscreenimage
            width: parent.width/2
            height: width

            source: "image://imageprovider/"+allsong.playlistindex
            onSourceChanged: {
            }

            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask
            {
                maskSource: mask
            }
            MouseArea
            {
                anchors.fill: fullscreenimage
                onClicked: mask.radius == 15 ? mask.radius = 0 : mask.radius = 15
                z:5
            }
        }

        Rectangle
        {
            id: mask
            width: fullscreenimage.width
            height:fullscreenimage.height
            radius: 20
            visible: false

            Behavior on radius
            {
                NumberAnimation
                {
                    duration: 200
                }
            }


        }


        Rectangle
        {
            z:4
            visible: false
            id: songinformation
            width: 200
            height: fullscreenimage.height
            anchors.left: fullscreenimage.right
            anchors.leftMargin: 20
            color: "transparent"
            anchors.verticalCenter:fullscreenimage.verticalCenter

            Column
            {
                anchors.verticalCenter:parent.verticalCenter
                spacing: 10

                Label
                {
                    padding: 5


                    text:"artist: "+ DataModel.songerName
                    font
                    {
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle
                    {
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }


                }
                Label{
                    padding: 5

                    text: "title: "+DataModel.songTitle
                    font
                    {
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle
                    {
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
                Label{
                    padding: 5

                    text: "album: "+DataModel.albumName
                    font
                    {
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle
                    {
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

                    background: Rectangle
                    {
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
                Label{
                    padding: 5
                    text: "genre: "+DataModel.songGenre
                    font
                    {
                        pixelSize: 13
                        bold:true
                    }
                    color: "white"

                    background: Rectangle
                    {
                        color: "#3d3d3a"
                        opacity: 0.4
                        radius: 4

                    }
                }
            }

        }

        Label{
            id:nextbtn
            anchors
            {
                right: fullscreenimage.right
                top: fullscreenimage.bottom
                topMargin:25
                rightMargin:25
            }

            font
            {
                family: solidfont.name
                pixelSize:18
            }

            padding: 5

            background: Rectangle
            {
                height:parent.height
                width:height

                color: "#3d3d3a"
                opacity: 0.4
                radius: 5

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        allsong.nextSong();
                        //                    DataModel.extractSongInfo(allsong.playlistindex);
                    }
                }
            }

            text: "\uf051"


        }


        Label{
            id:prevbtn
            anchors
            {
                left: fullscreenimage.left
                top: fullscreenimage.bottom
                topMargin:25
                leftMargin:25
            }

            padding: 5

            font{
                family: solidfont.name
                pixelSize:18
            }

            background: Rectangle
            {

                height:parent.height
                width:height

                color: "#3d3d3a"
                opacity: 0.4
                radius: 5
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                    {
                        allsong.preSong();
                        //                    DataModel.extractSongInfo(allsong.playlistindex);
                    }
                }
            }
            z:1000
            text: "\uf048"


        }

    }


    Rectangle
    {
        width: 30
        height: 30
        anchors.margins: 10
        z:2
        color: Qt.rgba(100,100,100,0.4)
        radius: 8
        anchors
        {
            top: parent.top
            right: parent.right
        }
        Label
        {
            anchors.centerIn: parent

            text: "\uf103"
            font
            {
                family: solidfont.name
                bold:true
                pixelSize: 18
            }
        }


        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                fullscreenDrawer.close();
            }
        }

    }


    FastBlur
    {
        id:blur
        anchors.fill: background
        source: background
        radius: 100

    }


    Colorize
    {
        anchors.fill: blur
        source: blur
        hue: 0.0
        saturation: 0
        lightness: 0
    }
}

