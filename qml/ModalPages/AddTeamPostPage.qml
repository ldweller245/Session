import QtQuick 2.0
import Felgo 3.0

Page {
    id: page
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width
    AppFlickable {
        anchors.fill: parent
        contentHeight: contentCol
        Column {
            id: contentCol
            Rectangle {
                width: spacerW
                height: spacerH
            }
            AppText {
                text: "Add your hair team"
                padding: dp(15)
            }
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"
            }
            Rectangle {
                width: spacerW
                height: spacerH
            }
            AppText {
                text: "Add your makeup team"
                padding: dp(15)
            }
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"

            }
            Rectangle {
                width: spacerW
                height: spacerH
            }
            AppText {
                text: "Add your wardrobe team"
                padding: dp(15)
            }
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"

            }
            Rectangle {
                width: spacerW
                height: spacerH
            }
            AppText {
                text: "Add your photography team"
                padding: dp(15)
            }
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"

            }
            Rectangle {
                width: spacerW
                height: spacerH
            }
            AppText {
                text: "Add your models"
                padding: dp(15)
            }
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"

            }

        }
    }

}
