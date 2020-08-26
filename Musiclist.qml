
import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
//import Bend 1.0

Frame{

    function nextsong(){
        monitor.psource = Songfinder.ahmad();
    }

    background: Rectangle{
        border.color: "transparent"
    }
    width: musiclist.width
    height: musiclist.height


    ToolBar{
        id:toolb
        width: parent.width
        height: Math.max(parent.height/10,10)
        background: Rectangle{
            border.color: "transparent"
            radius: 10
            color: "#e074e8"
        }
        Material.foreground: "white"
        RowLayout{
            height: toolb.height
            width: toolb.width
            anchors.verticalCenter: parent.verticalCenter
            ToolButton{
                padding: 5
                icon.source:"qrc:/icons8-collapse-96.png"
                icon.width: toolb.height
                Layout.fillHeight: true

            }
            Label{
                text: "songs"
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                font.pixelSize: toolb.width/10
            }
        }

    }

    ListView
    {
        id:list
        width: musiclist.width
        height: musiclist.height*(9/10)
        model: Songfinder{}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: toolb.bottom
        anchors.bottom: parent.bottom
        clip: true
        delegate:

            ColumnLayout{

            anchors.horizontalCenter: parent.horizontalCenter
            height: musiclist/5
            width:musiclist.width/(6/8)


            Button{
                //properties
                property color btnColor: "#971cad"

                //background
                background: Rectangle{
                    id:inner
                    radius: 7
                    color: "#b542eb"

                }
                //Events
                onActiveFocusChanged: {
                    if (activeFocus){
                        inner.color = "white"

                        inner.border.color = "#971cad"
                        inner.border.width = 2
                        Material.foreground = "#971cad"

                        text = "is playing"
                    }
                    else{

                        inner.border.color = "#b542eb"
                        inner.border.width = 0
                        inner.color="#b542eb"
                        Material.foreground = "white"
                        text = model.desc
                    }
                }

                hoverEnabled: true
                onHoveredChanged: {
                    if (hovered){

                        inner.color = "transparent"
                        height+= height/5
                        inner.border.color = "#971cad"
                        inner.border.width = 2
                        Material.foreground = "#971cad"

                    }
                    else{
                        height =Layout.height
                        inner.border.color = "#b542eb"
                        inner.border.width = 0
                        inner.color="#b542eb"
                        Material.foreground = "white"
                    }

                }

                //button Layout
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: musiclist.width*(7/8)
                Material.background: "#b542eb"
                Layout.fillHeight: true
                Material.foreground: "white"
                text:model.name
                Material.elevation: 2
                onClicked: {
                    monitor.psource = "file:"+model.desc
                    monitor.played = true

                }

        }
    }

}



}
