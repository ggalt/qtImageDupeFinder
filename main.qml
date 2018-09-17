//import QtQuick 2.9
//import QtQuick.Controls 2.2

//ApplicationWindow {
//    id: appMainWindow
//    objectName: 'appMainWindow'
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

Rectangle {
    id: appMainWindow
    objectName: 'appMainWindow'
    visible: true
    width: 1920
    height: 1080
    //    title: qsTr("Duplicate Image Finder")

    //////////////////////////////////////////////////////////////
    property int curIndex
    property variant imageDisplayWin
    property string myState: "MainWindow"

    //    function loadImageDisplayWindow() {
    //        var imgDispComponent = Qt.createComponent("ImageDisplayWindow.qml")
    //        imageDisplayWin = imgDispComponent.createObject(appMainWindow)
    //        var i = imageDisplayWin.show()
    //        console.log("**********************")
    //        overlay.modeless.loadUrl("ImageDisplayWindow.qml")
    //    }

    //////////////////////////////////////////////////////////
    // page loader
    //    Loader {
    //        id: loader
    //        onLoaded: {
    //            item.fadeIn()
    //        }
    //    }

    //    function changeState(newState) {
    //        myState = newState
    //        if(myState == "MainWindow") {
    //            loader.setSource("MainScrollWindow.qml")
    //        } else if(myState == "DiplayImages") {
    //            loader.setSource("ImageDisplayWindow.qml")
    //        }
    //    }
    // page loader
    Loader {
        id: loader
        onLoaded: {
            item.fadeIn()
        }
    }

    states: [
        State {
            name: "MainWindowState"
            PropertyChanges {
                target: loader;
                source: "MainScrollWindow.qml"
            }
        },
        State {
            name: "ImageGroupDisplay"
            PropertyChanges {
                target: loader
                source: "thermoEventPage.qml"

            }
        },
        State {
            name: "SpashScreenState"
            PropertyChanges {
                target: loader
                source: "SplashScreen.qml"
            }
        }
    ]

    state: "MainWindowState"

}

/*##^## Designer {
    D{i:25;anchors_height:200;anchors_width:200}
}
 ##^##*/
