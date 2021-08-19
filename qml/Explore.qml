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

    /*AppFlickable {
        anchors.fill: parent
        contentHeight: scrollRow.height
        Row {
            id: scrollRow; width: explorePage.width; height: explorePage.height;
            AppListView {
                id: evenModelView; interactive: false; model: sortedModelEven; emptyText.text: qsTr("No posts yet!"); scale: 0.96; width: (explorePage.width/2)-dp(2); spacing: dp(5); scrollIndicatorVisible: false;
                delegate:AppCard {
                    id: evenImage
                    width: parent.width
                    margin: dp(5)
                    paper.radius: dp(5)

                    // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                    // For the media cell, we use a simple AppImage
                    media: AppImage {
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                        source: model.downloadUrl
                        MouseArea {
                            anchors.fill: parent
                            onPressAndHold:  PictureViewer.show(explorePage, model.downloadUrl)
                            onReleased: PictureViewer.close()
                        }
                    }

                    // For the content cell, we use some placeholder text
                    content: AppText{
                        width: parent.width
                        padding: dp(15)
                        maximumLineCount: 2
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        text: model.owner.username
                    }

                    // Some useless buttons to display in the actions cell
                }
            }
            AppListView {
                id: oddModelView; interactive: false; model: sortedModelOdd; scale: 0.96; width: (explorePage.width/2)-dp(2); spacing: dp(5);scrollIndicatorVisible: false;
                delegate: AppCard {
                    id: oddImage
                    width: parent.width
                    margin: dp(5)
                    paper.radius: dp(5)

                    // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                    // For the media cell, we use a simple AppImage
                    media: AppImage {
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                        source: model.downloadUrl
                        MouseArea {
                            anchors.fill: parent
                            onPressAndHold:  PictureViewer.show(explorePage, model.downloadUrl)
                            onReleased: PictureViewer.close()
                        }
                    }

                    // For the content cell, we use some placeholder text
                    content: AppText{
                        width: parent.width
                        padding: dp(15)
                        maximumLineCount: 2
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        text: model.owner.username
                    }

                    // Some useless buttons to display in the actions cell
                }






            }
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
