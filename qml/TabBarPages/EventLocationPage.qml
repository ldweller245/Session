import QtQuick 2.5
import QtLocation 5.5
import QtPositioning 5.5
import Felgo 3.0
import "../Plugins"

Page {
    id: locationItem
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: locationItem.width
    Column {
        id: mapCol
        anchors.fill: parent

        Rectangle {width: spacerW; height: spacerH}

        AppText {
            text: "Location: <br>" + "Flat X, <br> Basque Court, <br> Garter Way, <br> London, <br> SE16 6xd"
            padding: dp(15)
            width: parent.width
            height: Text.height
        }
        Rectangle {
            width: parent.width
            height: width
            AppMap {
                anchors.fill: parent

                // Default location is Vienna, AT
                center: QtPositioning.coordinate(51.477928, -0.001545)
                zoomLevel: 10

                // Configure map provider
                plugin: MapBoxPlugin {}
              }
        }
    }
    Rectangle {width: spacerW; height: spacerH}


}
