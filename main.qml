//import QtQuick 2.9
//import QtQuick.Controls 2.2

//ApplicationWindow {
//    id: mainRectangle
//    objectName: 'mainRectangle'
//    visible: true
//    width: 1920
//    height: 1080
//    title: qsTr("Duplicate Image Finder")

//    ScrollView {
//        id: imageDupScrollView
//        anchors.fill: parent

//        ListView {
//            id: mainListView
//            //                anchors.fill: parent
//            width: parent.width
//            model: imageListModel
//            delegate: ImageGroupDelegate{}
//        }
//    }

////    Rectangle{
////        anchors.fill: parent
////        //////////////////////////////////////////////////////////
////        // page loader
////        Loader {
////            id: loader
////            onLoaded: {
////                item.fadeIn()
////            }
////        }

////        states: [
////            State {
////                name: "MainWindowState"
////                PropertyChanges {
////                    target: loader;
////                    source: "MainScrollWindow.qml"
////                }
////            },
////            State {
////                name: "ImageGroupDisplay"
////                PropertyChanges {
////                    target: loader
////                    source: "thermoEventPage.qml"

////                }
////            },
////            State {
////                name: "SpashScreenState"
////                PropertyChanges {
////                    target: loader
////                    source: "SplashScreen.qml"
////                }
////            }
////        ]

////        state: "MainWindowState"
////    }
//}
import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: mainRectangle
    objectName: 'mainRectangle'
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Duplicate Image Finder")

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
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.top: headerBar.bottom
        anchors.topMargin: 0
        clip: true

        ListView {
            id: mainListView
            width: parent.width
            model: imageListModel
            delegate: ImageGroupDelegate{}
        }
    }

}

/*##^## Designer {
    D{i:25;anchors_height:200;anchors_width:200}
}
 ##^##*/
