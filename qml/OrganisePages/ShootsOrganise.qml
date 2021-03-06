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
        Rectangle {
            id: headerRect; width: organisePage.width; height: organisePage.height / 4; color: "white"
        Column {
            anchors.fill: parent
            spacing: 1.4
            Rectangle {width: parent.width; height: parent.height*0.1; color: "white"}
            AppText {id: setupText; width: parent.width; height: parent.height*0.1 ; horizontalAlignment: Text.AlignHCenter; text: "<b>Tap to set up a shoot"}
            IconButton {
                id: addIcon; icon: IconType.plus; scale: 2; anchors.horizontalCenter: parent.horizontalCenter; height: parent.height*0.4
                onClicked: organiseStack.push(shootSetupPage, {pageEditable: true})
            }
            Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
            Rectangle {width: parent.width; height: parent.height*0.1; color: "white"}
            AppText {text: "<b>My Shoots" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); height: parent.height*0.1}
            Rectangle {width: parent.width; height: parent.height*0.1; color: "white"}

        }
        }
    }

    AppListView {
        anchors.fill: parent; header: headerComp; headerPositioning: ListView.PullBackHeader
        model: sortedModel; emptyText.text: "You have no events!"
        delegate: AppCard {
            id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
            header: SimpleRow {
                text: model.eventName; detailText: new Date(model.eventDate).toDateString(); image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop; onSelected: organiseStack.push(shootSetupPage,{pageEditable: false, eventID: model.id})
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}

            }
            media: Rectangle {
                width: parent.width; height: organisePage.height / 3
                AppImage {width: parent.width; height: parent.height; fillMode: Image.PreserveAspectFit; source: model.coverImage !== undefined ? model.coverImage : "../../assets/SESSIONlogo.png"}
                AppButton{text: "View Map"; anchors.bottom: parent.bottom; anchors.right: parent.right; flat: false; anchors.margins: dp(15)}
            }
            actions: Row {
                IconButton {icon: IconType.sharealt}
                AppButton {text: "View Details"; flat: true; onClicked: organiseStack.push(shootSetupPage, {pageEditable: false, eventID: model.id})}
            }
        }
    }
}
