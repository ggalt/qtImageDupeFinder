import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    ScrollView {
        anchors.fill: parent

        ListView {
            id: mainListView
            width: parent.width
            model: 20
            delegate: ImageGroupDelegate{}
//            delegate: ItemDelegate {
//                text: "Item " + (index + 1)
//                width: parent.width
//            }
        }
    }
}
