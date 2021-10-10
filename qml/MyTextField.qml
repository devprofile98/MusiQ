import QtQuick 2.0
import QtQuick.Controls 2.5


TextField {
    property alias backColor: background.color
    property real fontSize: 12
    id: control
    leftInset:-10
    color: globalstyle.mainFG
    font{
        bold:true
        pixelSize: fontSize
        family: ubold.name
    }

    states: [
        State {
            name: "focus_on"
            PropertyChanges {
                target: control

            }
        },
        State {
            name: "focus_off"
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

    background: Rectangle {
        id:background
        implicitWidth: 200
        implicitHeight: 40
        color: "gray"
        radius: 5

    }
}

