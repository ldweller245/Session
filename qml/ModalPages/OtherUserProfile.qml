import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: userProfilePage

    property var selectedView: singleColumnButton
    property int userFeedLength: otherUserData.feed_count

    signal updateList()

    title: otherUserData.username

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
                                padding: dp(10)
                                text: "<b>"+otherUserData.firstname + "<br>" + otherUserData.surname + "</b><br>" + otherUserData.role
                            }
                            AppText {
                                fontSize: profileName.fontSize / 1.3
                                padding: dp(10)
                                color: "grey"
                                text: "<b>"+otherUserData.location +"</b><br><b>Last Active:</b> " + new Date(otherUserData.lastActive).toDateString()
                            }
                            Row{
                                width: parent.width
                                AppButton {
                                    width: parent.width/2
                                    text: otherUserData.follows_user === true ? "<b>Following": "<b>Follow"
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
                    }
                    RoundedImage  {
                        id: profileImage
                        width: parent.width / 2
                        height: width
                        scale: 0.75
                        anchors.rightMargin: dp(10)
                        anchors.verticalCenter: parent.verticalCenter
                        source: otherUserData.profile_Pic_URL
                        fillMode: Image.PreserveAspectCrop
                        radius: profileImage.width/2
                    }
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
                    id: portfolioItem
                    width: userProfilePage.width
                    height: userProfilePage.height
                    AppFlickable {
                        contentHeight: grid.height
                        anchors.fill: parent
                        Grid {
                            id: grid
                            spacing: dp(3)
                            width: parent.width
                            columns: selectedView === singleColumnButton ? 1 :2
                            Repeater {
                                id: repeater
                                model: userFeedArr
                                Component.onCompleted: {
                                    populateView();
                                    userFeedArrChanged()
                                    console.log("create")
                                }
                                AppImage {
                                    id: postImage
                                    MouseArea{
                                        anchors.fill: parent;
                                        onClicked: PictureViewer.show(userProfilePage, postImage.source)
                                    }
                                    fillMode: Image.PreserveAspectFit;
                                    source: modelData
                                    width: selectedView === singleColumnButton ? parent.width : parent.width / 2
                                    Component.onDestruction: console.log("destroy")

                                }
                            }
                        }
                    }
                }
            }
            NavigationItem {
                title: "DETAILS"
                Item {
                    width: userProfilePage.width
                    height: userProfilePage.height
                    AppListView {
                        anchors.fill: parent
                        property var detailsData
                        property var sectionData
                        Component.onCompleted: {
                            detailsData = otherUserData.measurements
                        }
                        delegate: AppText {text: modelData}
                        section.property: Object.keys(detailsData)
                        section.delegate: SimpleSection {}
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
