import QtQuick 2.0
import Felgo 3.0

Page {
    id: shootConceptPage
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: shootConceptPage.width


    AppFlickable {
        anchors.fill: parent; contentHeight: pageEditable === true ? addBoardsCol.height : viewBoards.height
        Column {
            id: addBoardsCol
            visible: pageEditable
            width: parent.width; spacing: dp(Theme.navigationBar.height)/2
            Rectangle {width: spacerW; height: spacerH}
            AppText {width: parent.width; padding: dp(15); horizontalAlignment: Text.AlignHCenter; text: "Keep your event moodboard & inspirations here for your team to see!"}
            Rectangle {width: spacerW; height: spacerH}
            IconButton {scale: 3; icon: IconType.upload; anchors.horizontalCenter: parent.horizontalCenter}
            Repeater {
                model: moodboards.length
                delegate: AppImage {
                    width: parent.width; height: Image.height; scale: 0.96
                    source: modelData[index]
                }
            }
        }

        Column {
            id: viewBoards
            width: parent.width
            visible: !pageEditable; spacing: dp(Theme.navigationBar.height)/2
            Rectangle {width: spacerW; height: spacerH}
            Repeater {
                model: shootData.length
                delegate: AppImage {
                    width: parent.width
                    height: Image.height
                    scale: 0.96
                    source: shootData.image[index]
                }
            }
            Rectangle {width: spacerW; height: spacerH}
        }
    }

    //image picker modal to push image path to array
    // on storing in fbDB for(var i in x){storage.upload....}
}
