import QtQuick 2.0
import QtQuick.Controls 2.5


  TextField {
//        property alias labelvalue: lbl.text
        property alias backColor: background.color
//        property alias frontColor: lbl.color
//        property alias maintext: maintext.text
        id: control
        leftInset:-10
        color: globalstyle.mainFG
        font{
            bold:true
            pixelSize: 15
            family: ubold.name
        }

        states: [
            State {
                name: "focus_on"
                PropertyChanges {
                    target: control

                }
//                AnchorChanges{
////                    target: lbl
////                    anchors.top:undefined
////                    anchors.bottom: control.top
////                    anchors.verticalCenter: undefined
////                }
//                AnchorChanges{
//                    target: maintext
//                    anchors.left: control.left
//                }
//                PropertyChanges {
//                    target: maintext
//                    text:control.text

//                }
            },
            State {
                name: "focus_off"

//                AnchorChanges{
//                    target: lbl
//                    anchors.verticalCenter: control.verticalCenter

//                    anchors.bottom: undefined
//                }
//                AnchorChanges{
//                    target: maintext
//                    anchors.left: control.left
//                }

            }
        ]
        state: "focus_off"

        transitions:
            Transition {
            from: "*"
            to: "*"
            AnchorAnimation{
                duration: 200
                easing.type: Easing.OutQuad
            }

        }



//        onFocusChanged: {
//            if(focus){
//                control.state = "focus_on";
//            }
//            else{
//                control.state = "focus_off";
//            }
//        }

        background: Rectangle {
            id:background
            implicitWidth: 200
            implicitHeight: 40
            color: "gray"
            radius: 5

        }

//        Label{
//            id:lbl
//            text:labelvalue
//            //            anchors.top: control.top
//            anchors.left: control.left
//            anchors.verticalCenter: control.verticalCenter
//            anchors.leftMargin:20
//            font{
//                bold:true
//            }
//        }

//        Label{
//            id:maintext
//            text:""
//            anchors.left: control.left
//            anchors.verticalCenter: control.verticalCenter
////            anchors.leftMargin:20
//            font{
//                bold:true
//                pixelSize: 15
//            }
//        }
    }

