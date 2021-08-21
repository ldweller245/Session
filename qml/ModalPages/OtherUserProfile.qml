import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Page {
    id: userProfilePage

    title: otherUser.username

    function isEven(n) {
        return n % 2 == 0;
    }
    function isOdd(n) {
        return Math.abs(n % 2) == 1;
    }
    property var userID: 0

    property var otherUser: dataModel.otherUserData

    property var otherUserFeed: dataModel.otherUserPortfolio

    onUserIDChanged: {
        otherUserID = userID
        dataModel.getUser(userID)
    }

    JsonListModel {
        id: userJsonModel
        source: otherUserFeed
        keyField: "id"
        fields: ["id", "downloadUrl", "dimensions", "liked_by", "owner", "post_description", "tag", "team", "timestamp"]
    }
    SortFilterProxyModel {
        id: sortedModelOdd
        Component.onCompleted: sourceModel = userJsonModel
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
        filters: ExpressionFilter {expression: isOdd(index)}
    }
    SortFilterProxyModel {
        id: sortedModelEven
        Component.onCompleted: sourceModel = userJsonModel
        sorters: RoleSorter {roleName: "timestamp"; ascendingOrder: false}
        filters: ExpressionFilter {expression: isEven(index)}
    }

    Column {
        anchors.fill: parent; spacing: 10
        Column {
            id: profileColumn; width: parent.width; height: parent.height / 3
            Rectangle {
                width: parent.width; height: parent.height
                Row {
                    id: profileRow; anchors.fill: parent
                    Rectangle {
                        height: profileRow.height; width: profileRow.width / 2
                        Column {
                            id: detailsRow; anchors.verticalCenter: parent.verticalCenter
                            AppText {id: profileName; padding: dp(15); text: "<b>"+otherUser.firstname + "<br>" + otherUser.surname + "</b><br>" + otherUser.role}
                            AppText {fontSize: profileName.fontSize / 1.3; padding: dp(10); color: "grey"; text: "<b>"+otherUser.location +"</b><br><b>Last Active:</b> " + new Date(otherUser.lastActive).toDateString()}
                            Row{
                                width: parent.width
                                AppButton {width: parent.width/2; text: otherUser.follows_user === true ? "<b>Following": "<b>Follow"; flat: false; borderColor: "black"; backgroundColor: "white"; textColor: "black"; borderWidth: dp(1); dropShadow: false}
                                AppButton {width: parent.width/2; text: "<b>Message"; flat: false; borderColor: "black"; backgroundColor: "white"; textColor: "black"; borderWidth: dp(1); dropShadow: false}
                            }
                        }
                    }
                    RoundedImage  {id: profileImage; width: parent.width / 2; height: width; scale: 0.75; anchors.rightMargin: dp(10); anchors.verticalCenter: parent.verticalCenter; source: otherUser.profile_Pic_URL; fillMode: Image.PreserveAspectCrop; radius: profileImage.width/2; img.autoTransform: true; smooth: true}
                }
            }
        }

        Column {
            id: userStatistics; width: parent.width; height: statRow.height
            Row {
                id: statRow; width: parent.width
                AppButton {width: parent.width/2; text: "<b>Follow"; flat: false; borderColor: "black"; backgroundColor: "white"; textColor: "black"; borderWidth: dp(1); dropShadow: false}
                AppButton {width: parent.width/2; text: "<b>Message"; flat: false; borderColor: "black"; backgroundColor: "white"; textColor: "black"; borderWidth: dp(1); dropShadow: false}
            }
        }
        TabControl {
            id: tabControl; width: parent.width; height: parent.height -y
            NavigationItem {
                id: portfolioTab; title: "PORTFOLIO"
                Item {
                    anchors.fill: parent
                    AppFlickable {
                        contentHeight: scrollRow.height
                        width: parent.width
                        height: parent.height + dp(evenModelView.spacing)
                        Row {
                            id: scrollRow
                            width: userProfilePage.width
                            height: userProfilePage.height + evenModelView.spacing
                            AppListView {
                                id: evenModelView
                                interactive: false;
                                model: sortedModelEven; emptyText.text: qsTr("No posts yet!")
                                width: parent.width/2; spacing: dp(5); scrollIndicatorVisible: false;
                                delegate: AppCard {
                                    id: card
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
                                            onPressAndHold:  PictureViewer.show(userProfilePage, model.downloadUrl)
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
                                        text: model.post_description
                                    }                                   
                                }
                            }
                            AppListView {
                                id: oddModelView
                                interactive: false;
                                model: sortedModelOdd; emptyText.text: qsTr("No posts yet!");
                                width: parent.width/2; spacing: dp(5);scrollIndicatorVisible: false;
                                delegate: AppCard {
                                    id: card2
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
                                            onPressAndHold:  PictureViewer.show(userProfilePage, model.downloadUrl)
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
                                        text: model.post_description
                                    }

                                    // Some useless buttons to display in the actions cell
                                }
                            }
                        }
                    }
                }
            }
            NavigationItem {
                title: "DETAILS"
                Item {
                    anchors.fill: parent
                    AppFlickable {
                        anchors.fill: parent; contentHeight: detailsCol.height
                        Column {
                            id: detailsCol; width: parent.width
                            SimpleSection {title: "Bio:"}
                            AppText {text: otherUser.bio; padding: dp(20); width: parent.width}
                            SimpleSection {title: "Specialitites:"}
                            Column {width: parent.width; Repeater {model: otherUser.specialities; AppText {padding: dp(20); text: "\u{2022} " +modelData}}}
                            SimpleSection {title: "Details:"}
                            Column {width: parent.width; Repeater {model: Object.keys(otherUser.measurements); delegate: SimpleRow {text: Object.keys(otherUser.measurements)[index] + ": "+Object.values(otherUser.measurements)[index];showDisclosure: false }}}
                        }
                    }
                }
            }
        }
    }
}
