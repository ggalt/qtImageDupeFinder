import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import Qt.labs.settings 1.0

ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    width: 1920
    height: 1080
    visible: true
    title: "Duplicate Image Finder"

    property int currentItemSelected

    ////////////////////////////////////////////////
    // properties and functions for ImageDisplayWindow
    property int numRows: 1
    property int numColumns: 3
    property int colSpacing: 3
    property int photoCount: 15
    property int imageWidth: 0
    property int imageHeight: 0

    function setupGrid(itemCount, gridHeight, gridWidth) {
        photoCount = itemCount
        var rowCount = 1
        while(rowCount < itemCount) {
            var displayBoxWidth = (gridWidth * rowCount)/ itemCount
            if(gridHeight - (displayBoxWidth *rowCount ) < displayBoxWidth) {
                numRows = rowCount
                numColumns = (photoCount / numRows) + (photoCount % numRows)
                imageWidth = gridWidth / numColumns - colSpacing
                imageHeight = gridHeight / numRows - colSpacing
                if(imageWidth > imageHeight)
                    imageWidth = imageHeight
                else
                    imageHeight = imageWidth
                console.log("Rows:",numRows,"Columns:",numColumns)
                return
            }
            rowCount++
        }
    }


    function spreadRows(itemCount) {
        photoCount = itemCount
        var sqrt_items = Math.sqrt(itemCount)
        numRows = sqrt_items/1.618
        numColumns = sqrt_items * 1.618
        console.log("Rows:",numRows,"Columns:",numColumns)
        numRows = numRows<=0 ? 1 : numRows
        numColumns = numColumns<=0 ? 1 : numColumns
        numRows = 1
        numColumns = 3
        colSpacing = 3
        imageWidth = width / numColumns - colSpacing
        imageHeight = height / numRows - colSpacing
        if(imageWidth > imageHeight)
            imageWidth = imageHeight
        else
            imageHeight = imageWidth
        console.log("Rows:",numRows,"Columns:",numColumns)
    }

    ////////////////////////////////////////////////


    function imageLineClicked() {
        setupGrid(8, appWindow.height-toolBar.height, appWindow.width)
//        setupGrid(imageListModel.getCurImageListCount(currentItemSelected), appWindow.height-toolBar.height, appWindow.width)
//        spreadRows(imageListModel.getCurImageListCount(currentItemSelected))
        console.log("Setup Grid:", photoCount, numColumns, numRows)
        stackView.push("qrc:ImageDisplayWindow.qml")
    }

    function listImagePaths() {
        var imageCountVal = imageListModel.getCurImageListCount(currentItemSelected)
        for(var i = 0; i < imageCountVal; i++) {
            console.log(imageListModel.getImage(i))
        }
    }

    function closeImageDisplayWindow() {
        if(stackView.depth > 1)
            stackView.pop()
    }

    function getCurrentListIndex() {
        return imageListModel.currentIndex
    }

    function getFileName(pos) {
        return imageListModel.getImageFileName(currentItemSelected, pos)
    }

    Settings {
        id: settings
        property string style: "Default"
    }

    Shortcut {
        sequences: ["Esc", "Back"]
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            mainListView.currentIndex = -1
        }
    }

    Shortcut {
        sequence: "Menu"
        onActivated: optionsMenu.open()
    }

    header: ToolBar {
        id: toolBar
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                icon.name: stackView.depth > 1 ? "back" : "drawer"
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        mainListView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                id: titleLabel
                text: "TEXT"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                icon.name: "menu"
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Settings"
                        onTriggered: settingsDialog.open()
                    }
                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }


    StackView {
        id: stackView
        anchors.fill: parent

        initialItem:     ScrollView {
            id: scrollView
            x:0
            y:0
            width: parent.width
            height: parent.height
            clip: true

            //            Component {
            //                id: itemHighlight
            //                Rectangle {
            //                    width: parent.width
            //                    height: 100
            //                    color: "lightsteelblue"; radius: 5
            //                    opacity: 0.40
            //                    y: mainListView.currentItem.y
            //                    Behavior on y {
            //                        SpringAnimation {
            //                            spring: 3
            //                            damping: 0.2
            //                        }
            //                    }
            //                }
            //            }

            ListView {
                id: mainListView
                width: parent.width
                model: imageListModel
                highlight: Rectangle {
                    color: "#66808080"
                    border.color: "black"
                    anchors.fill: parent
                }
                highlightFollowsCurrentItem: true
                focus: true

                delegate: ImageGroupDelegate{}
            }
        }

    }

    Dialog {
        id: settingsDialog
        x: Math.round((appWindow.width - width) / 2)
        y: Math.round(appWindow.height / 6)
        width: Math.round(Math.min(appWindow.width, appWindow.height) / 3 * 2)
        modal: true
        focus: true
        title: "Settings"

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            settings.style = styleBox.displayText
            settingsDialog.close()
        }
        onRejected: {
            styleBox.currentIndex = styleBox.styleIndex
            settingsDialog.close()
        }

        contentItem: ColumnLayout {
            id: settingsColumn
            spacing: 20

            RowLayout {
                spacing: 10

                Label {
                    text: "Style:"
                }

                ComboBox {
                    id: styleBox
                    property int styleIndex: -1
                    model: availableStyles
                    Component.onCompleted: {
                        styleIndex = find(settings.style, Qt.MatchFixedString)
                        if (styleIndex !== -1)
                            currentIndex = styleIndex
                    }
                    Layout.fillWidth: true
                }
            }

            Label {
                text: "Restart required"
                color: "#e41e25"
                opacity: styleBox.currentIndex !== styleBox.styleIndex ? 1.0 : 0.0
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (appWindow.width - width) / 2
        y: appWindow.height / 6
        width: Math.min(appWindow.width, appWindow.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "The Qt Quick Controls 2 module delivers the next generation user interface controls based on Qt Quick."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "In comparison to the desktop-oriented Qt Quick Controls 1, Qt Quick Controls 2 "
                      + "are an order of magnitude simpler, lighter and faster, and are primarily targeted "
                      + "towards embedded and mobile platforms."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}


/*##^## Designer {
    D{i:25;anchors_height:200;anchors_width:200}
}
 ##^##*/
