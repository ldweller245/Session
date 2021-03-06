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
    function showNew() {
        homePage.jsonArrayChanged()
        showNewButton.state = "reanchored"
    }

    AppButton {
        id: showNewButton; z: 6
        text: "new posts"; textColor: "white"
        minimumWidth: parent.width/2; anchors.topMargin: dp(15); anchors.horizontalCenter: parent.horizontalCenter
        radius: dp(5); backgroundColor: Qt.rgba(0,0,0,0.50)
        state: "base"
        onClicked: {
            showNewButton.state = "base"
            flickable.contentY = 0
        }
        states: [
            State {
                name: "base"
                AnchorChanges { target: showNewButton; anchors.top: undefined}
                AnchorChanges { target: showNewButton; anchors.bottom: scrollModel.top}
            },
            State {
                name: "reanchored"
                AnchorChanges { target: showNewButton; anchors.bottom: undefined}
                AnchorChanges { target: showNewButton; anchors.top: scrollModel.bottom }
            }
        ]
        transitions: Transition {
            AnchorAnimation { duration: 800; easing.type: Easing.InOutBack}
        }
    }
    JsonListModel {
        id: jsonModel; source: jsonArray; keyField: "id"
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
        icon: IconType.search;
        onClicked: {
            searchUserModal.visible === true ? searchUserModal.visible = false : searchUserModal.visible = true
        }
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
        id: flickable
        anchors.fill: parent; contentHeight: scrollRow.height + dp(Theme.navigationBar.height)*2; anchors.topMargin: scrollModel.height
        Row {
            id: scrollRow; width: parent.width
            Column {
                id: col; spacing: dp(5); width: parent.width/2
                Behavior on y {
                    NumberAnimation {properties: "y"; duration: 1000 }
                }
                Repeater {

                    id: evenModelView; model: sortedModelEven;
                    delegate: AppCard {
                        id: evenImage; width: (parent.width)-dp(2); margin: dp(5); paper.radius: dp(5); scale: 0.96;
                        media: AppImage {
                            width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl; autoTransform: true
                            MouseArea {anchors.fill: parent; onPressAndHold: PictureViewer.show(homePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: {exploreStack.push(viewPostComp, {postID: model.id})}}
                        }
                        content: AppText {
                            width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.owner.username
                            MouseArea {anchors.fill: parent; onClicked: exploreStack.push(otherUserComp, {userID: model.owner.id})}
                        }
                        actions: Row {
                            IconButton {
                                icon: {
                                    var likedList = Object.keys(model.liked_by.list)
                                    likedList.indexOf(userData.id) ? IconType.heart : IconType.hearto}
                                onClicked: {likedList.indexOf(userData.id) ? dataModel.likePost(model.id, false, model.liked_by.count, model.owner.id) : dataModel.likePost(model.id, true, model.liked_by.count, model.owner.id)}
                            }
                        }
                    }
                }
            }
            Column {
                id: oddCol; spacing: dp(5); width: parent.width/2
                Repeater {
                    id: oddModelView; model: sortedModelOdd;
                    delegate: AppCard {
                        id: oddImage; width: (parent.width)-dp(2); margin: dp(5); paper.radius: dp(5); scale: 0.96;
                        media: AppImage {
                            width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl; autoTransform: true
                            MouseArea {anchors.fill: parent; onPressAndHold:  PictureViewer.show(homePage, model.downloadUrl); onReleased: PictureViewer.close(); onClicked: {exploreStack.push(viewPostComp, {postID: model.id})}}
                        }
                        content: AppText{
                            width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.owner.username;
                            MouseArea {anchors.fill: parent; onClicked: exploreStack.push(otherUserComp, {userID: model.owner.id})}
                        }
                        actions: Row {
                            IconButton {
                                icon: {
                                    var likedList = Object.keys(model.liked_by.list)
                                    likedList.indexOf(userData.id) ? IconType.heart : IconType.hearto}
                                onClicked: {likedList.indexOf(userData.id) ? dataModel.likePost(model.id, false, model.liked_by.count, model.owner.id) : dataModel.likePost(model.id, true, model.liked_by.count, model.owner.id)}
                            }
                        }
                    }
                }
            }
        }
    }
    Component {
        id: footerComp
        Rectangle {color: "white"; width: parent.width; height: dp(Theme.navigationBar.height)*2}
    }
    Rectangle {
        id: searchUserModal
        z: 7; anchors.fill: parent; width: parent.width; height: parent.height/3; anchors.top: parent.top; visible: false; opacity: visible === true ? 1 : 0; color: Qt.rgba(0,0,0,0.5)
        Behavior on opacity {NumberAnimation {duration: 400}}
        Column {
            anchors.fill: parent
            Row {
                width: parent.width; height: searchText.height;
                Rectangle {
                    height: parent.height; width: height; color: "white"
                    Icon {icon: IconType.search; anchors.centerIn: parent}
                }
                AppTextField {
                    id: searchText; width: parent.width; height: AppTextField.height; placeholderText: "@"; inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                    onTextEdited: {
                        if(searchText.length > 0){dataModel.searchUsers(searchText.text); app.searchArrChanged()}
                        else if(searchText.length === 0) {searchArr = []}
                    }
                }
            }
            Repeater {
                model: searchArr
                delegate: SimpleRow {id: delegate; text: modelData.name; showDisclosure: false
                    imageSource: modelData.image
                    image.height: parent.height
                    image.width: height
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    ; onSelected: exploreStack.push(otherUserComp, {userID: modelData.id})}
            }
            Rectangle {
                width: parent.width; height: dp(Theme.navigationBar.height)
                IconButton {anchors.centerIn: parent; icon: IconType.times; onClicked: {searchUserModal.visible = false}}
            }
        }
    }
}
