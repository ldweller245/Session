import QtQuick 2.0
import QtQuick.Controls 2.4
import Felgo 3.0
import "ModalPages"
import "model"

Page {
    id: explorePage

    title: explorePageTitle

    Component.onCompleted: {
  //      scrollViewLoader.sourceComponent = scrollComponent
        console.log("EXPLORE ON.COMPLETED")
    }
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
        Component.onCompleted: {sourceModel = jsonModel}
        filters: [
            ExpressionFilter {expression: model.tag === exploreFilter},
            ExpressionFilter {expression: isOdd(index)}
        ]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }
    SortFilterProxyModel {
        id: sortedModelEven;
        Component.onCompleted: {sourceModel = jsonModel}
        filters: [
            ExpressionFilter {expression: model.tag === exploreFilter},
            ExpressionFilter {expression: isEven(index)}
        ]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }
    AppFlickable {
        anchors.fill: parent
        contentHeight: scrollRow.height
        Row {
            id: scrollRow; width: explorePage.width; height: explorePage.height;
            AppListView {
                id: evenModelView; interactive: false; model: sortedModelEven; emptyText.text: qsTr("No posts yet!"); scale: 0.96; width: (explorePage.width/2)-dp(2); spacing: dp(5); scrollIndicatorVisible: false;
                delegate:AppImage {
                    id: evenImage; z: 1; scale: 0.96; width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl
                    AppText {id: evenImageText; z: 3; anchors.centerIn: textRect; scale: 0.96; text: model.owner.username}
                    Rectangle {id: textRect; z: 2; width: parent.width - dp(10); height: evenImageText.height; anchors.bottomMargin: dp(3); anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; opacity: 0.8; radius: dp(3); color: "lightgrey"}
                    MouseArea {anchors.fill: parent; onPressAndHold: PictureViewer.show(explorePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: otherUserModal.open()}
                }
            }
            AppListView {
                id: oddModelView; interactive: false; model: sortedModelOdd; scale: 0.96; width: (explorePage.width/2)-dp(2); spacing: dp(5);scrollIndicatorVisible: false;
                delegate: AppImage {
                    id: oddImage; z: 1; scale: 0.96; width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl;
                    AppText {id: oddImageText; z: 3; scale: 0.96; anchors.centerIn: oddTextRect; text: model.owner.username}
                    Rectangle {id: oddTextRect; z: 2; width: parent.width - dp(10); height: oddImageText.height; anchors.bottomMargin: dp(3); anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; opacity: 0.8; radius: dp(3); color: "lightgrey"}
                    MouseArea {anchors.fill: parent; onPressAndHold:  PictureViewer.show(explorePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: otherUserModal.open()}
                }
            }
        }
    }
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
