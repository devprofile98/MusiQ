import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0



Rectangle{


    function setImages(Path){
        background.source = ""
        songCover.source = ""

        background.source = Path
        songCover.source = Path
    }

    width: parent.width
    height: parent.height
    property string pictureurl: "/../Downloads/rezasadeghi.jpg";
    Image {
        id: background
        source: "image://live/image?id="+allsong.getPath()
        anchors{
            fill: parent
        }
        z:-1
    }

    Image {
        width: parent.height/2
        height: width
        id: songCover
        source: "image://live/image?id="+allsong.getPath()
        anchors.centerIn: parent
        z:2
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
                family: solidfont
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
                family: solidfont
                pixelSize:nextsong.width/5
                bold:true
            }
            text: "\uf048"
        }
        z:2
    }

    DropShadow {
        anchors.fill: songCover
        horizontalOffset: 0
        verticalOffset: 0
        radius: 15
        samples:15
        color: "black"
        source: songCover
        z:2
    }
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
                family: solidfont
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


    GaussianBlur{
        anchors.fill: background
        source: background
        radius: 60
        samples:40
        deviation: 10
    }
}

