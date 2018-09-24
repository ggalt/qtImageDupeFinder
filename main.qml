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
    property int numColumns: 1
    property int colSpacing: 3
    property int photoCount: 1
    property int imageWidth: 0
    property int imageHeight: 0
    property int gridTopPadding: 0
    property int gridBottomPadding: 0

    function setupGrid(gridHeight, gridWidth) {
        photoCount = imageListModel.getCurImageListCount(currentItemSelected)
        var rowCount = 1
        while(rowCount < photoCount) {
            var displayBoxWidth = (gridWidth * rowCount)/ photoCount
            if(gridHeight - (displayBoxWidth *rowCount ) < displayBoxWidth) {
                numRows = rowCount
                numColumns = (photoCount / numRows) + (photoCount % numRows)
                imageWidth = gridWidth / numColumns - colSpacing
                imageHeight = gridHeight / numRows - colSpacing
                if(imageWidth > imageHeight)
                    imageWidth = imageHeight
                else
                    imageHeight = imageWidth
                gridTopPadding = gridBottomPadding = (gridHeight - (imageHeight * numRows)) / 2
                return
            }
            rowCount++
        }
    }


    ////////////////////////////////////////////////

    function showBusyIndicator(isTrue) {
//        busyIndicator.running = isTrue
        if(isTrue) {
            stackView.push("qrc:/StackViewBusyIndicator.qml")
        }
        console.log("Busy Indicator is:",isTrue)
    }


    function imageLineClicked() {
        setupGrid(appWindow.height-toolBar.height, appWindow.width)
//        setupGrid(imageListModel.getCurImageListCount(currentItemSelected), appWindow.height-toolBar.height, appWindow.width)
//        spreadRows(imageListModel.getCurImageListCount(currentItemSelected))
        console.log("Setup Grid:", photoCount, numColumns, numRows)
        stackView.push("qrc:ImageDisplayWindow.qml")
        showBusyIndicator(false)
    }

    function listImagePaths() {
        var imageCountVal = imageListModel.getCurImageListCount(currentItemSelected)
        showBusyIndicator(true)
//        for(var i = 0; i < imageCountVal; i++) {
//            console.log(imageListModel.getImage(i))
//        }
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

    function getFilePath(pos) {
        return imageListModel.getImagePath(currentItemSelected, pos)
    }

    function getFileSource(pos) {
        return imageListModel.getImageSource(currentItemSelected, pos)
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


    BusyIndicator {
        id: busyIndicator
//        anchors.centerIn: parent
        running: false
    }

    StackView {
        id: stackView
        z: -1
        anchors.fill: parent

        initialItem:     ScrollView {
            id: scrollView
//            x:0
//            y:0
//            width: parent.width
//            height: parent.height
            clip: true


            ListView {
                id: mainListView
                width: parent.width
                model: imageListModel
//                highlight: imgDelegate.highlightBar
                highlightFollowsCurrentItem: false
                focus: true
                currentIndex: 2
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
