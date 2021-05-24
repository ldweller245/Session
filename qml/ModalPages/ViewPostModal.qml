import QtQuick 2.0
import Felgo 3.0

Page {
    id: page

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width

    Column {
        anchors.fill: parent
        SimpleRow {
            imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
            text: "Katie Prescott"
            detailText: "Annroy Studios, London."
            enabled: true
            image.radius: image.width/2
            image.fillMode: Image.PreserveAspectCrop
            style: StyleSimpleRow {
                showDisclosure: false
                backgroundColor: "transparent"
            }
            onSelected: otherUserModal.open()
        }

        Rectangle {height: spacerH; width: spacerW}

        AppImage {
            width: parent.width
            height: width
            source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"

        }
        Row {
            height: location.height
            width: parent.width
            Rectangle {
                height: location.height
                width: height
                Icon {
                    anchors.centerIn: parent
                    icon: IconType.mapmarker
                }
            }
            AppText {
                id: location
                text: "location"
                padding: dp(15)
            }
        }
        AppText {
            id: postDescription
            text: "This is a post description"
            padding: dp(15)
        }
        AppText {
            id: teamList
            text: "Team List"
            padding: dp(15)
        }
    }
    Rectangle {
        width: parent.width
        anchors.bottom: parent.bottom
        height: spacerH*2.5
        Row {
            anchors.fill: parent
            IconButton {
                id: likeButton
                icon: IconType.thumbsup
            }
            IconButton {
                icon: IconType.share
            }
            AppText {
                id: followButton
                text: "follow"
                anchors.verticalCenter: likeButton.verticalCenter
            }
        }
    }
    AppModal {
        id: otherUserModal
        fullscreen: true
        pushBackContent: navigationRoot
        NavigationStack {
            OtherUserProfile {
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: otherUserModal.close()
                }
            }
        }
    }
}
