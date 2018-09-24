import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: stackViewBusyIndicator

    width: 200
    height: 200
    anchors.centerIn: parent
    radius: 3
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#66b3b3b3"
        }

        GradientStop {
            position: 1
            color: "#99808080"
        }
    }
    border.color: "#99cccccc"

    BusyIndicator {
        id: busyIndicator
        anchors.fill: parent
    }

}

/*##^## Designer {
    D{i:4;anchors_x:22;anchors_y:55}
}
 ##^##*/
