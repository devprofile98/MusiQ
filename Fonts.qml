pragma singleton

import QtQuick 2.0

Item {

    id:fonts

    readonly property FontLoader fontawesomeregular: FontLoader{
        source:"qrc:/../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Free-Solid-900.otf";
    }
    readonly property FontLoader fontawesomesolid : FontLoader{
        source: "qrc:/../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Free-Solid-900.otf";
    }
    readonly property FontLoader fontawesomebrand: FontLoader{
        source:"qrc:/../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Brands-Regular-400.otf";
    }
    readonly property string icon: fonts.fontawesomeregular.name
    readonly property string brand: fonts.fontawesomebrand.name

}
