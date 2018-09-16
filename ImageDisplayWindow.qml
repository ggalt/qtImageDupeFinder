import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    width: 1920
    height: 1080
    color: "lightgrey"

    property int numRows: 0
    property int numColumns: 0

    function(itemCount) {
        var sqrt_items = Math.sqrt(itemCount)
        numRows = sqrt_items/1.618
        numColumns = sqrt_items * 1.618
        console.log("Rows:",numRows,"Columns:",numColumns)
    }

}
