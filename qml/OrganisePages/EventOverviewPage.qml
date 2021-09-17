import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: overviewItem

    signal createEvent(var eventName, var eventOrganiser, var eventDate, var eventTime, var eventOver, var coverImage, var eventConcept, var eventLocation, var eventTeam)

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: overviewItem.width

    AppFlickable {
        anchors.fill: parent
        contentHeight: contentCol.height
        Column {
            id: contentCol
            Rectangle {
                //cover image frame
                width: overviewItem.width
                height: overviewItem.height / 3
                color: "lightgrey"
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
                    height: Image.height
                    fillMode: Image.PreserveAspectFit
                    visible: pageEditable
                }

                Icon {
                    icon: IconType.edit
                    anchors{bottom: parent.bottom; right: parent.right}
                    anchors.margins: dp(15)
                    visible: pageEditable
                }
            }
            Rectangle {
                // event title container
                width: parent.width
                height: eventTitle.height
                AppText {
                    // event title
                    id: eventTitleText
                    text: shootData.title
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
                    text: new Date(shootData.date).toDateString()
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
                    text: shootData.time
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
                SwipeOptionsContainer {
                    id: container
                    SimpleRow {
                        imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
                        text: "Katie Prescott"
                        detailText: "Hair"
                        enabled: true
                        showDisclosure: true
                        image.radius: image.width/2
                        image.fillMode: Image.PreserveAspectCrop
                        style: StyleSimpleRow {
                            showDisclosure: false
                            backgroundColor: "transparent"
                        }
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
}
