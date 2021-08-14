import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: canvas

    Rectangle {
        id: frameBase; width: parent.width; height: width; anchors.centerIn: parent; color: canvasBG === undefined ? "#cccccc" :  canvasBG
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
    }
    Column {
        AppSlider {id: slider; from: 0; to: 1; onMoved: rect1Scale = slider.position}
        AppText {anchors.horizontalCenter: parent.horizontalCenter; text: "Selected Size: "+Math.round(slider.position * 100) / 100}
    }
}
