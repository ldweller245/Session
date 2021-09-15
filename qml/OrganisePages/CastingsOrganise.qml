import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0

Page {

    id: castingPage
    title: "CASTINGS"

    readonly property real spacerH: dp(Theme.navigationBar.height)
    readonly property real spacerW: parent.width

    property var currentDate: new Date().getTime()

    property var jsonArray: Object.values(dataModel.allCastingData)

    JsonListModel {
        id: jsonModel
        source: jsonArray
        keyField: "id"
        fields: ["id", "created", "date", "details", "image", "location", "paid", "compensation", "owner", "seeking", "tag", "time", "title"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: {sourceModel = jsonModel}
        sorters: RoleSorter {roleName: "date"; ascendingOrder: true}
        filters: ExpressionFilter {id: castingDateFilter; expression: new Date(model.date).getTime() > currentDate; inverted: false; enabled: true}
    }
    Column {
        anchors.fill: parent
        Rectangle {width: spacerW; height: spacerH/2; color: "transparent"}
        AppText {text: "<b>Create Casting" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        Rectangle {
            width: spacerW; height: parent.height/6
            IconButton {
                anchors.fill: parent; icon: IconType.plus; scale: 2
                onClicked: organiseStack.push(createCastingPageBase)
            }
        }
        Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
        Rectangle {width: spacerW; height: spacerH/4; color: "transparent"}
        AppText {text: "<b>My Castings" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        TabControl {
            id: tabControl; width: parent.width; height: parent.height -y
            NavigationItem {
                id: myCastingsTab; title: "OPEN"; onSelected: {castingDateFilter.inverted = false}
                Item {
                    anchors.fill: parent
                    AppListView {
                        width: parent.width; height: parent.height; model: sortedModel
                        emptyText.text: "You have no castings yet!"
                        delegate: AppCard {
                            id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
                            header: SimpleRow {
                                text: model.title; detailText: new Date(model.date).toDateString()
                                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                                onSelected: {organiseStack.push(viewCastingPage, {castingDetails: castingDetails})}
                            }
                            media: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.image; MouseArea {anchors.fill: parent; onClicked: organiseStack.push(viewCastingPage, {castingDetails: model.id})}}
                            content: AppText{width: parent.width; padding: dp(15); text: model.details; maximumLineCount: 3; elide: Text.ElideRight}
                            actions: Row {
                                AppButton {text: "View Details"; flat: true; onClicked: organiseStack.push(viewCastingPage, {castingDetails: model.id})}
                            }
                        }
                    }
                }
            }

            NavigationItem {
                id: expiredCastingsTab; title: "CLOSED"; onSelected: {castingDateFilter.inverted = true}
                Item {
                    anchors.fill: parent
                    AppListView {
                        width: parent.width; height: parent.height; model: sortedModel
                        emptyText.text: "You have no closed castings!"
                        delegate: AppCard {
                            id: card3; width: parent.width; margin: dp(15); paper.radius: dp(5)
                            header: SimpleRow {
                                text: model.title; detailText: new Date(model.date).toDateString()
                                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                                onSelected: {organiseStack.push(viewCastingPage, {castingDetails: castingDetails})}
                            }
                            media: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.image; MouseArea {anchors.fill: parent; onClicked: organiseStack.push(viewCastingPage, {castingDetails: model.id})}}
                            content: AppText{width: parent.width; padding: dp(15); text: model.details; maximumLineCount: 2; elide: Text.ElideRight}
                            actions: Row {
                                AppButton {text: "View Details"; flat: true; onClicked: {console.log(model.id); organiseStack.push(viewCastingPage, {castingDetails: model.id})}}
                            }
                        }
                    }
                }
            }
        }
    }
}
