import QtQuick 2.0
import Felgo 3.0

Page {
      id: imagePickerPage
      ImagePicker {
        id: imagePicker
        columns: 2
        anchors.fill: parent
        maximumNumberOfSelection: 1
        onSelectedCountChanged: {
            console.log("SELECTION: " +selection);
            imagePath = selection.toString()
            imagePathID = selection.toString()

            console.log("imagePath: " +imagePath)
        }
      }
    }
