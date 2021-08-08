import QtQuick 2.0
import QtQuick 2.11
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: page; title: "Post"

    property var imageToPost

    rightBarItem: TextButtonBarItem {
        text: "UPLOAD"; textItem.font.pixelSize: sp(16); onClicked: {}
    }
    AppFlickable {
        anchors.fill: parent
        contentHeight: col.height
    Column {
        id: col; width: parent.width
        Rectangle {
            width: parent.width; height: parent.height
            AppCard {
                id: card3; width: parent.width; height: parent.height; margin: dp(15); paper.radius: dp(5)
                header: SimpleRow {
                    imageSource: userData.profile_Pic_URL
                    text: userData.username
                    detailText: userData.role
                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }
                // For the media cell, we use a simple AppImage
                media: Rectangle {
                    width: parent.width; height: imageToPost !== undefined ? selectedImage.height : width; color: "lightgrey"
                    Icon {
                        icon: IconType.upload
                        anchors.centerIn: parent
                        scale: 2
                    }
                    AppImage {
                        id: selectedImage
                        visible: source !== undefined ? true : false
                        source: imageToPost
                        width: parent.width
                        height: source !== undefined ? Image.height : width
                        anchors.centerIn: parent
                        autoTransform: true
                        smooth: true
                        onSourceChanged: console.log("SELECTION DIMENSIONS::: Width"+ sourceSize.width +" Height: " + sourceSize.height)
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea {anchors.fill: parent; onClicked: imagePickerModal.open()}
                }
                content: Item {
                    width: parent.width; height: dp(150)
                    Rectangle {
                        anchors.fill: parent; color: "#fff"
                        Rectangle {
                            width: parent.width; height: px(1); anchors.bottom: parent.bottom; color: Theme.listItem.dividerColor
                        }
                    }
                    AppFlickable {
                        id: flick; anchors.fill: parent; contentWidth: width; contentHeight: appTextEdit.height
                        AppTextEdit {
                            id: appTextEdit
                            width: parent.width; height: Math.max(appTextEdit.contentHeight, flick.height)
                            placeholderText: "Tell us about the look!"; verticalAlignment: TextEdit.AlignTop
                            // This enables the text field to automatically scroll if cursor moves outside while typing
                            cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); flickable: flick
                        }
                    }
                    ScrollIndicator {flickable: flick}
                }
                actions: Row {
                    AppButton {text: "ADD TEAM"; flat: true; enabled: false}
                    IconButton {icon: IconType.plus; onClicked: addTeamModal.open()}
                }
            }
        }
    }
}

    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker
                title: "CHOOSE IMAGE"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: {imageToPost = imagePath; imagePickerModal.close()}
                }
            }

        }
    }
    AppModal {
        id: addTeamModal; fullscreen: false; pushBackContent: navigationRoot; modalHeight: page.height *0.8
        NavigationStack {
            AddTeamPostPage {
                title: "Add your team"
                rightBarItem: TextButtonBarItem {
                    text: "Done"; textItem.font.pixelSize: sp(16); onClicked: addTeamModal.close()
                }
            }
        }
    }
}


