import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: imageDisplayWindow
    objectName: 'imageDisplayWindow'
    width: 1920
    height: 1080
    color: "lightgrey"

    property int numRows: 0
    property int numColumns: 0

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

    function spreadRows(itemCount) {
        var sqrt_items = Math.sqrt(itemCount)
        numRows = sqrt_items/1.618
        numColumns = sqrt_items * 1.618
        console.log("Rows:",numRows,"Columns:",numColumns)
    }

    Button {
        id: button
        x: 666
        y: 607
        text: qsTr("Button")
        onPressed: spreadRows(15)
    }

    Button {
        id: closeBtn
        x: 1070
        y: 785
        text: qsTr("Close")
        onPressed: appMainWindow.changeState("MainWindow")
    }

}
