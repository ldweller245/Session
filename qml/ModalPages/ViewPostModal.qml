import QtQuick 2.0
import Felgo 3.0

Page {
    id: page

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width

    property var postID: 0

    property var postData: dataModel.viewPostData

    onPostIDChanged: {
        dataModel.getPost(postID)
    }

    AppFlickable {
        anchors.fill: parent; contentHeight: contentCol.height
        z:1
        Column {
            id: contentCol; width: parent.width;
            SimpleRow {
                imageSource: postData.owner.profile_Pic_URL
                text: postData.owner.username
                detailText: postData.owner.baseLocation
                enabled: true
                image.radius: image.width/2
                image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {
                    showDisclosure: false
                    backgroundColor: "transparent"
                }
                onSelected: exploreStack.push(otherUserComp, {userID: postData.owner.id})
            }
            Rectangle {height: spacerH; width: spacerW}
            AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: postData.downloadUrl; autoTransform: true}
            Row {
                height: location.height; width: parent.width
                Rectangle {
                    height: location.height; width: height
                    Icon {anchors.centerIn: parent; icon: IconType.mapmarker}
                }
                AppText {id: location; text: postData.location; padding: dp(15)}
            }
            AppText {id: postDescription; width: parent.width; text: postData.post_description; padding: dp(15)}
            AppText {padding: dp(15); text: "<b>Hair:"; visible: hairRepeater.count !== 0}
            Repeater {
                id: hairRepeater; model: postData.team.hair; visible: hairRepeater.count !== 0
                AppText {padding: dp(15); color: "grey"; text: postData.team.hair[index].name; width: parent.width}
            }
            AppText {padding: dp(15); text: "<b>Makeup:"; visible: makeupRepeater.count !== 0}
            Repeater {
                id: makeupRepeater; model: postData.team.makeup; visible: makeupRepeater.count !== 0
                AppText {padding: dp(15); color: "grey"; text: postData.team.makeup[index].name; width: parent.width}
            }
            AppText {padding: dp(15); text: "<b>Wardrobe:"; visible: wardrobeRepeater.count !== 0}
            Repeater {
                id: wardrobeRepeater; model: postData.team.wardrobe; visible: wardrobeRepeater.count !== 0
                AppText {padding: dp(15); color: "grey"; text: postData.team.wardrobe[index].name; width: parent.width}
            }
            AppText {padding: dp(15); text: "<b>Models:"; visible: modelRepeater.count !== 0}
            Repeater {
                id: modelRepeater; model: postData.team.models; visible: modelRepeater.count !== 0
                AppText {padding: dp(15); color: "grey"; text: postData.team.models[index].name; width: parent.width}
            }
            AppText {padding: dp(15); text: "<b>Photographer:"; visible: photoRepeater.count !== 0}
            Repeater {
                id: photoRepeater; model: postData.team.photo; visible: photoRepeater.count !== 0
                AppText {padding: dp(15); color: "grey"; text: postData.team.photo[index].name; width: parent.width}
            }
            Rectangle {width: spacerW; height: spacerH*2.5}
        }
    }
    Rectangle {
        id: footer; width: parent.width; anchors.bottom: parent.bottom; height: spacerH*2; z:2
        Row {
            anchors.fill: parent
            IconButton {icon: IconType.hearto; selectedIcon: IconType.heart; selected: postData.liked_by.liked_by_me; toggle: true}
            AppText {width: Text.width; height: Text.height; anchors.verticalCenter: parent.verticalCenter; text: postData.liked_by.count}
            AppText {id: followButton; text: "follow"; anchors.verticalCenter: likeButton.verticalCenter}
        }
    }
    AppModal {
        id: otherUserModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            OtherUserProfile {
                id: otherUserPage; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16)
                    onClicked: {otherUserModal.close()}
                }
            }
        }
    }
}
