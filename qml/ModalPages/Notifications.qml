import QtQuick 2.0
import Felgo 3.0

ListPage {
  id: page

  title: qsTr("Notifications")

  listView.emptyText.text: qsTr("No notifications")

  model: JsonListModel {
    id: listModel
    source: dataModel.messages
    keyField: "id"
  }

  delegate: SimpleRow {
    id: row
    item: listModel.get(index)

    /*onSelected: {
      console.debug("Selected item at index:", index)
      navigationStack.push(detailPageComponent, { tweet: row.item })
    }

    onProfileSelected: {
      console.debug("Selected profile at index:", index)
      navigationStack.push(profilePageComponent, { profile: row.item.user })
    }*/
  }
}
