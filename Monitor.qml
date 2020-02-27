import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.3
import SongFinder 1.0
import QtQuick.Window 2.3


Frame{
    topPadding:5
    background: Rectangle{
    }

    width: mainwindow.width/4
    height: mainwindow.height/2

    property string psource:""
    property bool played: false
    property real vol: 0.5

    onPlayedChanged: {
        if (played){
            musicplayer.play()

        }
        else
        {
            musicplayer.pause()
        }
    }

//     : {
//        musicplayer.source = psource
//        musicplayer.play()
//    }

    onVolChanged: {
        musicplayer.volume = vol
    }

    MediaPlayer{

        onStatusChanged: {
               if (status==7){
                  musiclist.nextsong();
                   console.log("should go to next song");
               }
        }

        id:musicplayer
        volume: 0.5
        source: psource
        onDurationChanged: {
//            console.log(duration)
        }
        onPositionChanged: {
            player.end = (((3/2)*Math.PI)/duration)*position
//            console.log("end is ",player.end)
            player.pos = position

        }


    }

}

