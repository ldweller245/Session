import QtQuick 2.0
import Felgo 3.0
import "../ModalPages"

Page {
    id: organisePage

    title: "EVENTS"

    property var jsonArray: Object.values(userData.shoots)

    JsonListModel {
        id: jsonModel
        source: jsonArray
        keyField: "id"
        fields: ["id", "eventCreator", "eventName", "eventDate", "eventTime", "keyContacts", "overview", "coverImage", "moodboard", "location", "team"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: {sourceModel = jsonModel}
        sorters: RoleSorter {roleName: "eventDate"}

    }


    Component {
        id: headerComp
        Column {
            width: organisePage.width; height: organisePage.height / 4
            AppText {
                id: setupText; width: parent.width; horizontalAlignment: Text.AlignHCenter; text: "<b>Tap to set up a shoot"
            }
            IconButton {
                id: addIcon; icon: IconType.plus; scale: 4;
                onClicked: organiseStack.push(shootSetupPage, {pageEditable: true})
            }
            Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
            Rectangle {height: dp(Theme.navigationBar.height) /2; width: parent.width}
            AppText {text: "<b>My Shoots" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); }
        }
    }

    AppListView {
        width: parent.width; height: parent.height; header: headerComp; headerPositioning: ListView.PullBackHeader
        model: sortedModel; emptyText.text: "You have no events!"
        delegate: AppCard {
            id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
            header: SimpleRow {
                text: "BHA Avant Garde"; detailText: "Organiser: Katie Prescott"; enabled: false; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
            media: Rectangle {
                width: parent.width; height: organisePage.height / 3
                AppImage {width: parent.width; height: parent.height; fillMode: Image.PreserveAspectFit; source: "../../assets/MapTest.PNG"}
                AppButton{text: "View Map"; anchors.bottom: parent.bottom; anchors.right: parent.right; flat: false; anchors.margins: dp(15)}
            }
            actions: Row {
                IconButton {icon: IconType.sharealt}
                AppButton {text: "View Details"; flat: true; onClicked: organiseStack.push(shootSetupPage, {pageEditable: false, eventID: model.id})}
            }
        }
    }
    AppModal {
        id: eventSetupModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ShootSetupModal {
                title: "CREATE EVENT"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: eventSetupModal.close()
                }
            }
        }
    }
    AppModal {
        id: viewEventModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ViewEventDetails {
                title: "EVENT NAME"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: viewEventModal.close()
                }
            }
        }
    }
}
