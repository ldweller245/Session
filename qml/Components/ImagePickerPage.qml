import QtQuick 2.0
import Felgo 3.0
import "../CanvasTemplates"

Page {
    id: imagePickerPage

    property var selectionArray: []

    ImagePicker {
        id: imagePicker; columns: 2; anchors.fill: parent; maximumNumberOfSelection: 1;
        onSelectionChanged: selectionArray.length === 1 ? selectionArray = [] && selectionArray.push(selection.toString()) : selectionArray.push(selection.toString())
        onSelectedCountChanged: {imagePath = selection.toString(); imagePathID = selection.toString(); if(selectedCount === 0) {imagePath = undefined }}
    }
}
