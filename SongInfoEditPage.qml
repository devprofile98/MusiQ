import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
//Rectangle {
//    width: parent.width
//    height: parent.height
//    id:songinfoeditpage
//    function open(){
//        if (settingpopup.opened){
//            return;
//        }
//        settingpopup.open();
//    }

Popup{
    id:settingpopup
    implicitHeight:parent.height
    implicitWidth:parent.width
    anchors.centerIn: parent
    background: Rectangle{
        anchors.fill: parent
        color: "#242323"
    }

    ColumnLayout{
        width: parent.width*(3/4)
        height: parent.height
        anchors.centerIn: parent

        Label{
            id:label
            text:"edit song info"
            color:Qt.rgba(61,61, 58,0.3)
            font {
                bold:true
            }
            Layout.alignment: Qt.AlignHCenter
        }

        Image {
            id: songcover
            Layout.alignment: Qt.AlignHCenter
            source: "image://imageprovider/"+allsong.playlistindex
            fillMode: Image.PreserveAspectCrop
            Layout.preferredWidth: 200//parent.width
            Layout.preferredHeight: 200//parent.width
            Layout.maximumHeight: 200//parent.width
            sourceSize{
                width: songCover.width
                height: songCover.height
            }

        }


        //        TextField{
        //            id:singername
        //            Layout.alignment: Qt.AlignHCenter
        //            Layout.preferredHeight: implicitHeight
        //            Material.accent: "#d18bf0"
        //            Layout.preferredWidth: parent.width*(3/4)
        //            text: DataModel.songerName
        //        }
        MyTextField{
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            labelvalue: "singer"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            frontColor: "#d18bf0"

        }
        //        TextField{
        //            id:songtitle
        //            Material.accent: "#d18bf0"
        //            Layout.preferredWidth: parent.width*(3/4)
        //            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //            Layout.preferredHeight: implicitHeight
        //            text: DataModel.songTitle
        //        }
        MyTextField{
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            labelvalue: "title"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            frontColor: "#d18bf0"
        }
        //        TextField{
        //            id:albumname
        //            Material.accent: "#d18bf0"
        //            Layout.preferredWidth: parent.width*(3/4)
        //            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //            Layout.preferredHeight: implicitHeight
        //            text: DataModel.albumName
        //        }
        MyTextField{
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            labelvalue: "album"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            frontColor: "#d18bf0"
        }
        //        TextField{
        //            id:releaseyear
        //            Material.accent: "#d18bf0"
        //            Layout.preferredWidth: parent.width*(3/4)
        //            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //            Layout.preferredHeight: implicitHeight
        //            text: DataModel.songReleaseYear
        //        }
        MyTextField{
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            labelvalue: "release"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            frontColor: "#d18bf0"
        }
        //        TextField{
        //            id:genre
        //            Material.accent: "#d18bf0"
        //
        //            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //        Layout.preferredWidth: parent.width*(3/4)
        //            Layout.preferredHeight: implicitHeight
        //            text: DataModel.songGenre
        //        }
        MyTextField{
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            labelvalue: "genre"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            frontColor: "#d18bf0"

        }

        Button{
            width: 100
            height: 30
            text:"save"
            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                DataModel.editSongInfo(allsong.playlistindex,singername.text, songtitle.text, albumname.text, releaseyear.text, genre.text)
            }
        }
    }
}

//}
