import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: canvas
    Rectangle {
        id: frameBase; width: parent.width; height: width; anchors.centerIn: parent; color: canvasBG === undefined ? "#cccccc" :  canvasBG
        Column {
            anchors.fill: parent
            Row {
                width: parent.width; height: parent.height / 2
                Rectangle {
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect1Scale; border.width: currentRect === "rect1" ? dp(5) : 0; border.color: "steelblue";
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
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect2Scale; border.width: currentRect === "rect2" ? dp(5) : 0; border.color: "steelblue";
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
                Rectangle {
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect3Scale; border.width: currentRect === "rect3" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect3" ? 0.5 : 0}
                    AppImage {z: 1; id: rect3Img; source: rect3Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect3"){currentRect = "none"}
                        else {currentRect = "rect3"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect3"}
                    }
                }
            }
            Row {
                width: parent.width; height: parent.height / 2
                Rectangle {
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect4Scale; border.width: currentRect === "rect4" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect4" ? 0.5 : 0}
                    AppImage {z: 1; id: rect4Img; source: rect4Imgsource;anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect4"){currentRect = "none"}
                        else {currentRect = "rect4"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect4"}
                    }
                }
                Rectangle {
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect5Scale; border.width: currentRect === "rect5" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect5" ? 0.5 : 0}
                    AppImage {z: 1; id: rect5Img; source: rect5Imgsource;anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect5"){currentRect = "none"}
                        else {currentRect = "rect5"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect5"}
                    }
                }
                Rectangle {
                    height: parent.height; width: parent.width/3; color: "white"; scale: rect6Scale; border.width: currentRect === "rect6" ? dp(5) : 0; border.color: "steelblue";
                    Rectangle{z: 2; anchors.fill: parent; color: "steelblue"; opacity: currentRect === "rect6" ? 0.5 : 0}
                    AppImage {z: 1; id: rect6Img; source: rect6Imgsource;anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect6"){currentRect = "none"}
                        else {currentRect = "rect6"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        z: 3; icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect6"}
                    }
                }


            }
        }
    }
}
