import QtQuick 2.0
import Felgo 3.0

Page {
    id: teamItem
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

    Component {
        id: headerItem
        Rectangle {
            width: parent.width
            height: spacerH*2
            AppText {
                text: "Add Team:"
                padding: dp(15)
            }
        }
    }
    Column {
        id: contentCol
        width: parent.width
        AppText {
            padding: dp(15)
            text: "Hair:"
        }
        AppListView {
            width: parent.width
            height: hairRow.height
            header: headerItem
            delegate: SimpleRow {
                id: hairRow
            }
        }

        AppText {
            padding: dp(15)
            text: "Makeup:"
        }
        AppListView {
            width: parent.width
            header: headerItem
            delegate: SimpleRow {

            }
        }
        AppText {
            padding: dp(15)
            text: "Wardrobe:"
        }
        AppListView {
            width: parent.width
            header: headerItem
            delegate: SimpleRow {

            }
        }
        AppText {
            padding: dp(15)
            text: "Photography:"
        }
        AppListView {
            width: parent.width
            header: headerItem
            delegate: SimpleRow {

            }
        }
    }
}
