import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: edgedButton
    state: "Default"
    property color gradientTop: "#80565656"     //"#4c3d3d3d"
    property color gradientBottom: "#80b6b6b6"  //"#4ccecdcd"
    property color topLineColor: "dimgray"// "#cfcfcf"
    property color bottomLineColor: "dimgray"// "#525252"
    property color leftLineColor: "dimgray"// "#bdbdbd"
    property color rightLineColor: "dimgray"// "#bdbdbd"

    property color tlColor: topLineColor
    property color blColor: bottomLineColor
    property color llColor: leftLineColor
    property color rlColor: rightLineColor
    border.width: 1
    border.color: "#00000000"

    states: [
        State {
            name: "Default"
            PropertyChanges {
                target: edgedButton
                gradient: defaultGradient
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: edgedButton
                gradient: pressedGradient
            }
        },
        State {
            name: "Disabled"
        }
    ]

    Gradient {
        id: defaultGradient
        GradientStop {
            position: 0
            color: gradientTop
        }

        GradientStop {
            position: 1
            color: gradientBottom
        }
    }

    Gradient {
        id: pressedGradient
        GradientStop {
            position: 0
            color: gradientBottom
        }

        GradientStop {
            position: 1
            color: gradientBottom
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            edgedButton.state = "Pressed"
            console.log("Pressed")
        }
        onReleased: {
            edgedButton.state = "Default"
            console.log("released")
        }
    }

    onStateChanged: {
        if(state == "Pressed") {
            llColor = "#0000000"
            rlColor = "#0000000"
            tlColor = "#0000000"
            blColor = "#0000000"
        } else {
            llColor = leftLineColor
            rlColor = rightLineColor
            tlColor = topLineColor
            blColor = bottomLineColor
        }
        drawingCanvas.requestPaint()
    }

    Canvas {
        id: drawingCanvas
        anchors.fill: parent
        onPaint: {
                var ctx = getContext("2d")
                ctx.beginPath()
                ctx.moveTo(0,0)
                ctx.strokeStyle = llColor   // middle grey
                ctx.lineTo(0,parent.height)
                ctx.strokeStyle = blColor // dark grey
                ctx.lineTo(parent.width, parent.height)
                ctx.strokeStyle = rlColor   // middle grey
                ctx.lineTo(parent.width,0)
                ctx.strokeStyle = tlColor // light grey
                ctx.lineTo(0,0)
                ctx.stroke()
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
