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
    property var canvasText
    property var currentSelectedItem: false
    property var itemFocus

    Column {
        id: contentCol; anchors.fill: parent
        Rectangle {width: spacerW; height: spacerH}
        AppText {id: titleText; width: parent.width; text: "Create and edit your moodboards here!"; horizontalAlignment: Text.AlignHCenter}
        Rectangle {id: spacerRect; width: spacerW; height: spacerH}
        Rectangle {
            scale: 0.96; width: spacerW; height: spacerW / 10 * 8
            AppPaper {id: canvas; anchors.fill: parent; background.color: canvasBG === undefined ? "white" :  canvasBG}
        }
    }

    FloatingActionButton {
        id: menuButton; anchors.right: undefined; visible: true; anchors.horizontalCenter: parent.horizontalCenter; icon: IconType.bars
        onClicked: {
            animation.start()
            colourPickerRect.visible === true ? colourPickerRect.visible = false : colourPickerRect.visible = true
            floatingButtonRow.visible === true ? floatingButtonRow.visible = false : floatingButtonRow.visible = true
        }
    }
    Row {
        id: floatingButtonRow; visible: false; width: parent.width; anchors.bottom: parent.bottom; spacing: dp(5)
        FloatingActionButton {
            visible: true; anchors.right: undefined; icon: IconType.image
            onClicked: imagePickerModal.open()
        }
        FloatingActionButton {
            visible: true; anchors.right: undefined; icon: IconType.font
            onClicked: InputDialog.inputTextSingleLine(app,
                                                       "Add Text", //message text
                                                       "",         //placeholder text
                                                       function(ok, text) {
                                                           if(ok) {
                                                               canvasText = text
                                                               var newObject = Qt.createQmlObject('import QtQuick 2.0;import QtQuick 2.12; import Felgo 3.0;        AppText {
        z: 15
        id: moodText
        text: canvasText
        color: "black"
        Rectangle {z:4; visible: moodText.focus === true || dragHandler3.active; width: parent.width * 1.2; height: parent.height*2; anchors.centerIn: parent; border.width: 5; border.color: "steelblue"; color: moodText.focus === true || dragHandler3.active ? "#354682B4" : "transparent"}
        PinchArea {
            MouseArea {
                onClicked: {
                    moodText.forceActiveFocus()
                }
                anchors.fill: parent
            }
            property var startpinchangle
            property var rotangle
            property var currentangle
            anchors.fill: parent
            onPinchStarted: {
                startpinchangle = pinch.angle
                rotangle = moodText.rotation
            }
            onPinchUpdated: {
                if (startpinchangle != null){
                    currentangle = rotangle - (pinch.angle - startpinchangle)
                    moodText.rotation = currentangle
                }
            }
            onPinchFinished:{
                console.log("Current angle: " + Math.abs(currentangle))
                if (Math.abs(currentangle) < 1 ||
                        Math.abs(Math.abs(currentangle) - 180) < 1){

                }
            }
        }
        Rectangle {z:5; visible: moodText.focus === true; width: dp(30); height: dp(30); color: "#354682B4"; anchors.verticalCenter:parent.bottom; anchors.horizontalCenter: parent.left;IconButton {anchors.fill: parent; icon: IconType.trash;onClicked: {moodText.destroy()}}}
        DragHandler {id: dragHandler3}}',
                                                                                                  studioPage,
                                                                                                  "");

                                                           }
                                                       })

        }
        FloatingActionButton {visible: true; anchors.right: undefined; icon: IconType.sliders}
    }

    Rectangle {
        id: colourPickerRect; visible: false; height: parent.height - ((spacerRect.height*2) + canvas.height + titleText.height); width: spacerH * 2; anchors.right: parent.right; anchors.bottom: parent.bottom; color: "transparent"
        Rectangle {
            z:2; anchors.fill: parent
            gradient: Gradient {
                GradientStop {position: 0.0; color: "white"}
                GradientStop {position: 0.2; color: "transparent"}
                GradientStop {position: 0.65; color: "transparent"}
                GradientStop {position: 1.0; color: "white"}
            }
        }

        AppFlickable {
            anchors.fill: parent; contentHeight: colourPickerCol.height
            Column {
                id: colourPickerCol; spacing: dp(10)
                Rectangle {height: spacerH; width: height; color: "transparent"}
                Repeater {
                    model: colourModel.length
                    Rectangle {
                        border.color: "black"; border.width: 2; height: spacerH; width: height; radius: width/2; color: colourModel[index]
                        MouseArea {anchors.fill: parent; onClicked: canvasBG = colourModel[index]}
                    }
                }
                Rectangle {height: spacerH*2; width: height; color: "transparent"}
            }
        }
        Rectangle {
            id: eyeDropperIconButton; z:3; height: width; width: parent.width; color: "white"; anchors.bottom: parent.bottom
            IconButton {icon: IconType.eyedropper; onClicked: colorDialog.visible = true}
        }
    }

    ColorDialog {
        id: colorDialog; title: "Please choose a color"
        onAccepted: {console.log("You chose: " + colorDialog.color); canvasBG = colorDialog.color; colorDialog.visible = false}
        onRejected: {console.log("Canceled"); colorDialog.visible = false}
        Component.onCompleted: visible = false
    }

    ParallelAnimation {
        id: animation
        NumberAnimation {target: floatingButtonRow; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}
        NumberAnimation {target: colourPickerCol; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}
        NumberAnimation {target: eyeDropperIconButton; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}
    }

    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker; title: "CHOOSE IMAGE"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16)
                    onClicked: {
                        var newObject = Qt.createQmlObject('import QtQuick 2.0; import QtQuick 2.12; import Felgo 3.0;     AppImage {z:5; id: moodImage2; parent: canvas; fillMode: Image.PreserveAspectFit; autoTransform: true; source: imagePath; width: studioPage.width/ 2
        Rectangle {z:4; visible: moodImage2.focus === true || dragHandler2.active; anchors.fill: parent; border.width: 5; border.color: "steelblue"; color: moodImage2.focus === true || dragHandler2.active ? "#354682B4" : "transparent"}
        PinchArea {
            MouseArea {
                onClicked: {
                    moodImage2.forceActiveFocus()
                }
                anchors.fill: parent
            }
            property var startpinchangle
            property var rotangle
            property var currentangle
            anchors.fill: parent
            onPinchStarted: {
                startpinchangle = pinch.angle
                rotangle = moodImage2.rotation
            }
            onPinchUpdated: {
                if (startpinchangle != null){
                    currentangle = rotangle - (pinch.angle - startpinchangle)
                    moodImage2.rotation = currentangle
                }
            }
            onPinchFinished:{
                console.log("Current angle: " + Math.abs(currentangle))
                if (Math.abs(currentangle) < 1 ||
                        Math.abs(Math.abs(currentangle) - 180) < 1){

                }
            }
        }

        Rectangle {z:5;visible: moodImage2.focus === true;width: dp(30);height: dp(30);color: "#354682B4";anchors.verticalCenter:parent.top;anchors.horizontalCenter: parent.left;IconButton {anchors.fill: parent ; icon: IconType.expand ; rotation: 90 }
            MouseArea {
                anchors.fill: parent;
                drag{
                    target: parent;
                    axis: Drag.XAndYAxis
                }
                onPositionChanged: {
                    if(drag.active){var delta = Math.max(mouseX, mouseY);
                        var newWidth = moodImage2.width - delta;var newHeight = moodImage2.height - delta;if (newWidth < width || newHeight < height)return;moodImage2.width = newWidth;moodImage2.x = moodImage2.x + delta;moodImage2.height = newHeight;moodImage2.y = moodImage2.y + delta}}}}
        Rectangle {z:5; visible: moodImage2.focus === true; width: dp(30); height: dp(30); color: "#354682B4"; anchors.verticalCenter:parent.bottom; anchors.horizontalCenter: parent.left;IconButton {anchors.fill: parent; icon: IconType.trash; onClicked: {moodImage2.destroy()}}}
        Rectangle {z:5; visible: moodImage2.focus === true; width: dp(30); height: dp(30); color: "#354682B4"; anchors.verticalCenter:parent.bottom; anchors.horizontalCenter: parent.right;IconButton {anchors.fill: parent;icon: IconType.edit}}
        DragHandler {id: dragHandler2}}
 ',
                                                           studioPage,
                                                           "dynamicSnippet");
                        imagePickerModal.close()
                    }
                }
            }
        }
    }
}
