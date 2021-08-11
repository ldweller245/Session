import QtQuick 2.0
import QtQuick 2.11
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: page; title: "Post"

    property var imageToPost
    property var imageSourceWidth
    property var imageSourceHeight
    property var team:[]

    signal postImage(var postImagePath, var imageHeight, var imageWidth, var imageDescription, var team, var location, var tag)

    rightBarItem: TextButtonBarItem {
        text: "UPLOAD"; textItem.font.pixelSize: sp(16);
        onClicked: {if(imageToPost === undefined) {nativeUtils.displayMessageBox(qsTr("Hey!"), qsTr("What sort of post doesn't have an image!?"))}
            else if(appTextEdit.length > 0) {nativeUtils.displayMessageBox(qsTr("C'mon"), qsTr("Tell us about the look!"))}
            else if(team.length > 0) {nativeUtils.displayMessageBox(qsTr("Don't leave your team out!"), qsTr("Are you sure you want to post without tagging your team?"), 2)}
            else {page.postImage(imageToPost, imageSourceHeight, imageSourceWidth, appTextEdit.text, team, locationTextEdit.text, userData.role)}}}
    AppFlickable {
        id:flick
        anchors.fill: parent; contentWidth: width; contentHeight: col.height + dp(150)
        Column {
            id: col; width: parent.width
            Rectangle {
                width: parent.width; height: page.height
                AppCard {
                    id: card3; width: parent.width; height: parent.height; margin: dp(15); paper.radius: dp(5)
                    header: SimpleRow {
                        imageSource: userData.profile_Pic_URL; text: userData.username; detailText: userData.role; enabled: false; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                        style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                    }
                    media: Rectangle {
                        width: parent.width; height: imageToPost !== undefined ? selectedImage.height : width; color: "lightgrey"
                        Icon {icon: IconType.upload; anchors.centerIn: parent; scale: 2}
                        AppImage {
                            id: selectedImage
                            source: imageToPost
                            width: parent.width
                            height: imageToPost !== undefined ? Image.height : width
                            anchors.centerIn: parent; autoTransform: true; smooth: true
                            onSourceChanged: {imageSourceWidth = sourceSize.width; imageSourceHeight = sourceSize.height}
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {anchors.fill: parent; onClicked: imagePickerModal.open()}
                    }
                    content: Item {
                        width: parent.width; height: dp(150) + dp(Theme.navigationBar.height)
                        Column {
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width; height: dp(Theme.navigationBar.height); color: "transparent"
                                AppTextField {id: locationTextEdit; anchors.fill: parent; placeholderText: "location"; verticalAlignment: Text.AlignVCenter; padding: dp(10)}
                            }
                            Rectangle {
                                width: parent.width; height: parent.height - locationTextEdit.height; color: "#fff"
                                Rectangle {
                                    width: parent.width; height: px(1); anchors.bottom: parent.bottom; color: Theme.listItem.dividerColor
                                }
                            AppFlickable {
                                id: flickText;anchors.fill: parent ; contentWidth: width; contentHeight: appTextEdit.height
                                AppTextEdit {
                                    onTextChanged: console.log(appTextEdit.length)
                                    inputMethodHints: Qt.ImhSensitiveData

                                    id: appTextEdit; width: parent.width; height: Math.max(appTextEdit.contentHeight, flickText.height); padding: dp(10)
                                    placeholderText: "Tell us about the look!"; verticalAlignment: TextEdit.AlignTop;
                                    // This enables the text field to automatically scroll if cursor moves outside while typing
                                    flickable: flickText; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                }
                            }
                            }
                        }
                    }
                    actions: Row {AppButton {text: "ADD TEAM"; flat: true; onClicked: addTeamModal.open()}}
                }
            }
        }
    }
    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker; title: "CHOOSE IMAGE"; clip: true
                rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: {imageToPost = imagePath; imagePickerModal.close()}}
            }
        }
    }
    AppModal {
        id: addTeamModal; fullscreen: false; pushBackContent: navigationRoot; modalHeight: page.height *0.8
        NavigationStack {
            AddTeamPostPage {
                title: "Add your team"
                rightBarItem: TextButtonBarItem {text: "Done"; textItem.font.pixelSize: sp(16); onClicked: addTeamModal.close()}
            }
        }
    }
}
