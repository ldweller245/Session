import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: canvas
    Rectangle {
        id: frameBase; width: parent.width; height: parent.height; anchors.centerIn: parent; color: canvasBG === undefined ? "#cccccc" :  canvasBG
        Column {
            anchors.fill: parent
                Rectangle {
                    height: (parent.height/3)*2; width: parent.width; color: "white"; scale: rect1Scale; border.width: currentRect === "rect1" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect1" ? 0.5 : 0}
                    AppImage {z: 1;id: rect1Img; source: rect1Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentRect === "rect1"){currentRect = "none"}
                            else {currentRect = "rect1"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect1"}
                    }
                }
                Rectangle {
                    height: (parent.height/3); width: parent.width; color: "white"; scale: rect2Scale; border.width: currentRect === "rect2" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect2" ? 0.5 : 0}
                    AppImage {z: 1; id: rect2Img; source: rect2Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentRect === "rect2"){currentRect = "none"}
                            else {currentRect = "rect2"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect2"}
                    }
                }

        }
    }
}
