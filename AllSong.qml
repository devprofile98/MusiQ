import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    //        anchors.top: parent.top
    id:mainrect

    function nextSong(){
        songmodel.next()
    }
    function preSong(){
        songmodel.previous()
    }
    function play(){

    }
    function pause(){
       songmodel.pause()
    }



    property color clickColor: "transparent"

    width: parent.width
    height: parent.height
    radius: 10
    color:Qt.rgba(61,61, 58,0.05)
    //        anchors.bottom: controller.top
    anchors.verticalCenter: fillingitem.verticalCenter
    anchors.rightMargin: 20
    Rectangle{
        id:labelrect
        width: parent.width
        height: 45
        color: "transparent"
        Label{
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            id:sectionlabel
            text: "All Songs "
            anchors.top:parent.top
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                songmodel.next();
            }
        }
    }
    ListView{
        id:listvi
        width:parent.width -20
        height: parent.height -45
        anchors.top: labelrect.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        model: Songfinder{id:songmodel}
        clip: true
        spacing:10
        delegate: Rectangle{
            height: 90
            width: parent.width
            //        anchors.bottomMargin: 10
            radius: 10
            color: model.selected ? "#3d3d3a" : "transparent"
//            color: model.duration
            MouseArea{
                property color btnColor: "transparent"
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log(model.path)
                    clickColor = "#3d3d3a"
//                    parent.color = clickColor
                    model.selected = true;
                    songmodel.play(model.path,model.index);
                }
                onEntered: {
                    console.log(model.selected)
                    if (!model.selected){
                    parent.color = "#3d3d3a"
                    }
                }
                onExited: {
                    parent.color = model.selected ? "#3d3d3a" : "transparent"
                    clickColor = clickColor


                    //                }
                    //                onBtnColorChanged:{
                    //                    mainrect
                    //                }

                }
            }

            Row{
                spacing: 10
                //                anchors.fill: parent
                width: parent.width
                height: parent.height

                Image {
//                    source: "/../Pictures/sign/Crazy Big Gun - Overdose.jpg"
                    source: toString(model.pic_url)
                    onSourceChanged: {
                        console.log(model.pic_url+"sdfsdfsdfsfsdf")
                    }

                    height: parent.height -10
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    OpacityMask{
                        anchors.fill: parent
                        maskSource:                Rectangle{
                            height: parent.height
                            width: height
                            color: "transparent"
                            radius: 10
                        }
                        source: parent
                    }
                }



                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.name
                    font{
                        family: "ubuntu"
                    }
                    color: "white"
                }
                //            Label{
                ////                anchors.right: parent.right
                //                anchors.verticalCenter: parent.verticalCenter
                //                text: model.desc

                //                font{
                //                    family: "ubuntu"
                //                }
                //                color: "white"
                //            }

            }
        }

    }

}
