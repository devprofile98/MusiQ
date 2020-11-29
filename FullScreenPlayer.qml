import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
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
    property int iconsize: 18


    function editPageOpen(){
        //        scaleanim.start();
        _editerloader.active = true;
        _editerloader.item.open();
        //        scaleanim.start();
    }

    function editPageClose(){
        _editerloader.active = false;

    }

    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {
                target: mainrect
                iconsize:18
            }
            PropertyChanges {
                target: songCover
                width: mainrect.width/2
            }
            PropertyChanges {
                target: songinformation
                visible:true;
            }
            PropertyChanges {
                target: fullscreenimage
                width:songCover.width/2
                anchors.centerIn: songCover
                height:width
            }
            PropertyChanges {
                target: controlrow
                spacing:20

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
                target: mainrect
                iconsize:18
            }
            PropertyChanges {
                target: songCover
                width: mainrect.width/2
            }
            PropertyChanges {
                target: controlrow
                spacing:10

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
                target: mainrect
                iconsize:14
            }
            PropertyChanges {
                target: songCover
                width: mainrect.width
                anchors.right: mainrect.right
                anchors.left: mainrect.left
                anchors.leftMargin: 30
                anchors.rightMargin: 30

            }

            PropertyChanges {
                target: controlrow
                spacing:6

            }

            PropertyChanges {
                target: fullscreenimage
                width:songCover.width
                height:width
            }

        }

    ]

    state: "desktop_mode"

    SequentialAnimation{
        id:scaleanim
        running: false
        ScaleAnimator {

            target: mainrect;
            from: 1
            to: 1.2
            duration: 100
            running: false
        }
        ScaleAnimator {

            target: mainrect;
            from: 1.2
            to: 1
            duration: 100
            running: false
        }
    }


    Image
    {
        id: background
        source: "image://imageprovider/"+allsong.playlistindex
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
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
            onStatusChanged: {
                if(fullscreenimage.status === Image.Error || fullscreenimage.state === Image.Null){
                    defaultCover.visible = true;
                    console.log("from error status")
                }
                else{
                    defaultCover.visible = false;
                    console.log("from else status")
                }
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

        Rectangle{
            id:defaultCover
            width: fullscreenimage.width
            height:fullscreenimage.height
            radius: 20
            visible: false
            color: "#d3aaf2"
            z:10
            anchors{
                fill:fullscreenimage
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

        RowLayout{
            id:controlrow
            width: implicitWidth //fullscreenimage.width
            height: implicitHeight
            anchors{
                horizontalCenter: songCover.horizontalCenter
                top: fullscreenimage.bottom
                topMargin: 25
            }
            spacing: 20

            Label{
                id:rptbtn
                //                anchors{
                //                    right: prevbtn.left
                //                    verticalCenter:ppbtn.verticalCenter
                //                    rightMargin: 25
                //                }
                text:"\uf2f9"
                padding:5
                background: Rectangle
                {

                    height:parent.height
                    width:height
                    color: "#3d3d3a"
                    opacity: 0.4
                    radius: 5
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            allsong.changePlaybackMode();
                        }
                    }
                }

                font{
                    bold:true
                    family:solidfont.name
                    pixelSize: iconsize
                }
            }

            Label{
                id:prevbtn
                //                anchors
                //                {
                //                    right:ppbtn.left
                //                    verticalCenter:ppbtn.verticalCenter
                //                    rightMargin:25
                //                }
                padding: 5
                font{
                    family: solidfont.name
                    pixelSize:iconsize
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
                        }
                    }
                }
                z:1000
                text: "\uf048"
            }

            Label{
                id:ppbtn
                font
                {
                    family: solidfont.name
                    pixelSize:iconsize*3
                }
                //                anchors{
                //                    topMargin: 25
                //                    horizontalCenter: fullscreenimage.horizontalCenter
                //                    top: fullscreenimage.bottom
                //                }

                color: "white"
                text: mainwindow.isPlaying ? "\uf144" : "\uf28b"
                MouseArea{
                    anchors.fill: parent
                    onClicked: controller.changeOnPlayBtnPressed(!mainwindow.isPlaying)
                }
            }

            Label{
                id:nextbtn
                //                anchors
                //                {
                //                    left: ppbtn.right
                //                    verticalCenter:ppbtn.verticalCenter
                //                    leftMargin:25
                //                }
                font
                {
                    family: solidfont.name
                    pixelSize:iconsize
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
                        }
                    }
                }

                text: "\uf051"
            }

            Label{
                id:shufflebtn
                //                anchors{
                //                    left: nextbtn.right
                //                    leftMargin: 25
                //                    verticalCenter: ppbtn.verticalCenter
                //                }
                padding: 5
                text:"\uf074"
                font{
                    bold:true
                    family:solidfont.name
                    pixelSize: iconsize
                }
                background: Rectangle
                {
                    height:parent.height
                    width:height
                    color: "#3d3d3a"
                    opacity: 0.4
                    radius: 5
                }
            }
        }

    }

    Rectangle
    {
        id:closedrawer
        width: 30
        height: 30
        anchors.margins: 10
        z:2
        color:Qt.rgba(61, 61, 58,0.1)// "#3d3d3a"//        opacity: 0.4
        radius: 8
        anchors
        {
            top: parent.top
            right: parent.right
        }
        Label
        {
            anchors.centerIn: parent
            color: "white"
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


    Rectangle
    {
        id:editbtn
        width: 30
        height: 30
        anchors.margins: 10
        z:2
        color:Qt.rgba(61, 61, 58,0.1)// "#3d3d3a"

        //        opacity: 0.4
        radius: 8
        anchors
        {
            top: parent.top
            right: closedrawer.left
        }
        Label
        {
            anchors.centerIn: parent
            color: "white"
            text: "edit"
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
                scaleanim.start();
                _editerloader.active = true;
                _editerloader.item.open();
                scaleanim.start();
            }
        }

    }


    Component{
        id:songinfoedit
        SongInfoEditPage
        {
            implicitWidth: parent.width
            implicitHeight: parent.height

            onClosed: {
                editPageClose();
            }
        }
    }


    Loader{
        id:_editerloader
        anchors.fill: parent
        sourceComponent: songinfoedit
        active: false

        onLoaded: {
            console.log("our loader works")
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

