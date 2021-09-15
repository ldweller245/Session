import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtLocation 5.12 as QL
import QtPositioning 5.12
import Felgo 3.0
import "../Components"
import "../Plugins"

Page {

    id: createCastingPage
    title: "CREATE CASTING"

    signal createCasting(var title, var seeking, var location, var date, var time, var details, var image, var paid, var compensation)

    property real spacerW: parent.width
    property real spacerH: dp(Theme.navigationBar.height)
    property var castingRoles: []
    property var imageToPost
    property var castingDate

    AppFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: contentCol.height
        Column {
            id: contentCol
            width: parent.width
            Rectangle {
                width: createCastingPage.width; color: "lightgrey"; height: imageToPost !== undefined ? selectedImage.height : createCastingPage.height/4;
                AppText {id: coverImageText; text: "Select cover image"; padding: dp(15); anchors.centerIn: parent}
                Icon {icon: IconType.edit; anchors.verticalCenter: parent.verticalCenter; anchors.left: coverImageText.right}
                AppImage {
                    id: selectedImage; visible: imageToPost !== undefined ;source: imageToPost; width: parent.width; height: imageToPost !== undefined || "" || " " || "undefined" ? Image.height : createCastingPage.height / 4; anchors.centerIn: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectFit
                    onSourceChanged: {imageSourceWidth = sourceSize.width; imageSourceHeight = sourceSize.height}}
                MouseArea {anchors.fill: parent; onClicked: imagePickerModal.open()}
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            AppText {width: spacerW; text: "<b>What's the casting for?" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)} //title
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            Row {
                width: createCastingPage.width
                AppText {id: eventTitleText; padding: dp(15)}
                AppTextField {id: eventTitle; placeholderText: "Enter event name"; height: Text.height}
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            AppText {width: spacerW; text: "<b>Is this a paid opportunity?" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            Row {
                width: createCastingPage.width
                spacing: dp(20)
                AppText {padding: dp(15)}
                AppText {
                    id: paidSwitchText
                    text: "No"
                }
                AppSwitch {
                    onCheckedChanged: checked === true ? paidSwitchText.text = "Yes" : paidSwitchText.text = "No"
                }
            }
            Row {
                width: createCastingPage.width; visible: paidSwitchText.text === "Yes"
                AppText {padding: dp(15)}
                AppTextField {id: compensationTextField; placeholderText: "What is the compensation?"}
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            AppText {width: spacerW; text: "<b>Tell us who you need on your team!" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}//seeking
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            GridLayout {
                columnSpacing: dp(20)
                anchors.horizontalCenter: parent.horizontalCenter
                rowSpacing: dp(15)
                columns: 2
                AppCheckBox {text: "Hair"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Makeup"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Wardrobe"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Photographer"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Male Models"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Female Models"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
                AppCheckBox {text: "Studio"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{if(checked === true) {if(castingRoles.includes(text) !== true){castingRoles.push(text)}}else {let index = castingRoles.indexOf(text); if (index > -1) {castingRoles.splice(index, 1)}}}}
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            AppText {width: spacerW; text: "<b>When and Where?" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}//location and date
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            Row {
                width: createCastingPage.width
                AppText {id: locationText; padding: dp(15)}
                Item {
                    width: parent.width; height: searchTextField.displayText.length > 2 ? searchTextField.height + suggestionsList.height : searchTextField.height
                    Column {
                        anchors.fill: parent
                        z:5; height: searchTextField.height + suggestionsList.height
                        width: parent.width
                        AppTextField {
                            id: searchTextField; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Add Location")
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
                            id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel; anchors {horizontalCenter: parent.horizontalCenter}
                            onProposalSelected: {searchTextField.focus = false; searchTextField.text = suggestion; geocodeModel.query = suggestion}
                        }
                    }
                }
            }
            Row {
                width: createCastingPage.width
                AppText {id: dateText; padding: dp(15)}
                AppTextField {id: dateTextField; placeholderText: new Date().toDateString(); enabled: false}
                IconButton {
                    id: dateIconButton; icon: IconType.calendar
                    onClicked: {nativeUtils.displayDatePicker()}
                }
                Connections {
                    target: nativeUtils
                    onDatePickerFinished: {
                        if(accepted) {castingDate = date; dateTextField.text = new Date(date).toDateString()}
                    }
                }
            }
            Row {
                width: createCastingPage.width
                AppText {id: timeText; padding: dp(15)}
                AppTextField {
                    id: timeTextField; placeholderText: "Select time"; enabled: false; text: timeTumblerSelection === undefined ? "" : timeTumblerSelection
                }
                IconButton {id: timeIconButton; icon: IconType.clocko; onClicked: timeTumblerModal.open()}
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            AppText {width: spacerW; text: "<b>Finally, give us the details!" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}//details and image
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
            Column {
                width: createCastingPage.width
                Rectangle {
                    width: parent.width; height: createCastingPage.height / 6
                    AppText {text: "Overview:"; padding: dp(15)}
                    Rectangle {
                        id: overviewBorderRect; border.color: "black"; border.width: dp(1); width: parent.width; scale: 0.93; height: createCastingPage.height / 6
                        AppFlickable {
                            id: flick; anchors.fill: parent; contentWidth: width; contentHeight: appTextEdit.height
                            AppTextEdit {
                                id: appTextEdit; width: parent.width; wrapMode: Text.WrapAtWordBoundaryOrAnywhere; height: Math.max(appTextEdit.contentHeight, flick.height); verticalAlignment: TextEdit.AlignTop; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); flickable: flick
                                placeholderText: " Let people know what you're vision is!"
                            }
                        }
                        ScrollIndicator {flickable: flick}
                    }
                }
            }
            Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}

            AppButton {
                width: parent.width / 2
                minimumWidth: parent.width/2
                text: "Create"
                radius: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    if(eventTitle.length === 0) {nativeUtils.displayMessageBox(qsTr("Don't forget to add a title!"))}
                    else if(castingRoles.length === 0) {nativeUtils.displayMessageBox(qsTr("You can't post a casting without telling us what team you need!"))}
                    else if(searchTextField.length === 0) {nativeUtils.displayMessageBox(qsTr("It always helps to say where!"))}
                    else if(dateTextField.length === 0) {nativeUtils.displayMessageBox(qsTr("You've got to tell us when!"))}
                    else if(timeTextField.length === 0) {nativeUtils.displayMessageBox(qsTr("What time is it?"))}
                    else if(appTextEdit.length === 0) {nativeUtils.displayMessageBox(qsTr("Please say what your casting is for!"))}
                    else if(imageToPost === undefined) {nativeUtils.displayMessageBox(qsTr("Adding a cover image will attract more attention!"))} //image path
                    else if(eventTitle.length > 0 && castingRoles.length > 0 && searchTextField.length > 0 && dateTextField.length > 0 && timeTextField.length > 0 && appTextEdit.length > 0) {
                        createCastingPage.createCasting(eventTitle.text, castingRoles, searchTextField.text, new Date(castingDate).getTime(), timeTextField.text, appTextEdit.text, imageToPost, paidSwitchText.text, compensationTextField.text)
                        organiseStack.pop(createCastingPageBase)
                    }
                }
            }
        }//content column end
    }//page flickable end

    AppModal {
        id: timeTumblerModal; fullscreen: false; pushBackContent: navigationRoot
        modalHeight: createCastingPage.height / 2.5;
        NavigationStack {
            TimeTumbler {
            }
        }
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

