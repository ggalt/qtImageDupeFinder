import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: imageGroupDelegate
    width: parent.width
    height: 120

    Rectangle {
        id: imageRectangle
        width: height
        color: "#00000000"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
    }

    Rectangle {
        id: countRectangle
        width: height
        color: "#00000000"
        anchors.left: imageRectangle.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: txtCountText
            color: "#808080"
            text: imageListModel.getCurImageListCount(index)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pointSize: 14
        }
    }

    Rectangle {
        id: nameRectangle
        color: "#00000000"
        anchors.left: countRectangle.right
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: fileName
            color: "#808080"
            text: imageListModel.getImageFileName(index)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pointSize: 14
        }
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: false
        anchors.fill: parent
        onClicked: {
            appWindow.currentItemSelected = index
            appWindow.listImagePaths()
            appWindow.imageLineClicked()
        }
    }

}

/*##^## Designer {
    D{i:12;anchors_height:200;anchors_x:13;anchors_y:8}D{i:14;anchors_height:200}D{i:15;anchors_height:200;anchors_width:200}
D{i:18;anchors_height:100;anchors_width:100}
}
 ##^##*/
