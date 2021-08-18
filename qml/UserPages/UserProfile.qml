import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Page {
    id: userProfilePage

    property var selectedView: singleColumnButton

    function isEven(n) {
        return n % 2 == 0;
    }

    function isOdd(n) {
        return Math.abs(n % 2) == 1;
    }

    JsonListModel {
        id: userJsonModel
        source: userData.feed_posts
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
                    width: userProfilePage.width
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
                                delegate: AppCard {
                                    id: card
                                    width: parent.width
                                    margin: dp(15)
                                    paper.radius: dp(5)

                                    // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                                    header: SimpleRow {
                                      imageSource: userData.profile_Pic_URL
                                      text: userData.username
                                      enabled: false
                                      image.radius: image.width/2
                                      image.fillMode: Image.PreserveAspectCrop
                                      style: StyleSimpleRow {
                                        showDisclosure: false
                                        backgroundColor: "transparent"
                                      }
                                    }
                                    // For the media cell, we use a simple AppImage
                                    media: AppImage {
                                      width: parent.width
                                      fillMode: Image.PreserveAspectFit
                                      source: model.downloadUrl
                                    }

                                    // For the content cell, we use some placeholder text
                                    content: AppText{
                                      width: parent.width
                                      padding: dp(15)
                                      text: model.post_description
                                    }

                                    // Some useless buttons to display in the actions cell
                                    actions: Row {
                                      IconButton {
                                        icon: IconType.thumbsup
                                      }
                                      IconButton {
                                        icon: IconType.sharealt
                                      }
                                      AppButton {
                                        text: "Follow"
                                        flat: true
                                      }
                                    }
                                  }
                            }
                            AppListView {
                                id: oddModelView
                                model: sortedModelOdd; emptyText.text: qsTr("No posts yet!"); scale: 0.96
                                width: parent.width/2; spacing: dp(5);scrollIndicatorVisible: false;
                                delegate: AppCard {
                                    id: card
                                    width: parent.width
                                    margin: dp(15)
                                    paper.radius: dp(5)

                                    // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                                    header: SimpleRow {
                                      imageSource: userData.profile_Pic_URL
                                      text: userData.username
                                      enabled: false
                                      image.radius: image.width/2
                                      image.fillMode: Image.PreserveAspectCrop
                                      style: StyleSimpleRow {
                                        showDisclosure: false
                                        backgroundColor: "transparent"
                                      }
                                    }
                                    // For the media cell, we use a simple AppImage
                                    media: AppImage {
                                      width: parent.width
                                      fillMode: Image.PreserveAspectFit
                                      source: model.downloadUrl
                                    }

                                    // For the content cell, we use some placeholder text
                                    content: AppText{
                                      width: parent.width
                                      padding: dp(15)
                                      text: model.post_description
                                    }

                                    // Some useless buttons to display in the actions cell
                                    actions: Row {
                                      IconButton {
                                        icon: IconType.thumbsup
                                      }
                                      IconButton {
                                        icon: IconType.sharealt
                                      }
                                      AppButton {
                                        text: "Follow"
                                        flat: true
                                      }
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
                            Column {width: parent.width; Repeater {model: Object.keys(userData.measurements); delegate: SimpleRow { text: Object.keys(userData.measurements)[index] + ": "+Object.values(userData.measurements)[index];showDisclosure: false }}}
                        }
                    }
                }
            }
        }
    }
    Row {
        z:10; visible: tabControl.currentIndex === 0 ? true : false; width: parent.width; spacing: dp(8); height: singleColumnButton.height; anchors.bottom: parent.bottom
        FloatingActionButton {id: singleColumnButton; visible: true; icon: IconType.squareo; anchors.right: undefined; onClicked: selectedView = singleColumnButton; backgroundColor: selectedView === singleColumnButton ? "lightgrey" : "white"}
        FloatingActionButton {id: dualColumnButton; visible: true; icon: IconType.pause; anchors.right: undefined; onClicked: selectedView = dualColumnButton; backgroundColor: selectedView === dualColumnButton ? "lightgrey" : "white"}
    }
}
