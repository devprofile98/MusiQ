import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3



Popup{
    id:settingpopup
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

        MyTextField{
            id:singername
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            //            labelvalue: "Singer"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            //            maintext:DataModel.songerName
            Material.accent: "#d18bf0"
            placeholderText: DataModel.songerName
            //            frontColor: globalstyle.mainFG

        }

        MyTextField{
            id:songtitle
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            //            labelvalue: "Title"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            //            maintext:DataModel.songTitle
            placeholderText: DataModel.songTitle
            Material.accent: "#d18bf0"
            //            frontColor: globalstyle.mainFG
        }

        MyTextField{
            id:albumname
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            //            labelvalue: "Album"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            //            maintext:DataModel.albumName
            placeholderText: DataModel.albumName
            Material.accent: "#d18bf0"
            //            frontColor: globalstyle.mainFG
        }

        MyTextField{
            id:releaseyear
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            //            labelvalue: "Release"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            //            maintext:DataModel.songReleaseYear
            placeholderText: DataModel.songReleaseYear
            Material.accent: "#d18bf0"
            //            frontColor: globalstyle.mainFG
        }

        MyTextField{
            id:genre
            Layout.alignment:Qt.AlignHCenter | Qt.AlignTop
            //            labelvalue: "Genre"
            Layout.preferredWidth: parent.width*(3/4)
            Layout.preferredHeight: implicitHeight
            backColor: Qt.rgba(61,61, 58,0.04)
            //            maintext:DataModel.songGenre
            placeholderText: DataModel.songGenre
            Material.accent: "#d18bf0"
            //            frontColor: globalstyle.mainFG

        }

        Button{
            width: 100
            height: 30
            text:"save"
            Layout.alignment: Qt.AlignHCenter

            font{
                bold:true
                family: ubold.name
            }

            onClicked: {
                DataModel.editSongInfo(allsong.playlistindex,singername.text, songtitle.text, albumname.text, releaseyear.text, genre.text)
            }
        }
    }
}

//}
