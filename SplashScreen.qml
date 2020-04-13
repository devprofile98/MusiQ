import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3


Rectangle {


    anchors.fill: parent
    color: "#242323"
    Material.theme: Material.Dark
    Rectangle{
        anchors.centerIn: parent
        width: 300
        height: width
        gradient: Gradient {
            GradientStop {id:first; position: 0.0; color: "#d3aaf2" }
            GradientStop {id:second; position: 1; color: "#d18bf0" }
//            GradientStop { position: 1.0; color: "#9c30f0" }
        }



        ParallelAnimation{
            id:anim
        ColorAnimation {

            target: first
            property: "color"
            from: "#d3aaf2"
            to: "#f03cb7"
            duration: 2500
        }

        ColorAnimation {

            target: second
            property: "color"
            from: "#d18bf0"
            to: "#f03cb7"
            duration: 2500
        }
        }



//        color:'pink'
        radius: 20

        Image {
            //        width: parent.width - 20
            //        height: width
            sourceSize{
                width: parent.width - 20
                height:width
            }

            anchors.centerIn: parent
            id: splashscreen
            source: "qrc:/new/prefix1/thumbnail.svg"
        }

    }


    Timer{
        interval: 5000
        running: true

        onTriggered: {
            parent.visible  = false
            allsong.play()
        }
    }

    Component.onCompleted: {
        anim.start()
    }


}

/*



      #####         ######
     ###  ##       ###  ###
      #####          #####



       ##              ##
        ###         ###
         ###########






  */
