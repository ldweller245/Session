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

                }
                if(model.name === "Privacy") {

                }
                if(model.name === "Security"){

                }
                if(model.name === "Help"){

                }
                if(model.name === "About"){

                }
                if(model.name === "Notifications"){

                }
                if(model.name === "Logout"){
                    settingsPage.logoutUser(); console.log("logoutclicked")
                }
            }
        }
    }
}
