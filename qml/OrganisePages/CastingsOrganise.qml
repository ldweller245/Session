import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0

Page {

    id: castingPage
    title: "Castings"

    readonly property real spacerH: dp(Theme.navigationBar.height)
    readonly property real spacerW: parent.width

    JsonListModel {
        id: jsonModel
        source: userData.castings
        keyField: "id"
        fields: ["id", "date", "details", "title", "image", "location", "paid", "compensation"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: {sourceModel = jsonModel}
        sorters: RoleSorter {roleName: "date"; ascendingOrder: true}
    }
    Column {
        anchors.fill: parent
        Rectangle {width: spacerW; height: spacerH; color: "transparent"}
        AppText {text: "<b>Create Casting" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        Rectangle {
            width: spacerW; height: parent.height/4
            IconButton {
                anchors.fill: parent
                icon: IconType.plus
                onClicked: organiseStack.push(createCastingPage)
            }
        }
        AppText {text: "<b>View My Castings" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        AppListView {
            width: parent.width; height: parent.height/2; model: sortedModel
            emptyText: "You have no castings yet!"
            delegate: AppCard {
                id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
                header: SimpleRow {
                    text: model.title; detailText: model.date; enabled: false
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                    onSelected: {organiseStack.push(viewCastingPage, {castingDetails: castingDetails})}
                }
                media: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.image}
                content: AppText{width: parent.width; padding: dp(15); text: model.details}
                actions: Row {
                    IconButton {icon: IconType.thumbsup}
                    IconButton {icon: IconType.sharealt}
                    AppButton {text: "View Details"; flat: true; onClicked: organiseStack.push(viewCastingPage, {castingDetails: model.id})}
                }
            }
        }
    }
}
