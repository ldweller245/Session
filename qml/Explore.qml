import QtQuick 2.0
import QtQuick.Controls 2.4
import Felgo 3.0
import "ModalPages"
import "model"

Page {
    id: explorePage

    //Object.keys(model.team) + " " + Object.values(model.team) === team roles + team members

    function truncateString(str, num) {
        return str;
    }
    function isEven(n) {
        return n % 2 == 0;
    }

    function isOdd(n) {
        return Math.abs(n % 2) == 1;
    }

    JsonListModel {
        id: jsonModel; source: userFeed; keyField: "id"
        fields: ["id", "owner", "downloadUrl","profile_Pic_URL", "tag", "timestamp","post_description", "team", "liked_by", "location"]
    }
    SortFilterProxyModel {
        id: sortedModelOdd;
        Component.onCompleted: {app.userFeedChanged();sourceModel = jsonModel}
        filters: [
            ExpressionFilter {expression: model.tag === exploreFilter},
            ExpressionFilter {expression: isOdd(index)}
        ]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }
    SortFilterProxyModel {
        id: sortedModelEven;
        Component.onCompleted: {app.userFeedChanged();sourceModel = jsonModel}
        filters: [
            ExpressionFilter {expression: model.tag === exploreFilter},
            ExpressionFilter {expression: isEven(index)}
        ]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }

    ScrollView {
        anchors.fill: parent
        Row {
            anchors.fill: parent
            spacing: dp(5)
            anchors.margins: dp(5)
            AppListView {
                id: evenModelView
                model: sortedModelEven; emptyText.text: qsTr("No posts yet!"); scale: 0.96
                width: parent.width/2; spacing: dp(5); scrollIndicatorVisible: false;
                delegate: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl}
            }
            AppListView {
                id: oddModelView
                model: sortedModelOdd; emptyText.text: qsTr("No posts yet!"); scale: 0.96
                width: parent.width/2; spacing: dp(5);scrollIndicatorVisible: false;
                delegate: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl}
            }
        }
    }


    /*AppCard {
            id: card; width: explorePage.width; margin: dp(15); paper.radius: dp(5)
            header: SimpleRow {
                imageSource: model.owner.profile_Pic_URL; text: model.owner.username; detailText: model.location; enabled: true; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                onSelected: {otherUserID = model.owner.id; console.log("other user id: " + otherUserID + "<br>OtherUserData: <br>"+ otherUserData.firstname) ;otherUserModal.open()}
            }
            //media:
            content: Column {width: parent.width; AppText {width: parent.width; padding: dp(15); text: new Date(model.timestamp).toDateString()}
                AppText{id: descriptionText; width: parent.width; padding: dp(15); text: model.post_description}}
            actions: Row {
                IconButton {icon: IconType.hearto; selectedIcon: IconType.heart; selected: model.liked_by.liked_by_me; toggle: true}
                AppText {width: Text.width; height: Text.height; anchors.verticalCenter: parent.verticalCenter; text: model.liked_by.count}
                IconButton {icon: IconType.sharealt}
                AppButton {text: "Follow"; flat: true}
            }
        }*/

    AppModal {
        id: otherUserModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            OtherUserProfile {
                id: userProfilePage; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16)
                    onClicked: {otherUserModal.close()}
                }
            }
        }
    }
}
