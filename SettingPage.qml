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
        model:12
        Layout.preferredWidth: implicitWidth
        Layout.alignment: Qt.AlignLeft

    }
    Tumbler{
        model:12
        Layout.preferredWidth: implicitWidth
        Layout.alignment: Qt.AlignLeft
    }
    Tumbler{
        model:12
        Layout.preferredWidth: implicitWidth
        Layout.alignment: Qt.AlignRight
    }
    }
}
