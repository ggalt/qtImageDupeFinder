import QtQuick 2.9
import QtQuick.Controls 2.2


Rectangle {
    width: parent.width
    height: 120
    id: imageGroupDelegate

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
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            appWindow.currentItemSelected = index
            appWindow.listImagePaths()
            appWindow.imageLineClicked()
        }
    }
}



//        Rectangle {
//            id: mouseHoverHightlight
//            color: "#ffffff"
//            anchors.fill: parent
//        }

//        Connections {
//            target: mouseArea
//            onEntered: { imageGroupDelegate.state = "mouseHover" }
//        }

//        Connections {
//            target: mouseArea
//            onExited: { imageGroupDelegate.state = "mouseAbsent" }
//        }

//        states: [
//            State {
//                name: "mouseHover"

//                PropertyChanges {
//                    target: mouseHoverHightlight
//                    color: "#808080"
//                    opacity: 0.5
//                }
//            },
//            State {
//                name: "mouseAbsent"

//                PropertyChanges {
//                    target: mouseHoverHightlight
//                    color: "#808080"
//                    opacity: 0
//                }
//            }
//        ]


/*##^## Designer {
    D{i:11;anchors_height:200;anchors_width:200}
}
 ##^##*/
