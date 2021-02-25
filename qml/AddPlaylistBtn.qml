import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup {
    id: popup

    modal: true
    Overlay.modal: Rectangle{
        color: "#e2525252";

    }
    background: Rectangle
    {
        anchors.fill:parent
        color:globalstyle.mainBG
        radius:10
    }


    ColumnLayout{
        width: parent.width
        height: parent.height
        spacing: 10
        Label
        {
            id:label
            text:"New Playlist"
            color:Qt.rgba(61,61, 58,0.5)
            font {
                bold:true
            }
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
        }


        MyTextField{
            id:playlistname
            //        anchors.horizontalCenter: popup.
            backColor: Qt.rgba(61,61, 58,0.04)
            placeholderText: "Playlist name e.g Gym"
            Layout.alignment: Qt.AlignHCenter

        }


        Button{
            width: 100
            height: 30
            text:"Create"
            Layout.alignment: Qt.AlignHCenter

            font{
                bold:true
                family: ubold.name
            }

            onClicked: {
                if(playlistname.text !== ""){
                    DBManager.creatPlaylist(playlistname.text)
                    popup.close();
                }
            }
        }

    }

    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    onClosed: {
        addplaylistloader.active = false;
    }

}
