import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import Felgo 3.0
import "ModalPages"

Page {
    id: collabPage

    title: "COLLABORATE"

    JsonListModel {
        id: jsonModel
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: sourceModel = jsonModel
    }
    ExclusiveGroup {id: searchGroup}
    Component {
        id: headerComponent
        Column {
            id: searchColumn; width: collabPage.width; height: collabPage.height; spacing: dp(Theme.navigationBar.height)/2
            Rectangle {id: spacerRect; width: parent.width; height:dp(Theme.navigationBar.height) / 2}
            AppText {text: "<b>I AM SEEKING"; width: parent.width; horizontalAlignment: Text.AlignHCenter}
            Rectangle {
                width: parent.width; height: searchGrid.height
                Grid {
                    id: searchGrid; spacing: dp(5); anchors.horizontalCenter: parent.horizontalCenter; columns: 2
                    AppCheckBox {text: "Hair Stylist"; exclusiveGroup: searchGroup}
                    AppCheckBox {text: "Makeup Artist"; exclusiveGroup: searchGroup}
                    AppCheckBox {text: "Wardrobe"; exclusiveGroup: searchGroup}
                    AppCheckBox {text: "Photographer"; exclusiveGroup: searchGroup}
                    AppCheckBox {text: "Model"; exclusiveGroup: searchGroup}
                    AppCheckBox {text: "Videographer"; exclusiveGroup: searchGroup}
                }
            }
            Row {
                width: parent.width
                Rectangle {
                    width: parent.width/2; height: searchButton.height
                    AppButton {id: searchButton; text: "View Saved"; flat: false; anchors.horizontalCenter: parent.horizontalCenter; onClicked: savedModal.open()}
                }
                Rectangle {
                    width: parent.width/2; height: searchButton.height
                    AppButton {text: "Start Search"; flat: false; anchors.horizontalCenter: parent.horizontalCenter; onClicked: searchModal.open()}
                }
            }
            AppText {text: "<b>BROWSE CASTINGS"; width: parent.width; horizontalAlignment: Text.AlignHCenter}
        }
    }
    AppListView {
        anchors.fill: parent; header: headerComponent; headerPositioning: ListView.PullBackHeader; model: 30
        delegate: AppCard {
            id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
            header: SimpleRow {
                text: "Katie Prescott"; detailText: "Hairstylist, London"; enabled: false; style: StyleSimpleRow {
                    showDisclosure: false; backgroundColor: "transparent"
                }
            }
            media: AppImage {width: parent.width; height: width / 2; fillMode: Image.PreserveAspectFit; source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-13-032-f2-copy_670.jpeg"}
            content: AppText{width: parent.width; padding: dp(15); wrapMode: Text.WordWrap; maximumLineCount: 2; elide: Text.ElideRight; text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")}
            actions: Row {AppButton {text: "Follow"; flat: true}}
        }
    }
    AppModal {
        id: searchModal; pushBackContent: navigationRoot; fullscreen: true
        NavigationStack {
            SearchModal {
                title: "Search Users"; clip: true;
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: searchModal.close()
                }
            }
        }
    }
}
