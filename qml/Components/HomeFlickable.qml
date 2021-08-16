import QtQuick 2.0
import QtQuick.Layouts 1.15
import Felgo 3.0
import "../ModalPages"

Item {
    id: item

    property var exploreFilter

    JsonListModel {id: jsonModel; source: userFeed; keyField: "id";fields: ["id", "dimensions", "owner", "downloadUrl", "timestamp","tag", "post_description", "team", "liked_by", "location", "owner"]}
    SortFilterProxyModel {
        id: sortedModel; Component.onCompleted: {sourceModel = jsonModel}
        filters: ExpressionFilter {expression: model.tag === exploreFilter}
    }
    AppListView {
        model: sortedModel; spacing: dp(15); orientation: ListView.Horizontal; anchors.fill: parent
        delegate: Rectangle {
            height: (item.width / 10)*5; width: (item.width / 10)*4
            AppImage {
                anchors.fill: parent; fillMode: Image.PreserveAspectFit; source: model.downloadUrl
                MouseArea {
                    anchors.fill: parent
                    onClicked: {viewPostID = model.id ;viewPostModal.open()}
                }
            }
        }
    }
    AppModal {
        id: viewPostModal; pushBackContent: navigationRoot
        NavigationStack {
            ViewPostModal {
                id: exploreModalPage; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: viewPostModal.close()
                }
            }
        }
    }
}
