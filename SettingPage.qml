import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Rectangle{
    id:mainrect
    visible: false
    radius: 10
    anchors.fill: parent
    color: Qt.rgba(61,61, 58,0.05)
    //    color:"/*red*/"
    clip:true
    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {

            }
            AnchorChanges{

            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {

            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {


            }


        }

    ]

    state: "desktop_mode"
    RowLayout{
        width: implicitWidth
        height: implicitHeight
        anchors.centerIn: parent
        spacing: 10
        Tumbler{
            id:htumbler
            model:12
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignLeft

        }
        Tumbler{
            id:mtumbler
            model:12
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignLeft
        }
        Tumbler{
            id:stumbler
            model:12
            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignRight
        }

        Rectangle{
            id:terminatebtn
            width: 40
            height: 40
            Layout.alignment: Qt.AlignCenter
            color:"transparent"
            Label{
                text:"\uf144"
                font{
                    pixelSize: 25
                    family: solidfont.name

                }
                color:"#855dd4"
                MouseArea{
                    anchors.fill: parent

                    onClicked:{
                        terminatetimer.interval = htumbler.currentIndex *(60*60*1000) + mtumbler.currentIndex*(60*1000) + stumbler.currentIndex*(1000)
                        terminatetimer.start()

                    }

                }

                anchors.centerIn: parent
            }

            Timer{
                id:terminatetimer
                running: false
                onTriggered: {
                    allsong.pause()
                }
            }
        }

    }
}
