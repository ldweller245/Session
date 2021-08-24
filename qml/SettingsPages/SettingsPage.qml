import QtQuick 2.0
import Felgo 3.0

ListPage {
    id: settingsPage

    signal logoutUser()

    title: qsTr("Settings")

    property var settingsList: [{name: "Account Settings", icon: IconType.user}, {name: "Privacy", icon: IconType.lock}, {name: "Security", icon: IconType.shield}, {name: "Help", icon: IconType.lifebouy}, {name: "About", icon: IconType.info}, {name: "Notifications", icon: IconType.envelope}, {name: "Logout", icon: IconType.externallink}]

    JsonListModel {
        id: jsonModel
        source: settingsPage.settingsList
        keyField: "name"
        fields: ["name", "icon"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: sourceModel = jsonModel
        sorters: StringSorter { id: typeSorter; roleName: "role"; ascendingOrder: true }
    }
    AppListView {
        anchors.fill: parent; showSearch: true
        model: sortedModel
        delegate: SimpleRow {
            text: model.name; iconSource: model.icon
            onSelected: {
                if(model.name === "Account Settings") {
                    stack.push(accountComp)
                }
                if(model.name === "Privacy") {
                    stack.push(privacyComp)
                }
                if(model.name === "Security"){
                    stack.push(securityComp)
                }
                if(model.name === "Help"){
                    stack.push(helpComp)
                }
                if(model.name === "About"){
                    stack.push(aboutComp)
                }
                if(model.name === "Notifications"){
                    stack.push(notificationComp)
                }
                if(model.name === "Logout"){
                    settingsPage.logoutUser(); console.log("logoutclicked")
                }
            }
        }
    }
}
