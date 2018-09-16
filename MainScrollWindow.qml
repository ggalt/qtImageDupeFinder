import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id:mainScrollWindow
    color: "lightgrey"
    objectName: 'mainScrollWindows'

    opacity: 0

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    function fadeIn() {
        fadeInAnimation.start()
    }

}
