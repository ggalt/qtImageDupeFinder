import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: imageDisplayWindow
    objectName: 'imageDisplayWindow'
    anchors.fill: parent
    color: "lightgrey"

//    property int numRows: 1
//    property int numColumns: 3
//    property int colSpacing: 3
//    property int photoCount: 15
//    property int imageWidth: 0
//    property int imageHeight: 0

//    function spreadRows(itemCount) {
//        photoCount = itemCount
//        var sqrt_items = Math.sqrt(itemCount)
//        numRows = sqrt_items/1.618
//        numColumns = sqrt_items * 1.618
//        colSpacing = 3
//        imageWidth = imageDisplayWindow.width / numColumns - colSpacing
//        imageHeight = imageDisplayWindow.height / numRows - colSpacing
//        if(imageWidth > imageHeight)
//            imageWidth = imageHeight
//        else
//            imageHeight = imageWidth
//        console.log("Rows:",numRows,"Columns:",numColumns)
//    }

    Grid {
        anchors.fill: parent
        columns: appWindow.numColumns
        spacing: appWindow.colSpacing
        topPadding: appWindow.gridTopPadding
        bottomPadding: appWindow.gridBottomPadding

        Repeater {
            id:gridRepeater
            model: appWindow.photoCount
            delegate:Rectangle {
                width: appWindow.imageWidth
                height: appWindow.imageHeight
                Switch {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.topMargin: 2
                    id: deleteSwitch
                    text: qsTr("Delete Image")
                }

                Text {
                    id: txtFileName
                    text: qsTr("Filename:"+appWindow.getFileName(index))
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottom: txtResolution.top
                    anchors.bottomMargin: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 12
                }

                Text {
                    id: txtResolution
                    text: qsTr("Resolution:")
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottom: txtPath.top
                    anchors.bottomMargin: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 12
                }

                Text {
                    id: txtPath
                    text: qsTr("Path:"+appWindow.getFilePath(index))
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    font.pixelSize: 12
                }
                Image {
                    id: image
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.bottom: txtFileName.top
                    anchors.bottomMargin: 2
                    width: image.height

                    autoTransform: true
                    fillMode: Image.PreserveAspectFit

                    anchors.horizontalCenter: parent.horizontalCenter
                    source: getFileSource(index)
//                    source: "qrc:/DSC_0053.JPG"

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                    }
                }
            }

        }
    }

    //    Button {
    //        id: button
    //        x: 666
    //        y: 607
    //        text: qsTr("Button")
    //        onPressed: spreadRows(15)
    //    }

    //    Button {
    //        id: closeBtn
    //        x: 1070
    //        y: 785
    //        text: qsTr("Close")
    //        onPressed: appWindow.closeImageDisplayWindow()
    //    }

}
