import QtQuick 2.5
import QtLocation 5.5
import QtPositioning 5.5
import Felgo 3.0
import QtLocation 5.12 as QL
import QtPositioning 5.12
import "../Plugins"
import "../Components"

Page {
    id: locationItem

    property var tabIndex: tabControl.currentIndex
    onTabIndexChanged: {
        eventLocation = searchTextField.text
        //change to lon/lat coords
    }

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: locationItem.width

    AppFlickable {
        anchors.fill: parent
        contentHeight: pageEditable === true ? addLocationCol.height : mapCol.height
        Column {
            //add location
            id: addLocationCol
            width: parent.width; visible: pageEditable
            Rectangle {width: spacerW; height: spacerH}
            Item {
                width: parent.width; height: searchTextField.displayText.length > 0 ? dp(Theme.navigationBar.height)*2 + suggestionsList.height : dp(Theme.navigationBar.height)*2
                Column {
                    anchors.fill: parent; z:5; height: searchTextField.height + suggestionsList.height; width: parent.width
                    AppTextField {
                        id: searchTextField; width: parent.width; anchors.horizontalCenter: parent.horizontalCenter; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Add Location")
                        onAccepted: {focus = false; if (text != "") {geocodeModel.query = text}}
                        onDisplayTextChanged: {
                            if (searchTextField.displayText.length > 2 && searchTextField.focus) {
                                suggenstionModel.searchTerm = searchTextField.displayText.toString();suggenstionModel.update()}
                            else if(searchTextField.displayText.length === 0) {suggestionsList.hide()}
                        }
                        onFocusChanged: {if (!focus) {suggestionsList.hide()}}
                        Component.onCompleted: {font.pixelSize = sp(16)}
                    }
                    SuggestionsList {
                        id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel; anchors {horizontalCenter: parent.horizontalCenter}
                        onProposalSelected: {searchTextField.focus = false; searchTextField.text = suggestion; geocodeModel.query = suggestion}
                    }
                }
            }

            Rectangle {
                width: parent.width; height: width
                AppMap {
                    anchors.fill: parent
                    center: QtPositioning.coordinate(51.477928, -0.001545)
                    zoomLevel: 19
                    plugin: MapBoxPlugin {}
                }
            }
        }
        Column {
            //view location
            id: mapCol
            width: parent.width
            visible: !pageEditable
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Location: <br>" + shootData.location; padding: dp(15); width: parent.width; height: Text.height}
            Rectangle {
                width: parent.width; height: width
                AppMap {
                    anchors.fill: parent
                    center: QtPositioning.coordinate(51.477928, -0.001545)
                    zoomLevel: 19
                    plugin: MapBoxPlugin {}
                }
            }
            Rectangle {width: spacerW; height: spacerH}
        }
    }

    QL.GeocodeModel {id: geocodeModel; plugin: MapBoxPlugin {geocoding: true} autoUpdate: true
        onLocationsChanged: {
            console.log("count: " + count)
            for(var i = 0; i < count; i++){
                var address = get(i).address
                var fullText
                fullText = "str: "+ address.street + " City: " + address.city + " Country: " + address.country

                console.log("get: " + fullText + "<br>")
            }
        }
    }
    QL.PlaceSearchModel {
        id: suggenstionModel; plugin:  MapBoxPlugin {geocoding: true}
        onStatusChanged: {if (status == QL.PlaceSearchSuggestionModel.Ready) {suggestionsList.show()}}
    }
}
