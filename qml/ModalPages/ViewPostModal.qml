import QtQuick 2.0
import Felgo 3.0

Page {
    id: page


    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width


    AppFlickable{
        anchors.fill: parent
        contentHeight: contentCol.height + footer.height
        Column {
            id: contentCol
            width: parent.width
            SimpleRow {
                imageSource: feed2[viewPostID]
                text: dataModel.feedJson[viewPostID].owner.username
                detailText: dataModel.feedJson[viewPostID].owner.location
                enabled: true
                image.radius: image.width/2
                image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {
                    showDisclosure: false
                    backgroundColor: "transparent"
                }
                onSelected: {otherUserID = dataModel.feedJson[viewPostID].owner.id; otherUserModal.open()}
            }

            Rectangle {height: spacerH; width: spacerW}

            AppImage {
                width: parent.width
                fillMode: Image.PreserveAspectFit
                source: dataModel.feedJson[viewPostID].display_url
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
                    text: dataModel.feedJson[viewPostID].location
                    padding: dp(15)
                }
            }
            AppText {
                id: postDescription
                width: parent.width
                text: dataModel.feedJson[viewPostID].post_description
                padding: dp(15)
            }
            AppText {
                padding: dp(15)
                text: "<b>Hair:"
            }
            Repeater {
                model: dataModel.feedJson[viewPostID].team_hair
                AppText {
                    padding: dp(15)
                    color: "grey"
                    text: dataModel.feedJson[viewPostID].team_hair[index]
                    width: parent.width
                }
            }
            AppText {
                padding: dp(15)
                text: "<b>Makeup:"
            }
            Repeater {
                model: dataModel.feedJson[viewPostID].team_makeup
                AppText {
                    padding: dp(15)
                    color: "grey"
                    text: dataModel.feedJson[viewPostID].team_makeup[index]
                    width: parent.width
                }
            }
            AppText {
                padding: dp(15)
                text: "<b>Wardrobe:"
            }
            Repeater {
                model: dataModel.feedJson[viewPostID].team_wardrobe
                AppText {
                    padding: dp(15)
                    color: "grey"
                    text: dataModel.feedJson[viewPostID].team_wardrobe[index]
                    width: parent.width
                }
            }
            AppText {
                padding: dp(15)
                text: "<b>Models:"
            }
            Repeater {
                model: dataModel.feedJson[viewPostID].team_models
                AppText {
                    padding: dp(15)
                    color: "grey"
                    text: dataModel.feedJson[viewPostID].team_models[index]
                    width: parent.width
                }
            }
        }
    }
    Rectangle {
        id: footer
        width: parent.width
        anchors.bottom: parent.bottom
        height: spacerH*2.5
        Row {
            anchors.fill: parent
            IconButton {
                icon: IconType.hearto
                selectedIcon: IconType.heart
                selected: dataModel.feedJson[viewPostID].liked_by.liked_by_me
                toggle: true
            }
            AppText {
                width: Text.width
                height: Text.height
                anchors.verticalCenter: parent.verticalCenter
                text: dataModel.feedJson[viewPostID].liked_by.count
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
                id: otherUserPage
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: {;otherUserModal.close()}
                }
            }
        }
    }
}
