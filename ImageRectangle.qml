import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
    id: imageRectangle

    Image {
        id: image
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/qtquickplugin/images/template_image.png"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }
    }

    Switch {
        id: deleteSwitch
        text: qsTr("Delete Image")
    }

    Text {
        id: txtFileName
        text: qsTr("Filename:")
        horizontalAlignment: Text.AlignHCenter
        anchors.top: image.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 12
    }

    Text {
        id: txtResolution
        x: 322
        text: qsTr("Resolution:")
        horizontalAlignment: Text.AlignHCenter
        anchors.top: txtFileName.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 12
    }

    Text {
        id: txtPath
        text: qsTr("Path:")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txtResolution.bottom
        font.pixelSize: 12
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_height:100;anchors_width:100}
D{i:8;anchors_y:311}
}
 ##^##*/
