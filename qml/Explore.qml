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

    ScrollView {
        anchors.fill: parent
        Row {
            anchors.fill: parent
            spacing: dp(5)
            anchors.margins: dp(5)
            AppListView {
                id: evenModelView; model: sortedModelEven; emptyText.text: qsTr("No posts yet!"); scale: 0.96; width: (parent.width/2)-dp(2); spacing: dp(5); scrollIndicatorVisible: false;
                delegate: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl}
            }
            Rectangle {width: dp(5); height: evenModelView.height}

            AppListView {
                id: oddModelView; model: sortedModelOdd; emptyText.text: qsTr("No posts yet!"); scale: 0.96; width: (parent.width/2)-dp(2); spacing: dp(5);scrollIndicatorVisible: false;
                delegate: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl}
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
