import QtQuick 2.0
import Felgo 3.0

Page {
    id: overviewItem

    //readonly property real spacerH: dp(Theme.navigationBar.height)/2
    //readonly property real spacerW: overviewItem.width

    AppFlickable {
        //anchors.fill: parent
        //contentHeight: contentCol.height
        Column {
            //id: contentCol
            Rectangle {
                //width: overviewItem.width
                //height: overviewItem.height / 3
                //color: "lightgrey"
            }
            Rectangle {width: spacerW; height: spacerH}
            Row {
                width: overviewItem.width
                AppText {
                    id: dateText
                    padding: dp(15)
                }
                AppTextField {
                    id: dateTextField
                    placeholderText: new Date().toDateString()
                    enabled: false
                }
            }
            Row {
                width: overviewItem.width
                AppText {
                    id: timeText
                    padding: dp(15)
                }
                AppTextField {
                    id: timeTextField
                    placeholderText: new Date().toTimeString()
                    enabled: false
                }

            }

            Rectangle {width: spacerW; height: spacerH}
            Column {
                width: overviewItem.width
                AppText {
                    text: "Key Contact: "
                    padding: dp(15)
                }
                SwipeOptionsContainer {
                    id: container
                    rightOption: SwipeButton {
                        id: rightSwipe
                        icon: IconType.phone
                    }

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
                        onSelected: container.showRightOption()
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
                            id: appTextEdit
                            width: parent.width
                            height: Math.max(appTextEdit.contentHeight, flick.height)
                            verticalAlignment: TextEdit.AlignTop
                            // This enables the text field to automatically scroll if cursor moves outside while typing
                            text: "test1\ntest2\ntest3\ntest4\ntest5\ntest6\ntest7\ntest8\ntest9\ntest10"
                        }
                    }
                }

            }
            Rectangle {width: spacerW; height: spacerH}
        }
    }
}
