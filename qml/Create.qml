import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0
import Felgo 3.0
import "Components"

Page {
    id: studioPage

    title: "Studio"

    readonly property real spacerW: studioPage.width
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    property var colourModel: ["black",  "#595959", "#7f7f7f","#a5a5a5", "#cccccc", "#f2f2f2", "white", "#f94144", "#f3722c", "#f8961e", "#f9844a","#f9c74f", "#90be6d", "#43aa8b", "#4d908e","#577590", "#277da1", "#777da7", "#e7cee3"]


    //canvas variables
    property var canvasBG


    Column {
        id: contentCol
        anchors.fill: parent

        Rectangle {width: spacerW; height: spacerH}

        AppText {
            id: titleText
            width: parent.width
            text: "Create and edit your moodboards here!"
            horizontalAlignment: Text.AlignHCenter
        }
        Rectangle {
            id: spacerRect
            width: spacerW
            height: spacerH
        }
        Rectangle {
            scale: 0.96
            width: spacerW
            height: spacerW / 10 * 8
            AppPaper {
                id: canvas
                anchors.fill: parent
                background.color: canvasBG
            }
        }
    }

    FloatingActionButton {
        id: menuButton
        anchors.right: undefined
        anchors.horizontalCenter: parent.horizontalCenter
        icon: IconType.bars
        onClicked: {
            animation.start()
            colourPickerRect.visible === true ? colourPickerRect.visible = false : colourPickerRect.visible = true
            floatingButtonRow.visible === true ? floatingButtonRow.visible = false : floatingButtonRow.visible = true

        }
    }
    Row {
        id: floatingButtonRow
        visible: false
        width: parent.width
        anchors.bottom: parent.bottom
        spacing: dp(5)
        FloatingActionButton {
            visible: true
            anchors.right: undefined
            icon: IconType.image
            onClicked: imagePickerModal.open()
        }
        FloatingActionButton {
            visible: true
            anchors.right: undefined
            icon: IconType.font
        }
        FloatingActionButton {
            visible: true
            anchors.right: undefined
            icon: IconType.sliders
        }
    }

    Rectangle {
        id: colourPickerRect
        visible: false
        height: parent.height - ((spacerRect.height*2) + canvas.height + titleText.height)
        width: spacerH * 2
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "transparent"
        Rectangle {
            z:2
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {position: 0.0; color: "white"}
                GradientStop {position: 0.2; color: "transparent"}
                GradientStop {position: 0.65; color: "transparent"}
                GradientStop {position: 1.0; color: "white"}
            }
        }

        AppFlickable {
            anchors.fill: parent
            contentHeight: colourPickerCol.height
            Column {
                id: colourPickerCol
                spacing: dp(10)
                Rectangle {
                    height: spacerH
                    width: height
                    color: "transparent"
                }
                Repeater {
                    model: colourModel.length
                    Rectangle {
                        border.color: "black"
                        border.width: 2
                        height: spacerH
                        width: height
                        radius: width/2
                        color: colourModel[index]
                        MouseArea {
                            anchors.fill: parent
                            onClicked: canvasBG = colourModel[index]
                        }
                    }
                }
                Rectangle {
                    height: spacerH*2
                    width: height
                    color: "transparent"
                }
            }
        }
        Rectangle {
            id: eyeDropperIconButton
            z:3
            height: width
            width: parent.width
            color: "white"
            anchors.bottom: parent.bottom
            IconButton {
                icon: IconType.eyedropper
                onClicked: colorDialog.visible = true
            }
        }
    }

    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            console.log("You chose: " + colorDialog.color)
            canvasBG = colorDialog.color
            colorDialog.visible = false
        }
        onRejected: {
            console.log("Canceled")
            colorDialog.visible = false
        }
        Component.onCompleted: visible = false
    }

    ParallelAnimation {
        id: animation
        NumberAnimation {
            target: floatingButtonRow
            property: "scale"
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InOutBack
        }
        NumberAnimation {
            target: colourPickerCol
            property: "scale"
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InOutBack
        }
        NumberAnimation {
            target: eyeDropperIconButton
            property: "scale"
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InOutBack
        }
    }

    AppModal {
        id: imagePickerModal
        fullscreen: true
        pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker
                title: "CHOOSE IMAGE"
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: {
                        var newObject = Qt.createQmlObject('import QtQuick 2.0; import QtQuick 2.12; Rectangle {width: 640;height: 360;color: "transparent";
        Flickable {id: flick;anchors.fill: parent;contentWidth: 500;contentHeight: 500;
            PinchArea {id: pinchArea;width: Math.max(flick.contentWidth, flick.width);height: Math.max(flick.contentHeight, flick.height)
                property real initialWidth; property real initialHeight;
                onPinchStarted: {initialWidth = flick.contentWidth;initialHeight = flick.contentHeight;}
                onPinchUpdated: {/*adjust content pos due to drag*/flick.contentX += pinch.previousCenter.x - pinch.center.x;flick.contentY += pinch.previousCenter.y - pinch.center.y;/* resize content*/flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)}
                onPinchFinished: {/* Move its content within bounds.*/flick.returnToBounds()}
                Rectangle {width: flick.contentWidth; height: flick.contentHeight; color: "white"
                    Image {fillMode: Image.PreserveAspectFit; anchors.fill: parent; source: imagePath
                        Rectangle {anchors.fill: parent; color: "transparent"; border.color: dragHandler.active ? "black" : "transparent"; border.width: dragHandler.active ? 3 : 0}
                        MouseArea {anchors.fill: parent; onDoubleClicked: {flick.contentWidth = 500; flick.contentHeight = 500}}
                    }
                }
                DragHandler { id: dragHandler }
            }
        }
    } ',
                                                           studioPage,
                                                           "dynamicSnippet");
                        imagePickerModal.close()
                    }
                }
            }
        }
    }
}
