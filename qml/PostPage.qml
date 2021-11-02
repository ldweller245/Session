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

    //function imagePosted() {team = [];imageToPost = undefined; imageSourceHeight = undefined; imageSourceWidth = undefined; appTextEdit.text = ""; searchTextField.text = ""}

    Connections {
        target: nativeUtils
        onMessageBoxFinished: {if(accepted){page.postImage(imageToPost, imageSourceHeight, imageSourceWidth, appTextEdit.text, team, searchTextField.text, userData.role)}}
    }
    rightBarItem: TextButtonBarItem {
        text: "UPLOAD"; textItem.font.pixelSize: sp(16);
        onClicked: {
            if(imageToPost === undefined) {
                nativeUtils.displayMessageBox(qsTr("Hey!"), qsTr("What sort of post doesn't have an image!?"))
            }
            if(appTextEdit.length < 1) {
                nativeUtils.displayMessageBox(qsTr("C'mon"), qsTr("Tell us about the look!"))
            }
            if(team.length === 0) {
                nativeUtils.displayMessageBox(qsTr("Don't leave your team out!"), qsTr("Are you sure you want to post without tagging your team?"), 2)
            }
            else {
                page.postImage(imageToPost, imageSourceHeight, imageSourceWidth, appTextEdit.text, team, searchTextField.text, userData.role);
            }
        } //onClicked end
    }
    AppFlickable {
        id: flickable; anchors.fill: parent; contentHeight: contentCol.height
        Column {
            //Cannot specify top, bottom, verticalCenter, fill or centerIn anchors for items inside Column. Column will not function.
            id: contentCol; width: parent.width
            Rectangle {
                width: parent.width; height: imageToPost !== undefined ? selectedImage.height : width/2; color: "lightgrey"
                Icon {icon: IconType.upload; anchors.centerIn: parent; scale: 2}
                AppImage {
                    id: selectedImage; visible: imageToPost !== undefined ;source: imageToPost; width: parent.width; height: imageToPost !== undefined || "" || " " || "undefined" ? Image.height : parent.width; anchors.centerIn: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectFit
                    onSourceChanged: {imageSourceWidth = sourceSize.width; imageSourceHeight = sourceSize.height}}
                MouseArea {anchors.fill: parent; onClicked: imagePickerModal.open()}
            }
            Item {
                z: 5; width: parent.width; height: dp(150) + dp(Theme.navigationBar.height)
                Column {
                    id: locationDescriptionCol; anchors.fill: parent
                    Rectangle {
                        width: parent.width; height: parent.height; color: "#fff"
                        border.color: "black"
                        border.width: 1
                        AppFlickable {
                            id: flickText;anchors.fill: parent ; contentWidth: width; contentHeight: appTextEdit.height
                            AppTextEdit {
                                onTextChanged: console.log(appTextEdit.length); inputMethodHints: Qt.ImhSensitiveData; id: appTextEdit; width: parent.width; height: Math.max(appTextEdit.contentHeight, flickText.height); padding: dp(10);
                                placeholderText: "Tell us about the look!"; verticalAlignment: TextEdit.AlignTop; flickable: flickText; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            }
                        }
                    }
                }
            }
            Item {
                width: parent.width; height: searchTextField.text.length > 0 ? dp(Theme.navigationBar.height) + suggestionsList.height : dp(Theme.navigationBar.height)
                Column {
                    anchors.fill: parent; z:7; height: searchTextField.height + suggestionsList.height; width: parent.width
                    AppTextField {
                        id: searchTextField; width: parent.width; anchors.horizontalCenter: parent.horizontalCenter; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Add Location")
                        onAccepted: {focus = false; if (text != "") {geocodeModel.query = text}}
                        onDisplayTextChanged: {
                            if (searchTextField.displayText.length > 2 && searchTextField.focus) {
                                suggenstionModel.searchTerm = searchTextField.displayText.toString();suggenstionModel.update()}
                            else if(searchTextField.displayText.length === 0) {suggestionsList.hide()}
                        }
                        onFocusChanged: {if (!focus) {suggestionsList.hide()}}
                        Component.onCompleted: {font.pixelSize = sp(16)}
                    }
                    SuggestionsList {
                        z:7
                        id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel; anchors {horizontalCenter: parent.horizontalCenter}
                        onProposalSelected: {searchTextField.focus = false; searchTextField.text = suggestion; geocodeModel.query = suggestion}
                    }
                }
            }

            Rectangle {width: parent.width; height: px(1); color: Theme.listItem.dividerColor}

            Row {AppButton {text: "ADD TEAM"; flat: true; onClicked: addTeamModal.open()} IconButton {icon: IconType.plus; onClicked: addTeamModal.open()}}
            Rectangle {width: parent.width; height: px(1); color: Theme.listItem.dividerColor}
        }
    }
    AppButton {
        minimumWidth: parent.width / 2; anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.margins: dp(15); radius: dp(12); flat: false; text: "Preview"
        onClicked: postStack.push(postPreviewComp, {previewData: {"image": selectedImage.source, "location": searchTextField.text, "details": appTextEdit.text, "team": team}})
    }

    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                id: imagePicker; title: "CHOOSE IMAGE"; clip: true
                rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: {imageToPost = imagePath; console.log("NEW SOURCE: " + imageToPost) ; imagePickerModal.close()}}
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
            console.log("count: " + count)
            for(var i = 0; i < count; i++){
                var address = get(i).address
                var fullText
                fullText = "str: "+ address.street + " City: " + address.city + " Country: " + address.country

                console.log("get: " + fullText + "<br>")
            }
        }
    }
    QL.PlaceSearchModel {
        id: suggenstionModel; plugin:  MapBoxPlugin {geocoding: true}
        onStatusChanged: {if (status == QL.PlaceSearchSuggestionModel.Ready) {suggestionsList.show()}}
    }
}
