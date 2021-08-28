import QtQuick 2.0
import QtQuick 2.11
import Felgo 3.0
import QtLocation 5.12 as QL
import QtPositioning 5.12
import "Plugins"
import "Components"
import "ModalPages"

Page {
    id: page; title: "POST"

    property var imageToPost
    property var imageSourceWidth
    property var imageSourceHeight
    property var team:[]

    signal postImage(var postImagePath, var imageHeight, var imageWidth, var imageDescription, var team, var location, var tag)

    Connections {
        target: nativeUtils
        onMessageBoxFinished: {
            if(accepted){
                page.postImage(imageToPost, imageSourceHeight, imageSourceWidth, appTextEdit.text, team, searchTextField.text, userData.role)
            }
        }
    }

    rightBarItem: TextButtonBarItem {
        text: "UPLOAD"; textItem.font.pixelSize: sp(16);
        onClicked: {if(imageToPost === undefined) {nativeUtils.displayMessageBox(qsTr("Hey!"), qsTr("What sort of post doesn't have an image!?"))}
            else if(appTextEdit.length > 0) {nativeUtils.displayMessageBox(qsTr("C'mon"), qsTr("Tell us about the look!"))}
            else if(team.length === 0) {nativeUtils.displayMessageBox(qsTr("Don't leave your team out!"), qsTr("Are you sure you want to post without tagging your team?"), 2)}
            else {page.postImage(imageToPost, imageSourceHeight, imageSourceWidth, appTextEdit.text, team, searchTextField.text, userData.role)}}}
    AppFlickable {
        id:flick
        anchors.fill: parent; contentWidth: width; contentHeight: col.height + dp(150)
        Column {
            id: col; width: parent.width
            Rectangle {
                width: parent.width; height: page.height
                AppCard {
                    id: card3; width: parent.width; height: parent.height; margin: dp(15); paper.radius: dp(5)
                    header: Item {
                        width: parent.width; height: searchTextField.displayText.length > 0 ? dp(Theme.navigationBar.height)*2 + suggestionsList.height : dp(Theme.navigationBar.height)*2
                        Column {
                            anchors.fill: parent
                            SimpleRow {imageSource: userData.profile_Pic_URL; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop; text: userData.username; detailText: userData.role; enabled: false; style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}}
                            //Cannot specify top, bottom, verticalCenter, fill or centerIn anchors for items inside Column. Column will not function.
                            AppPaper {
                                z:5
                                height: searchTextField.height + suggestionsList.height
                                anchors {left: parent.left; right: parent.right; margins: dp(10)}
                                AppTextField {
                                    id: searchTextField; width: parent.width; anchors.horizontalCenter: parent.horizontalCenter; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Add Location")
                                    //Perform search when typed term is accepted
                                    onAccepted: {
                                        focus = false
                                        if (text != "") {
                                            geocodeModel.query = text
                                        }
                                    }
                                    //Update suggestions model when typed text changed
                                    onDisplayTextChanged: {
                                        console.log()
                                        if (searchTextField.displayText.length > 3 && searchTextField.focus) {
                                            suggenstionModel.searchTerm = searchTextField.displayText.toString()
                                            suggenstionModel.update()
                                        }
                                        else if(searchTextField.displayText.length === 0) {suggestionsList.hide()}
                                    }
                                    //Hide suggestions when focus is lost
                                    onFocusChanged: {if (!focus) {suggestionsList.hide()}}
                                    Component.onCompleted: {font.pixelSize = sp(16)}
                                }
                                SuggestionsList {
                                    id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel
                                    anchors {horizontalCenter: parent.horizontalCenter}
                                    onProposalSelected: {
                                        searchTextField.focus = false
                                        searchTextField.text = suggestion
                                        geocodeModel.query = suggestion
                                    }
                                }
                            }
                        }
                    }
                    media: Rectangle {
                        width: parent.width; height: imageToPost !== undefined ? selectedImage.height : width; color: "lightgrey"
                        Icon {icon: IconType.upload; anchors.centerIn: parent; scale: 2}
                        AppImage {
                            id: selectedImage
                            source: imageToPost
                            width: parent.width
                            height: imageToPost !== undefined ? Image.height : parent.width
                            anchors.centerIn: parent; autoTransform: true; smooth: true
                            onSourceChanged: {imageSourceWidth = sourceSize.width; imageSourceHeight = sourceSize.height}
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {anchors.fill: parent; onClicked: imagePickerModal.open()}
                    }
                    content: Item {
                        width: parent.width; height: dp(150) + dp(Theme.navigationBar.height)
                        Column {
                            id: locationDescriptionCol
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width; height: dp(Theme.navigationBar.height); color: "transparent"
                            }
                            Rectangle {
                                width: parent.width; height: parent.height - searchTextField.height; color: "#fff"
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
                id: addTeamPage
                title: "Add your team"; width: page.width
                rightBarItem: TextButtonBarItem {text: "Done"; textItem.font.pixelSize: sp(16);
                    onClicked: {
                        team = {"hair": addTeamPage.hairArray,"makeup": addTeamPage.makeupArray,"model": addTeamPage.modelArray,"wardrobe": addTeamPage.wardrobeArray,"photo": addTeamPage.photoArray}
                        page.teamChanged()
                        addTeamModal.close()
                    }
                }
            }
        }
    }

    QL.GeocodeModel {id: geocodeModel; plugin: MapBoxPlugin {geocoding: true} autoUpdate: true
        onLocationsChanged: {
            var address = get(0).address
            suggenstionModel.text = address.street + " " + address.city + " " + address.country
        }
    }
    QL.PlaceSearchSuggestionModel {
        id: suggenstionModel; plugin:  MapBoxPlugin {geocoding: true}
        onStatusChanged: {if (status == QL.PlaceSearchSuggestionModel.Ready) {suggestionsList.show()}}
    }
}
