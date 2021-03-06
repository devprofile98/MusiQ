import QtQuick 2.0
import QtQuick.Controls 2.5
import roundedrect 1.0
Page{
    id: mainView

    states:[
        State {
            name: "desktop_mode"
            PropertyChanges {
                target: backrect
                toprightRadius: 10
                topleftRadius: 10
                bottomleftRadius: 10
                bottomrightRadius: 10

            }
        },
        State {
            name: "middle_mode"
            PropertyChanges {
                target: backrect
                toprightRadius: 10
                topleftRadius: 10
                bottomleftRadius: 10
                bottomrightRadius: 10

            }
        },
        State {
            name: "mobile_mode"
            PropertyChanges {
                target: backrect
                toprightRadius: 0
                topleftRadius: 0
                bottomleftRadius: 10
                bottomrightRadius: 0

            }
        }
    ]

    state: "desktop_mode"


    background: RoundedRect{
        id:backrect
        color:globalstyle.itemBG
        toprightRadius: 10
        topleftRadius: 10
        bottomleftRadius: 10
        bottomrightRadius: 10
    }

    header: Rectangle
    {
        width:parent.width
        Label{
            text: "Recent play's"
            font{
                bold:true

            }
            color:Qt.rgba(61,61, 58,0.5)
        }
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:10

    }

    Path {
        startX: 300; startY:300
        PathLine { x: 500; y: 500 }
    }
}
