import QtQuick 2.0
import Felgo 3.0
import "../CanvasTemplates"

Page {
      id: imagePickerPage
      ImagePicker {
        id: imagePicker; columns: 2; anchors.fill: parent; maximumNumberOfSelection: 1;
        onSelectionChanged: if(selectedCount === 1){selection = undefined}
        onSelectedCountChanged: {console.log("SELECTION: " +selection);imagePath = selection.toString(); imagePathID = selection.toString(); console.log("imagePath: " +imagePath); console.log(selectedCount); if(selectedCount === 0) {imagePath = "undefined" }}
      }
    }
