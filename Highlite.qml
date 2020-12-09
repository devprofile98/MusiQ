import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    width: parent.width
    height: parent.height
    property alias holdcolor: animerect.color
    property alias maincolor: rect.color
    property alias mainradius: rect.radius
    property int towidth: 300
    color: "transparent"

    function holdAnimation(){
        animerect.opacity = 0.3;
        animerect.visible = true;
        anime.start();
//        animerect.width =10;
//        animerect.visible = false;
    }

    Rectangle{
        id:rect
        width: parent.width
        height: parent.height

        anchors.centerIn: parent
        color: "red"
        radius: 5

        //        clip: true

        Rectangle{
            id:animerect
            width: 10
            height: rect.height
            radius: mainradius
            color: "white"
            opacity: 0.3
            anchors.left: parent.left
            visible: false
        }
    }
    SequentialAnimation{
        id:anime

        NumberAnimation
        {
            target: animerect
            property: "width"
            duration: 500
            easing: Easing.InBounce
            from:10
            to:towidth

        }
        NumberAnimation{
            target: animerect
            property:"opacity"
            from:0.3
            to:0
            duration: 200
        }

    }
    Timer{
        id:animetimer
        interval: 500
        onTriggered: {
            fullscreenplayer.editPageOpen();

        }
    }

    MouseArea{
        anchors.fill: rect

        onPressAndHold: {
            console.log("Fuck yout \n\n\n Fuck You")
            holdAnimation();
            animetimer.start();


        }
    }
}
