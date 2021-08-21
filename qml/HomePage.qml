import QtQuick 2.0
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: homePage
    title: "EXPLORE"

    property var headerArr: ["Everything", "Hair", "Makeup", "Model", "Wardrobe", "Photographer", "Studio"]

    function isEven(n) {return n % 2 == 0;}
    function isOdd(n) {return Math.abs(n % 2) == 1;}

    JsonListModel {
        id: jsonModel; source: userFeed; keyField: "id"
        fields: ["id", "owner", "downloadUrl","profile_Pic_URL", "tag", "timestamp","post_description", "team", "liked_by", "location"]
    }
    SortFilterProxyModel {
        id: sortedModelOdd; Component.onCompleted: {sourceModel = jsonModel}
        filters: [ExpressionFilter {expression: model.tag === exploreFilter; enabled: exploreFilter !== "Everything"}, ExpressionFilter {expression: isOdd(index)}]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }
    SortFilterProxyModel {
        id: sortedModelEven; Component.onCompleted: {sourceModel = jsonModel}
        filters: [ExpressionFilter {expression: model.tag === exploreFilter; enabled: exploreFilter !== "Everything"}, ExpressionFilter {expression: isEven(index)}]
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
    }
    rightBarItem: IconButtonBarItem {
        icon: IconType.search; onClicked: {}
    }

    AppListView {
        id: scrollModel; orientation: ListView.Horizontal; width: homePage.width; height: dp(Theme.tabBar.height); model: headerArr; anchors.top: parent.top; z: 2
        delegate: Rectangle {
            height: parent.height; width: (homePage.width / 10)*4; color: scrollModel.currentIndex === index ? "black" : "white"; border.color: "black"; border.width: dp(2)
            MouseArea {anchors.fill: parent; onClicked: {exploreFilter = headerArr[index]; scrollModel.currentIndex = index}}
            AppText {id: swipeSelectText; text: modelData; color: scrollModel.currentIndex === index ? "white" : "black"; anchors.centerIn: parent; horizontalAlignment: Text.AlignHCenter}
        }
    }
    AppFlickable {
        anchors.fill: parent; contentHeight: scrollRow.height + dp(Theme.navigationBar.height)*2; anchors.topMargin: scrollModel.height
        Column {
            width: parent.width
            height: parent.height + dp(Theme.navigationBar.height)*2
            Row {
                id: scrollRow; width: homePage.width; height: homePage.height;
                AppListView {
                    footer: footerComp
                    footerPositioning: ListView.InlineFooter
                    id: evenModelView; interactive: false; model: sortedModelEven; emptyText.text: qsTr("No posts yet!"); scale: 0.96; height: parent.height; width: (homePage.width/2)-dp(2); spacing: dp(5); scrollIndicatorVisible: false;
                    delegate: AppCard {
                        id: evenImage; width: parent.width; margin: dp(5); paper.radius: dp(5)
                        media: AppImage {
                            width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl
                            MouseArea {anchors.fill: parent; onPressAndHold: PictureViewer.show(homePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: {exploreStack.push(viewPostComp, {postID: model.id})}}
                        }
                        content: AppText {
                            width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.owner.username
                            MouseArea {anchors.fill: parent; onClicked: exploreStack.push(otherUserComp, {userID: model.owner.id})}
                        }
                    }
                    add: Transition {NumberAnimation {property: "opacity"; from: 0; to: 1.0; duration: 400 } NumberAnimation {property: "scale"; from: 0; to: 1.0; duration: 400 }}
                    displaced: Transition {NumberAnimation {properties: "x,y"; duration: 400; easing.type: Easing.InOutBack}}
                }
                AppListView {
                    footer: footerComp
                    footerPositioning: ListView.InlineFooter
                    id: oddModelView; interactive: false; model: sortedModelOdd; scale: 0.96; height: parent.height; width: (homePage.width/2)-dp(2); spacing: dp(5);scrollIndicatorVisible: false;
                    delegate: AppCard {
                        id: oddImage; width: parent.width; margin: dp(5); paper.radius: dp(5)
                        media: AppImage {
                            width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl
                            MouseArea {anchors.fill: parent; onPressAndHold:  PictureViewer.show(homePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: {exploreStack.push(viewPostComp, {postID: model.id})}}
                        }
                        content: AppText{
                            width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.owner.username;
                            MouseArea {anchors.fill: parent; onClicked: exploreStack.push(otherUserComp, {userID: model.owner.id})}
                        }
                    }
                    add: Transition {NumberAnimation {property: "opacity"; from: 0; to: 1.0; duration: 400} NumberAnimation {property: "scale"; from: 0; to: 1.0; duration: 400 }}
                    displaced: Transition {NumberAnimation {properties: "x,y"; duration: 400; easing.type: Easing.InOutBack}}
                }
            }
        }
    }
    Component {
        id: footerComp
        Rectangle {
            color: "white"
            width: parent.width
            height: dp(Theme.navigationBar.height)*2
        }
    }
}
