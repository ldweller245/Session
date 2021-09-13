import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0
import "../Components"

Page {

    //to add to page: is paid?


    id: createCastingPage
    title: "Create Casting"

    signal createCasting(var title, var seeking, var location, var date, var time, var details, var image, var paid, var compensation)



    property real spacerW: parent.width
    property real spacerH: dp(Theme.navigationBar.height)
    property var castingRoles: []


    AppFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: contentCol.height
        Column {
            id: contentCol
            width: parent.width
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}
            AppText {width: spacerW; text: "What's the casting for?&nbsp;&nbsp;&nbsp;>"} //title
            Rectangle {
                width: parent.width; height: eventTitle.height
                AppTextField {id: eventTitle; placeholderText: "Enter event name"; anchors.horizontalCenter: parent.horizontalCenter}
            }
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}

            AppText {width: spacerW; text: "Is this a paid opportunity?"}
            GridLayout {
                columnSpacing: dp(20)
                rowSpacing: dp(15)
                columns: 2
                AppText {
                    id: paidSwitchText
                    text: "No"
                    Layout.preferredWidth: dp(80)
                }
                AppSwitch {
                    Layout.preferredWidth: dp(80)
                    onCheckedChanged: checked === true ? paidSwitchText.text = "Yes" : paidSwitchText.text = "No"
                }
                AppTextField {
                    id: compensationTextField
                    visible: paidSwitchText.text === "Yes"
                    placeholderText: "What is the compensation?";
                    Layout.columnSpan: 2
                }

            }

            Rectangle {width: spacerW; height: spacerH; color: "transparent"}
            AppText {width: spacerW; text: "Tell us who you need on your team!&nbsp;&nbsp;&nbsp;>"}//seeking
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}
            GridLayout {
                columnSpacing: dp(20)
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
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}
            AppText {width: spacerW; text: "When & where the event?"+ "&nbsp;&nbsp;&nbsp;>"}//location and date
            Rectangle {
                width: parent.width; height: locationTitle.height
                AppTextField {id: locationTitle; placeholderText: "Tell us where!"; anchors.horizontalCenter: parent.horizontalCenter}
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
                        if(accepted) dateTextField.text = date
                    }
                }
            }
            Row {
                width: createCastingPage.width
                AppText {id: timeText; padding: dp(15)}
                AppTextField {
                    id: timeTextField; placeholderText: "select time"; enabled: false; text: timeTumblerSelection === undefined ? "" : timeTumblerSelection
                }
                IconButton {id: timeIconButton; icon: IconType.clocko; onClicked: {timeTumblerPopup.visible = true; timeTumblerPopup.opacity = 1}}
            }
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}
            AppText {width: spacerW; text: "Finally, give us the details..."+"&nbsp;&nbsp;&nbsp;>"}//details and image
            Column {
                width: createCastingPage.width
                Rectangle {
                    width: parent.width; height: parent.height / 3; color: "lightgrey"
                    AppText {id: coverImageText; text: "Select cover image"; padding: dp(15); anchors.centerIn: parent}
                    Icon {icon: IconType.edit; anchors.verticalCenter: parent.verticalCenter; anchors.left: coverImageText.right}
                    AppText {text: "Overview:"; padding: dp(15)}
                    Rectangle {
                        id: overviewBorderRect; border.color: "black"; border.width: dp(1); width: parent.width; scale: 0.93; height: createCastingPage.height / 6
                        AppFlickable {
                            id: flick; anchors.fill: parent; contentWidth: width; contentHeight: appTextEdit.height
                            AppTextEdit {
                                id: appTextEdit; width: parent.width; wrapMode: Text.WrapAtWordBoundaryOrAnywhere; height: Math.max(appTextEdit.contentHeight, flick.height); verticalAlignment: TextEdit.AlignTop; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); flickable: flick
                                text: "test1\ntest2\ntest3\ntest4\ntest5\ntest6\ntest7\ntest8\ntest9\ntest10"
                            }
                        }
                        ScrollIndicator {flickable: flick}
                    }
                }
            }
            Rectangle {width: spacerW; height: spacerH; color: "transparent"}

            AppButton {
                width: parent.width / 2
                minimumWidth: parent.width/2
                text: "Create"
                radius: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    createCastingPage.createCasting(eventTitle.text, castingRoles, locationTitle.text, dateTextField.text, timeTextField.text, appTextEdit.text, "IMAGE PATH", paidSwitchText.text, compensationTextField.text)
                }
            }
        }//content column end
    }//page flickable end
    Item {
        visible: false
        id: timeTumblerPopup; anchors.fill: parent
        Rectangle {color: Qt.rgba(0,0,0,0.75); anchors.fill: parent}
        Rectangle {
            width: createCastingPage.width/2; height: createCastingPage.height/2; radius: dp(12)
            Column {
                anchors.fill: parent
                TimeTumbler {
                    width: parent.width
                    height: parent.height - saveTimeButton.height
                }
                AppButton {id: saveTimeButton; flat: false; text: "Confirm"; onClicked: {timeTumblerPopup.visible = false; timeTumblerPopup.opacity = 0}}
            }
        }
        Behavior on opacity {NumberAnimation {duration: 1000; easing.type: Easing.InOutBack}}
    }
}

