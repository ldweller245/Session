import QtQuick 2.0
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: homePage
    title: "EXPLORE"

    JsonListModel {
        id: jsonModel
        source: userFeed
        keyField: "id"
        fields: ["id", "owner", "display_url", "timestamp","tag", "post_description", "team", "liked_by", "location"]
    }
    SortFilterProxyModel {id: hairSortedModel; Component.onCompleted: {sourceModel = jsonModel} filters: ExpressionFilter {expression: {model.tag === "hair"; }}}
    SortFilterProxyModel {id: makeupSortedModel;Component.onCompleted: {sourceModel = jsonModel} filters: ExpressionFilter {expression: {model.tag === "makeup"}}}
    SortFilterProxyModel {id: wardrobeSortedModel; Component.onCompleted: {sourceModel = jsonModel}filters: ExpressionFilter {expression: {model.tag === "wardrobe"}}}
    SortFilterProxyModel {id: photoSortedModel; Component.onCompleted: {sourceModel = jsonModel}filters: ExpressionFilter {expression: {model.tag === "photo"}}}
    SortFilterProxyModel {id: modelSortedModel; Component.onCompleted: {sourceModel = jsonModel}filters: ExpressionFilter {expression: {model.tag === "model"}}}
    SortFilterProxyModel {id: locationSortedModel; Component.onCompleted: {sourceModel = jsonModel}filters: ExpressionFilter {expression: {model.tag === "location"}}}

    rightBarItem: IconButtonBarItem {
        icon: IconType.search
        onClicked: {}
    }
    AppFlickable {
        anchors.fill: parent; contentHeight: content.height
        Column {
            id: content; width: parent.width
            Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)}
            Repeater {
                id: repeater; model: arr.length
                Rectangle {
                    width: parent.width; height: homePage.height /3
                    Column {
                        id: contentCol; width: parent.width; height: parent.height
                        AppText {
                            id: titleText; width: homePage.width; text: "<b>"+Object.values(arr[index]) + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(10)
                            MouseArea {
                                anchors.fill: parent                               
                                onClicked: {
                                    exploreStack.push(explorePage)
                                    exploreFilter = Object.keys(arr[index]).toString()
                                    explorePage.title = Object.values(arr[index]).toString()
                                    //exploreModal.open()
                                }
                            }
                        }
                        Item {
                            id: item; width: homePage.width; height: homePage.height
                            AppListView {
                                model: {
                                    if(index === 0){hairSortedModel}
                                    else if(index === 1){makeupSortedModel}
                                    else if(index === 2){wardrobeSortedModel}
                                    else if(index === 3){photoSortedModel}
                                    else if(index === 4){modelSortedModel}
                                    else if(index === 5){locationSortedModel}
                                }
                                spacing: dp(15); orientation: ListView.Horizontal; anchors.fill: parent
                                delegate: Rectangle {
                                    height: (item.width / 10)*5; width: (item.width / 10)*4
                                    AppImage {
                                        anchors.fill: parent; fillMode: Image.PreserveAspectFit; source: model.display_url
                                        MouseArea {
                                            anchors.fill: parent                                            
                                            onClicked: {
                                                exploreStack.push(viewPostPage)
                                                viewPostID = model.id;
                                                //viewPostModal.open()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    /*AppModal {
        id: exploreModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            Explore {
                id: exploreModalPage; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: exploreModal.close()
                }
            }
        }
    }
    AppModal {
        id: viewPostModal; pushBackContent: navigationRoot
        NavigationStack {
            ViewPostModal {
                id: exploreModalPage2; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: viewPostModal.close()
                }
            }
        }
    }
    */
}
