import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id:mainScrollWindow
    objectName: 'mainScrollWindows'

    color: "lightgrey"
    opacity: 1

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    function fadeIn() {
        fadeInAnimation.start()
    }

    Rectangle {
        id: headerBar
        height: 100
        border.color: "grey"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "darkgrey"
            }

            GradientStop {
                position: 0.252
                color: "#a9a9a9"
            }

            GradientStop {
                position: 1
                color: "lightgrey"
            }

        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top

        Rectangle {
            id: rectangle
            width: 200
            color: "#ffffff"
            border.color: "#cccccc"
            opacity: 1
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.top: parent.top

            Text {
                id: imgLabel
                color: "#000000"
                text: qsTr("IMAGE:")
                font.pointSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.top: headerBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.left: parent.left
//        anchors.leftMargin: 0
//        anchors.bottom: parent.bottom
//        anchors.top: headerBar.bottom
//        anchors.topMargin: 0
        clip: true

        ListView {
            id: mainListView
            width: parent.width
            model: imageListModel
            delegate: ImageGroupDelegate{}
        }
    }

}
