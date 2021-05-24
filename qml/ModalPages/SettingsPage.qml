import QtQuick 2.0
import Felgo 3.0

ListPage {
  id: settingsPage

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
      // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning sourceModel
      // use the Component.onCompleted handler instead to initialize SortFilterProxyModel
      Component.onCompleted: sourceModel = jsonModel
      sorters: StringSorter { id: typeSorter; roleName: "role"; ascendingOrder: true }
  }


  AppListView {
      anchors.fill: parent
      showSearch: true

      model: sortedModel
      delegate: SimpleRow {
          text: model.name
          iconSource: model.icon

      }

  }
}
