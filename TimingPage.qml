import QtQuick 2.0
import QtQuick.Controls 2.5

Page{
    id: mainView
    background: Rectangle{
        color:Qt.rgba(61,61, 58,0.05)
        radius: 10
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
