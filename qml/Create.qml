import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.9
import Felgo 3.0
import "Components"
import "CanvasTemplates"
Page {
    id: studioPage

    title: "Studio"
    //backgroundColor: "#242526"

    readonly property real imageFolderPath: FileUtils.PicturesLocation

    readonly property real spacerW: studioPage.width
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    property var colourModel: ["black",  "#595959", "#7f7f7f","#a5a5a5", "#cccccc", "#f2f2f2", "white", "#f94144", "#f3722c", "#f8961e", "#f9844a","#f9c74f", "#90be6d", "#43aa8b", "#4d908e","#577590", "#277da1", "#777da7", "#e7cee3"]
    property var canvasIcons: ["../assets/CanvasIcons/1x1.png", "../assets/CanvasIcons/2x2.png", "../assets/CanvasIcons/2x2_1.png", "../assets/CanvasIcons/2x2_2.png", "../assets/CanvasIcons/2x2_3.png", "../assets/CanvasIcons/2x2_4.png", "../assets/CanvasIcons/2x2_5.png", "../assets/CanvasIcons/3x1.png", "../assets/CanvasIcons/3x1_1.png", "../assets/CanvasIcons/3x2.png", "../assets/CanvasIcons/3x2_1.png", "../assets/CanvasIcons/3x2_2.png", "../assets/CanvasIcons/3x3.png", "../assets/CanvasIcons/4x4.png", "../assets/CanvasIcons/4x4_1.png", "../assets/CanvasIcons/4x4_2.png", "../assets/CanvasIcons/5x5.png", "../assets/CanvasIcons/5x5_1.png", "../assets/CanvasIcons/6x6_1.png", "../assets/CanvasIcons/6x6_2.png", ]

    //canvas variables
    property var canvasBG
    property var canvasText
    property var currentSelectedItem: false
    property var itemFocus

    property int canvasIndex: 0

    rightBarItem: IconButtonBarItem {icon: IconType.save; onClicked: {printCanvas.grabToImage(function(result){console.debug("result: " + result); result.saveToFile("content://media/external/images/media/"+Date.now()+".png")}); console.debug("saved")}}

    Column {
        id: contentCol; anchors.fill: parent
        Rectangle {id: spacerRect; width: spacerW; height: spacerH; color: "transparent"}
        Rectangle {
            scale: 0.96; width: spacerW; height: spacerW + spacerW/5
            AppPaper {
                id: canvas; anchors.fill: parent; background.color: canvasBG === undefined ? "#cccccc" :  canvasBG
                Canvas {
                    id: printCanvas; anchors.fill: parent; renderTarget: Canvas.Image
                    Loader {id: loaderCanvas; anchors.fill: parent ;source: "../qml/CanvasTemplates/Canvas1x1.qml"}
                }
                AlphaVideo {id: mediaplayer; loops: 1; source: "../assets/CanvasTransitionAlpha.mp4"; visible: mediaplayer.playbackState == MediaPlayer.PlayingState ? true : false; anchors.fill: parent; fillMode: VideoOutput.Stretch}
            }
        }
    }
    Column {
        width: parent.width; anchors.bottom: parent.bottom; bottomPadding: dp(10)
        Row {
            id: sliderRow; height: dp(Theme.navigationBar.height); width: parent.width; visible: currentRect !== "none" ? true : false; opacity: currentRect !== "none" ? true : false
            Rectangle {height: parent.height; width: height/2; color: "transparent"}
            AppText {text: "Scale: "+Math.round(slider.position * 100) / 100}
            AppSlider {
                id: slider; from: 0; to: 1
                onMoved: {
                    if(currentRect === "rect1") {rect1Scale = slider.position}
                    else if(currentRect === "rect2") {rect2Scale = slider.position}
                    else if(currentRect === "rect3") {rect3Scale = slider.position}
                    else if(currentRect === "rect4") {rect4Scale = slider.position}
                    else if(currentRect === "rect5") {rect5Scale = slider.position}
                    else if(currentRect === "rect6") {rect6Scale = slider.position}
                    else if(currentRect === "rect7") {rect7Scale = slider.position}
                    else if(currentRect === "rect8") {rect8Scale = slider.position}
                    else if(currentRect === "rect9") {rect9Scale = slider.position}
                    else if(currentRect === "rect10") {rect10Scale = slider.position}
                    else if(currentRect === "rect11") {rect11Scale = slider.position}
                    else if(currentRect === "rect12") {rect12Scale = slider.position}
                }
            }
            Behavior on opacity {NumberAnimation {duration: 1000; easing.type: Easing.InOutBack}}
        }
        Rectangle {
            id: colourChoiceRect; width: parent.width; height: dp(Theme.navigationBar.height); color: "transparent"
            Rectangle {
                z:2; anchors.fill: parent
                gradient: Gradient {orientation: Gradient.Horizontal
                    GradientStop {position: 0.0; color: "white"}
                    GradientStop {position: 0.1; color: "transparent"}
                    GradientStop {position: 0.95; color: "transparent"}
                    GradientStop {position: 1.0; color: "white"}
                }
            }
            AppFlickable {
                id: colourChoiceFlickable; anchors.fill: parent; contentWidth: colourRow.width; flickableDirection: Flickable.HorizontalFlick
                Row {
                    id: colourRow; spacing: dp(10); height: dp(Theme.navigationBar.height)
                    Rectangle {height: parent.height; width: height; color: "transparent"}
                    Repeater {
                        model: colourModel.length
                        Rectangle {
                            border.color: "black"; border.width: 2; height: spacerH; width: height; radius: width/2; color: colourModel[index]
                            MouseArea {anchors.fill: parent; onClicked: canvasBG = colourModel[index]}
                        }
                    }
                    Rectangle {height: parent.height; width: height/2; color: "transparent"}
                }
            }
            Rectangle {
                id: eyeDropperIconButton; z:3; height: parent.height; width: height; color: "white"; anchors.bottom: parent.bottom
                IconButton {id:eyedropIcon; icon: IconType.eyedropper; onClicked: colorDialog.visible = true}
            }
        }
        Rectangle {
            id: canvasChoiceRect; width: parent.width; height: dp(Theme.navigationBar.height); color: "transparent"
            Rectangle {
                z:2; anchors.fill: parent
                gradient: Gradient {orientation: Gradient.Horizontal
                    GradientStop {position: 0.0; color: "white"}
                    GradientStop {position: 0.05; color: "transparent"}
                    GradientStop {position: 0.95; color: "transparent"}
                    GradientStop {position: 1.0; color: "white"}
                }
            }
            AppFlickable {
                id: canvasChoiceFlickable; anchors.fill: parent; contentWidth: canvasRow.width; flickableDirection: Flickable.HorizontalFlick
                Row {
                    id: canvasRow; spacing: dp(10); height: dp(Theme.navigationBar.height)
                    Rectangle {height: parent.height; width: height/2; color: "transparent"}
                    Repeater {
                        id: canvasIconRepeater; model: canvasIcons.length
                        Rectangle {
                            height: canvasRow.height; width: height;
                            Rectangle {z:2; anchors.fill: parent; color: "#EBCFB2"; opacity: 0.5; visible: canvasIndex === index ? true : false}
                            AppImage {
                                z: 1; anchors.fill: parent; source: Qt.resolvedUrl(canvasIcons[index])
                                MouseArea {
                                    anchors.fill: parent;
                                    enabled: mediaplayer.playbackState == MediaPlayer.PlayingState ? false : true
                                    onClicked: {canvasIndex = index; mediaplayer.play(); timer.running = true; console.log("clicked" + index)}
                                }
                                Timer {
                                    id: timer; interval: 1000; repeat: false; running: false
                                    onTriggered: {
                                        console.log("timer triggered! INDEX: " + index)
                                        if(index === 0) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas1x1.qml"}
                                        else if(index === 1) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2.qml"}
                                        else if(index === 2) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2_1.qml"}
                                        else if(index === 3) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2_2.qml"}
                                        else if(index === 4) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2_3.qml"}
                                        else if(index === 5) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2_4.qml"}
                                        else if(index === 6) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas2x2_5.qml"}
                                        else if(index === 7) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x1.qml"}
                                        else if(index === 8) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x1_1.qml"}
                                        else if(index === 9) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x2.qml"}
                                        else if(index === 10) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x2_1.qml"}
                                        else if(index === 11) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x2_2.qml"}
                                        else if(index === 12) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas3x3.qml"}
                                        else if(index === 13) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas4x4.qml"}
                                        else if(index === 14) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas4x4_1.qml"}
                                        else if(index === 15) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas4x4_2.qml"}
                                        else if(index === 16) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas5x5.qml"}
                                        else if(index === 17) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas5x5_1.qml"}
                                        else if(index === 18) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas6x6_1.qml"}
                                        else if(index === 19) {loaderCanvas.source = "../qml/CanvasTemplates/Canvas6x6_2.qml"}
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {height: parent.height; width: height/2; color: "transparent"}
                }
            }
        }
    }
    ColorDialog {
        id: colorDialog; title: "Please choose a color"; Component.onCompleted: visible = false
        onAccepted: {console.log("You chose: " + colorDialog.color); canvasBG = colorDialog.color;eyedropIcon.color = colorDialog.color ; colorDialog.visible = false}
        onRejected: {console.log("Canceled"); colorDialog.visible = false}
    }
    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker; title: "CHOOSE IMAGE"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Select"; textItem.font.pixelSize: sp(16)
                    onClicked: {
                        if(currentRect === "rect1"){rect1Imgsource = imagePath}
                        else if(currentRect === "rect2"){rect2Imgsource = imagePath}
                        else if(currentRect === "rect3"){rect3Imgsource = imagePath}
                        else if(currentRect === "rect4"){rect4Imgsource = imagePath}
                        else if(currentRect === "rect5"){rect5Imgsource = imagePath}
                        else if(currentRect === "rect6"){rect6Imgsource = imagePath}
                        else if(currentRect === "rect7"){rect7Imgsource = imagePath}
                        else if(currentRect === "rect8"){rect8Imgsource = imagePath}
                        else if(currentRect === "rect9"){rect9Imgsource = imagePath}
                        else if(currentRect === "rect10"){rect10Imgsource = imagePath}
                        else if(currentRect === "rect11"){rect11Imgsource = imagePath}
                        else if(currentRect === "rect12"){rect12Imgsource = imagePath}
                        imagePickerModal.close()
                    }
                }
            }
        }
    }
}
/*
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






  */
