import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: overviewItem

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: overviewItem.width

    property var tabIndex: tabControl.currentIndex

    onTabIndexChanged:  {
        eventName = eventTitle.text
        eventDate = new Date(dateTextField.text).getTime()
        eventTime = timeTextField.text
        eventDetails = appTextEdit.text
        /*
          cover image
          key contact
        */
    }


    AppFlickable {
        anchors.fill: parent
        contentHeight: contentCol.height
        Column {
            id: contentCol
            Rectangle {
                //cover image frame
                width: overviewItem.width
                height: overviewItem.height / 3
                color: pageEditable ? "lightgrey" : "transparent"
                AppText {
                    // cover image select text
                    id: coverImageText
                    text: "Select cover image"
                    padding: dp(15)
                    anchors.centerIn: parent
                    visible: pageEditable
                }
                AppImage {
                    id: coverImage
                    width: parent.width
                    source: shootData.coverImage
                    height: parent.height
                    fillMode: Image.PreserveAspectFit
                    clip: true
                }

                IconButton {
                    icon: IconType.edit
                    anchors{bottom: parent.bottom; right: parent.right}
                    anchors.margins: dp(15)
                    visible: pageEditable
                    onClicked: imagePickerModal.open()
                }
            }
            Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/3}
            Rectangle {
                // event title container
                width: parent.width
                height: eventTitle.height
                AppText {
                    // event title
                    id: eventTitleText
                    text: shootData.eventName
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: !pageEditable
                }
                AppTextField {
                    // event title
                    id: eventTitle
                    placeholderText: "Enter event name"
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: pageEditable
                }
            }
            Rectangle {width: spacerW; height: spacerH}
            Row {
                width: overviewItem.width
                AppText {
                    id: dateText
                    padding: dp(15)
                }
                AppText {
                    id: dateTextFieldText
                    text: new Date(shootData.eventDate).toDateString()
                    enabled: false
                    visible: !pageEditable
                }
                AppTextField {
                    id: dateTextField
                    placeholderText: new Date().toDateString()
                    enabled: false
                    visible: pageEditable
                }
                IconButton {
                    id: dateIconButton
                    icon: IconType.calendar
                    visible: pageEditable
                    onClicked: {
                        nativeUtils.displayDatePicker()
                    }
                }

                Connections {
                    target: nativeUtils
                    onDatePickerFinished: {
                        if(accepted) dateTextField.text = date
                    }
                }
            }
            Rectangle {width: spacerW; height: spacerH}
            Row {
                width: overviewItem.width
                AppText {
                    id: timeText
                    padding: dp(15)
                }
                AppText {
                    id: timeTextFieldText
                    text: shootData.eventTime
                    visible: !pageEditable
                }
                AppTextField {
                    id: timeTextField
                    placeholderText: "select time"
                    enabled: false
                    visible: pageEditable
                    text: timeTumblerSelection = undefined ? "" : timeTumblerSelection
                }
                IconButton {
                    id: timeIconButton
                    icon: IconType.clocko
                    visible: pageEditable
                    onClicked: timeTumblerModal.open()
                }
            }
            Rectangle {width: spacerW; height: spacerH}
            Column {
                visible: !pageEditable
                width: overviewItem.width
                AppText {
                    text: "Key Contact: "
                    padding: dp(15)
                }
                Row {
                    width: overviewItem.width
                    SimpleRow {
                        id: contactRow
                        width: parent.width - messageContact.width
                        imageSource: shootData.eventCreator.profile_pic
                        text: shootData.eventCreator.username
                        showDisclosure: false
                        image.radius: image.width/2
                        image.fillMode: Image.PreserveAspectCrop

                    }
                    IconButton {
                        id: messageContact
                        height: contactRow.height
                        width: height
                        icon: IconType.envelope
                    }
                }
            }
            Column {
                width: overviewItem.width
                AppText {
                    text: "Overview:"
                    padding: dp(15)
                }
                Rectangle {
                    id: overviewBorderRect
                    border.color: "black"
                    border.width: dp(1)
                    width: parent.width
                    scale: 0.93
                    height: overviewItem.height / 6
                    AppFlickable {
                        id: flick
                        anchors.fill: parent
                        contentWidth: width
                        contentHeight: appTextEdit.height
                        AppText {
                            id: appTextEditText
                            width: parent.width
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            height: Math.max(appTextEditText.contentHeight, flick.height)
                            verticalAlignment: TextEdit.AlignTop
                            text: shootData.overview
                            visible: !pageEditable
                        }
                        AppTextEdit {
                            id: appTextEdit
                            width: parent.width
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            height: Math.max(appTextEdit.contentHeight, flick.height)
                            verticalAlignment: TextEdit.AlignTop
                            // This enables the text field to automatically scroll if cursor moves outside while typing
                            cursorInView: true
                            cursorInViewBottomPadding: dp(25)
                            cursorInViewTopPadding: dp(25)
                            flickable: flick
                            visible: pageEditable
                            placeholderText: " Give us the details of the event!"
                        }
                    }
                    ScrollIndicator {
                        flickable: flick
                    }
                }
            }
            Rectangle {width: spacerW; height: spacerH}
        }
    }
    AppModal {
        id: timeTumblerModal; fullscreen: false; pushBackContent: navigationRoot
        modalHeight: overviewItem.height / 2.5;
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
                rightBarItem: TextButtonBarItem {
                    text: "Select"; textItem.font.pixelSize: sp(16)
                    onClicked: {
                        coverImage.source = imagePath
                        imagePickerModal.close()
                    }
                }
            }
        }
    }
}
