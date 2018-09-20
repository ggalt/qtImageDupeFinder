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

    function fireImageLoad() {
        appMainWindow.loadImageListModel()
        console.log("fired")
    }

    //////////////////////////////////////////////////////////
    /// FIX ME!!
    signal loadImageListModel() // signal C++ it's time to load the data model

    //////////////////////////////////////////////////////////
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
