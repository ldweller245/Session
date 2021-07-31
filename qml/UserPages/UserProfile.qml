import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4


Page {
    id: userProfilePage

    property var selectedView: singleColumnButton

    JsonListModel {
        id: jsonModel
        source: userData.measurements
        fields: ["height", "shoe", "waist"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: {sourceModel = jsonModel}
        proxyRoles: ExpressionRole {
            name: "measurements"
        }
    }

    Column {
        anchors.fill: parent
        spacing: 10

        Column {
            id: profileColumn
            width: parent.width
            height: parent.height / 3
            Rectangle {
                width: parent.width
                height: parent.height
                Row {
                    id: profileRow
                    anchors.fill: parent

                    Rectangle {
                        height: profileRow.height
                        width: profileRow.width / 2
                        Column {
                            id: detailsRow
                            anchors.verticalCenter: parent.verticalCenter
                            AppText {
                                id: profileName
                                padding: dp(15)
                                text: "<b>"+userData.firstname + "<br>" + userData.surname + "</b><br>" + userData.role
                            }
                            AppText {
                                fontSize: profileName.fontSize / 1.3
                                padding: dp(10)
                                color: "grey"
                                text: "<b>"+userData.location +"</b><br><b>Last Active:</b> " + new Date(userData.lastActive).toDateString()
                            }
                        }
                    }
                    RoundedImage  {
                        id: profileImage
                        width: parent.width / 2
                        height: width
                        scale: 0.75
                        anchors.rightMargin: dp(10)
                        anchors.verticalCenter: parent.verticalCenter
                        source: userData.profile_Pic_URL
                        fillMode: Image.PreserveAspectCrop
                        radius: profileImage.width/2
                    }
                }
            }
        }

        Column {
            id: userStatistics
            width: parent.width
            height: statRow.height
            Row {
                id: statRow
                width: parent.width
                AppButton {
                    width: parent.width/2
                    text: "<b>Follow"
                    flat: false
                    borderColor: "black"
                    backgroundColor: "white"
                    textColor: "black"
                    borderWidth: dp(1)
                    dropShadow: false
                }
                AppButton {
                    width: parent.width/2
                    text: "<b>Message"
                    flat: false
                    borderColor: "black"
                    backgroundColor: "white"
                    textColor: "black"
                    borderWidth: dp(1)
                    dropShadow: false
                }
            }
        }
        TabControl {
            id: tabControl
            width: parent.width
            height: parent.height -y
            NavigationItem {
                id: portfolioTab
                title: "PORTFOLIO"
                Item {
                    width: userProfilePage.width
                    AppFlickable {
                        id: userFeedFlickable
                        width: parent.width
                        height: parent.height
                        contentHeight: userFeed.height
                        Grid {
                            id: userFeed
                            spacing: dp(5)
                            width: parent.width
                            columns: selectedView === singleColumnButton ? 1 : 2
                            Repeater {
                                model: userData.feed_count
                                AppImage {MouseArea{anchors.fill: parent; onClicked: PictureViewer.show(userProfilePage, "https://static.wixstatic.com/media/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.webp")} width: selectedView === singleColumnButton ? parent.width : parent.width /2; fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.webp"}

                            }
                        }

                    }
                }
            }
            NavigationItem {
                title: "DETAILS"
                Item {
                    anchors.fill: parent
                    AppListView {
                        anchors.fill: parent
                        model: sortedModel
                        delegate: SimpleRow { text: model.height; showDisclosure: false }
                    }
                }
            }
        }
    }

    Row {
        z:10
        visible: tabControl.currentIndex === 0 ? true : false

        width: parent.width
        spacing: dp(8)
        height: singleColumnButton.height
        anchors.bottom: parent.bottom
        FloatingActionButton {
            id: singleColumnButton
            visible: true
            icon: IconType.squareo
            anchors.right: undefined
            onClicked: selectedView = singleColumnButton
            backgroundColor: selectedView === singleColumnButton ? "lightgrey" : "white"

        }
        FloatingActionButton {
            id: dualColumnButton
            visible: true
            icon: IconType.pause
            anchors.right: undefined
            onClicked: selectedView = dualColumnButton
            backgroundColor: selectedView === dualColumnButton ? "lightgrey" : "white"

        }
    }
}
