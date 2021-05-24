import QtQuick 2.0
import Felgo 3.0

Page {
    id: shootConceptPage
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: shootConceptPage.width

    Column {
        anchors.fill: parent
        Rectangle {
            width: spacerW
            height: spacerH
        }
        AppText {
            width: parent.width
            padding: dp(15)
            text: "Keep your event moodboard & inspirations here for your team to see!"
            horizontalAlignment: Text.AlignHCenter
        }
        Rectangle {
            width: spacerW
            height: spacerH
        }
        IconButton {
            scale: 3
            icon: IconType.upload
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
