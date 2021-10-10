import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

RowLayout{
    id:componentid
    property alias labeltext: lblid.text
    property real headingSize: 15
    width: parent.width
    spacing: 20


    Label{
        id:lblid
        text: "Appearance"
        font{
            bold: true
            family:ubold.name
            pixelSize: componentid.headingSize
        }
        color:Qt.rgba(61,61, 58,0.4)
    }

    Rectangle{

        Layout.preferredHeight: 1
        Layout.maximumHeight: 1
        Layout.minimumHeight: 1
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        Layout.rightMargin: 10
        color:Qt.rgba(61, 61, 58,0.1)
    }
}
