import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

RowLayout{
    property alias labeltext: lblid.text
//    anchors.horizontalCenter: parent.horizontalCenter
//    anchors.top: killersec.bottom
//    anchors.topMargin: 20
    width: parent.width
    spacing: 20


    Label{
        id:lblid
        text: "Appearance"
        font{
            bold: true
            family:ubold.name
        }
        color:Qt.rgba(61,61, 58,0.4)
//        Layout.implicitWidth: lblid.implicitWidth
    }

    Rectangle{

//        width: settingsep.width - lblid.width
//        anchors.verticalCenter: lblid.verticalCenter
//        anchors.right: mainrect.right
//        anchors.rightMargin: 10
//        height: 1
        Layout.preferredHeight: 1
        Layout.maximumHeight: 1
        Layout.minimumHeight: 1
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        Layout.rightMargin: 10
        color:Qt.rgba(61, 61, 58,0.1)
    }
}
