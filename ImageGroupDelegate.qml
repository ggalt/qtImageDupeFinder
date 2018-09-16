import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: imageGroupDelegate
    width: parent.width
    height: 60

    function setChildrenState(newState) {
        for( var i = 0; i < children.lenght; i++ ) {
            children[i].state = newState;
        }
        imageRectangle.state = newState;
        countRectangle.state = newState;
        nameRectangle.state = newState;
    }

    function listImagePaths() {
        var imageCountVal = imageListModel.getCurImageListCount(index)
        for(var i = 0; i < imageCountVal; i++) {
            console.log(imageListModel.getImage(i))
        }
    }

    state: "normal"

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#00000000"
        }

        GradientStop {
            position: 1
            color: "#4ccecdcd"
        }
    }


    EdgedButton{
        id: imageRectangle
        width: 60
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
    }

    EdgedButton {
        id: countRectangle
        width: 60
        anchors.top: parent.top
        anchors.left: imageRectangle.right
        anchors.bottom: parent.bottom

        Text {
            id: imageCountText
            x: 123
            y: 23
            color: "#ffffff"
            text: imageListModel.getCurImageListCount(index)
//            text: index
            font.pointSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    EdgedButton {
        id: nameRectangle
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: countRectangle.right
        anchors.bottom: parent.bottom

        Text {
            id: imageNameText
            x: 123
            y: 23
            color: "#ffffff"
            text: imageListModel.getImageFileName(index)
            font.pointSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        onReleased: {
            imageGroupDelegate.setChildrenState( "Default" )
            listImagePaths()
//            console.log(index, "Released")
//            thermoEventListDelegate.ListView.view.currentIndex=index
        }
        onPressed: {
            imageGroupDelegate.setChildrenState( "Pressed" )
            console.log(index, "Pressed")
            //            thermoEventListDelegate.ListView.view.currentIndex=index
        }
    }


    states: [
        State {
            name: "normal"
            //            when: !thermoEventListDelegate.ListView.isCurrentItem
            //            PropertyChanges {
            //                target: thermoEventListDelegate
            //                border.width: 1
            //                border.color: "#ccffffff"
            //            }
        },
        State {
            name: "selected"
            //            when: thermoEventListDelegate.ListView.isCurrentItem
            //            PropertyChanges {
            //                target: thermoEventListDelegate
            //                border.width: 4
            //                border.color: "yellow"
            //            }

            //            PropertyChanges {
            //                target: gradientStop1
            //                color: "#4cccff00"
            //            }
        }
    ]
}
