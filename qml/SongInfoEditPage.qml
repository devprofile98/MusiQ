import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3



Popup{
    id:settingpopup

    property real headingSize: 14
    property real fontSize: 12

    background: Rectangle{
        anchors.fill: parent
        color: globalstyle.itemBG
    }

    ColumnLayout{
        width: parent.width*(3/4)
        height: parent.height
        anchors.centerIn: parent

        Label{
            id:label
            text:"Edit Song Info"
            color:Qt.rgba(61,61, 58,0.5)
            font {
                bold:true
                pixelSize: headingSize
            }
            Layout.alignment: Qt.AlignHCenter
        }

        Image {
            id: songcover
            Layout.alignment: Qt.AlignHCenter
            source: "image://imageprovider/"+allsong.playlistindex
            fillMode: Image.PreserveAspectCrop
            Layout.preferredWidth: 200 //parent.width
            Layout.preferredHeight: 200 //parent.width
            Layout.maximumHeight: 200 //parent.width



            sourceSize{
                width: songCover.width
                height: songCover.height
            }

        }

        MyTextField{
            id:singername
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            Material.accent: "#d18bf0"
            placeholderText: DataModel.songerName
            fontSize: 12

        }

        MyTextField{
            id:songtitle
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            placeholderText: DataModel.songTitle
            Material.accent: "#d18bf0"
            fontSize: 12
        }

        MyTextField{
            id:albumname
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            placeholderText: DataModel.albumName
            Material.accent: "#d18bf0"
            fontSize: 12
        }

        MyTextField{
            id:releaseyear
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            placeholderText: DataModel.songReleaseYear
            Material.accent: "#d18bf0"
            fontSize: 12
        }

        MyTextField{
            id:genre
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            placeholderText: DataModel.songGenre
            Material.accent: "#d18bf0"
            fontSize: 12

        }

        Button{
            width: 100
            height: 30
            text:"save"
            Layout.alignment: Qt.AlignHCenter

            font{
                bold:true
                family: ubold.name
                pixelSize: settingpopup.headingSize
            }

            onClicked: {
                DataModel.editSongInfo(allsong.playlistindex,singername.text, songtitle.text, albumname.text, releaseyear.text, genre.text)
            }
        }
    }
}

//}
