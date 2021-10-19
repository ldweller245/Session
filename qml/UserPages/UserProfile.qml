import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Page {
    id: userProfilePage

    function isEven(n) {
        return n % 2 == 0;
    }
    function isOdd(n) {
        return Math.abs(n % 2) == 1;
    }
    property var jsonArray: Object.values(userData.feed_posts)



    JsonListModel {
        id: userJsonModel
        source: jsonArray
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
                            AppText {id: profileName; padding: dp(15); text: "<b>"+userData.firstname + "<br>" + userData.surname + "</b><br>" + userData.role}
                            AppText {fontSize: profileName.fontSize / 1.3; padding: dp(10); color: "grey"; text: "<b>"+userData.location +"</b><br><b>Last Active:</b> " + new Date(userData.lastActive).toDateString()}
                        }
                    }
                    RoundedImage  {id: profileImage; width: parent.width / 2; height: width; scale: 0.75; anchors.rightMargin: dp(10); anchors.verticalCenter: parent.verticalCenter; source: userData.profile_Pic_URL; fillMode: Image.PreserveAspectCrop; radius: profileImage.width/2; img.autoTransform: true; smooth: true}
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
                        anchors.fill: parent; contentHeight: scrollRow.height + dp(Theme.navigationBar.height)*2; anchors.topMargin: scrollModel.height
                        Row {
                            id: scrollRow; width: parent.width
                            Column {
                                id: col; spacing: dp(5); width: parent.width/2
                                Repeater {
                                    id: evenModelView; model: sortedModelEven;
                                    delegate: AppCard {
                                        id: evenImage; width: (parent.width)-dp(2); margin: dp(5); paper.radius: dp(5); scale: 0.96;
                                        media: AppImage {
                                            width: parent.width; fillMode: Image.PreserveAspectFit; source: model.downloadUrl; autoTransform: true
                                            MouseArea {anchors.fill: parent; onPressAndHold:  PictureViewer.show(userProfilePage, model.downloadUrl); onReleased: PictureViewer.close()}
                                        }
                                        content: AppText{width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.post_description}
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
                                            MouseArea {anchors.fill: parent; onPressAndHold:  PictureViewer.show(userProfilePage, model.downloadUrl); onReleased: PictureViewer.close()}
                                        }
                                        content: AppText{width: parent.width; padding: dp(15); maximumLineCount: 2; elide: Text.ElideRight; wrapMode: Text.Wrap; text: model.post_description}
                                    }
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
                            AppText {text: userData.bio; padding: dp(20); width: parent.width}
                            SimpleSection {title: "Specialitites:"}
                            Column {width: parent.width; Repeater {model: userData.specialities; AppText {padding: dp(20); text: "\u{2022} " +modelData}}}
                            SimpleSection {title: "Details:"}
                            Column {width: parent.width; Repeater {model: Object.keys(userData.measurements); delegate: SimpleRow {text: Object.keys(userData.measurements)[index] + ": "+Object.values(userData.measurements)[index];showDisclosure: false }}}
                        }
                    }
                }
            }
        }
    }
}
