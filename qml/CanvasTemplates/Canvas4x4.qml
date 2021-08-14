import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: canvas

    property var rect1Scale: 0.9
    property var rect2Scale: 0.9
    property var rect3Scale: 0.9
    property var rect4Scale: 0.9

    Rectangle {
        id: frameBase; width: parent.width; height: width; anchors.centerIn: parent; color: canvasBG === undefined ? "#cccccc" :  canvasBG
        Column {
            anchors.fill: parent
            Row {
                width: parent.width; height: parent.height / 2
                Rectangle {
                    height: parent.height; width: height; color: "white"; scale: rect1Scale; border.width: currentRect === "rect1" ? dp(5) : 0; border.color: "steelblue";
                    AppImage {id: rect1Img; source: rect1Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentRect === "rect1"){currentRect = "none"}
                            else {currentRect = "rect1"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect1"}
                    }
                }
                Rectangle {
                    height: parent.height; width: height; color: "white"; scale: rect2Scale; border.width: currentRect === "rect2" ? dp(5) : 0; border.color: "steelblue";
                    AppImage {id: rect2Img; source: rect2Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentRect === "rect2"){currentRect = "none"}
                            else {currentRect = "rect2"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        icon: IconType.edit; anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect2"}
                    }
                }
            }
            Row {
                width: parent.width; height: parent.height / 2
                Rectangle {
                    height: parent.height; width: height; color: "white"; scale: rect3Scale; border.width: currentRect === "rect3" ? dp(5) : 0; border.color: "steelblue";
                    AppImage {id: rect3Img; source: rect3Imgsource; anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect3"){currentRect = "none"}
                        else {currentRect = "rect3"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        icon: IconType.edit
                        anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect3"}
                    }
                }
                Rectangle {
                    height: parent.height; width: height; color: "white"; scale: rect4Scale; border.width: currentRect === "rect4" ? dp(5) : 0; border.color: "steelblue";
                    MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(currentRect === "rect4"){currentRect = "none"}
                        else {currentRect = "rect4"; slider.value = parent.scale}
                        }
                    }
                    IconButton {
                        icon: IconType.edit
                        anchors.bottom: parent.bottom; anchors.right: parent.right
                        onClicked: {imagePickerModal.open(); currentRect = "rect4"}
                    }
                    AppImage {id: rect4Img; source: rect4Imgsource;anchors.fill: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectCrop}
                }
            }
        }
    }
    Column {
        AppSlider {
            id: slider; from: 0; to: 1
            onMoved: {
                if(currentRect === "rect1") {rect1Scale = slider.position}
                else if(currentRect === "rect2") {rect2Scale = slider.position}
                else if(currentRect === "rect3") {rect3Scale = slider.position}
                else if(currentRect === "rect4") {rect4Scale = slider.position}
            }
        }
        AppText {anchors.horizontalCenter: parent.horizontalCenter; text: "Position: "+Math.round(slider.position * 10) / 10}
        AppText {anchors.horizontalCenter: parent.horizontalCenter; text: "Current Selection: " + currentRect}
    }
}
