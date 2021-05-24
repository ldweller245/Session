import QtQuick 2.0
import Felgo 3.0
import "../TabBarPages"

Page {
    id: shootSetupModal

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: shootSetupModal.width
    property var jsonData: [{"id": 1, "name": "Katie", "role": "Hair"},{"id": 2,"name": "Jo", "role": "Hair"},{"id": 3,"name": "Tracey", "role": "Photography"},{"id": 4,"name": "Edward", "role": "Model"},{"id": 5,"name": "Turtle", "role": "Director"}]

    JsonListModel {
        id: jsonModel
        source: shootSetupModal.jsonData
        keyField: "id"
        fields: ["id", "name", "role"]
    }
    SortFilterProxyModel {
        id: sortedModel
        // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning sourceModel
        // use the Component.onCompleted handler instead to initialize SortFilterProxyModel
        Component.onCompleted: sourceModel = jsonModel
        sorters: StringSorter { id: typeSorter; roleName: "role"; ascendingOrder: true }
    }
    TabControl {
        anchors.fill: parent
        NavigationItem {
            title: "Overview"
            EventOverviewPage {
            }
        }
        NavigationItem {
            title: "Concept"
            ShootConceptPage {
            }
        }
        NavigationItem {
            title: "Location"
            EventLocationPage {
            }
        }
        NavigationItem {
            title: "Team"
            ShootTeamPage {
            }
        }
    }
}
