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
    }

    EdgedButton {
        id: nameRectangle
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: countRectangle.right
        anchors.bottom: parent.bottom
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        onReleased: {
            imageGroupDelegate.setChildrenState( "Default" )
            console.log(index, "Released")
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

    state: "normal"
}
