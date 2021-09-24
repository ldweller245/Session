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

    property var selectedLocation: "search your location"


    property int mapTypeIndex: 6
    Column {
        anchors.fill: parent
        Rectangle {width: spacerW; height: spacerH / 2}
        AppText {width: parent.width; padding: dp(15); text: "<b>Location" + "&nbsp;&nbsp;&nbsp;>"}
        AppText {width: parent.width; height: Text.height; padding: dp(15); text: pageEditable ? selectedLocation : shootData.location.address}
        Rectangle {
            height: parent.height - y; width: parent.width
            AppMap {
                id: map
                anchors.fill: parent; activeMapType: supportedMapTypes[6]; zoomLevel: 19

                plugin: MapBoxPlugin {}

                QL.MapQuickItem {
                    id: marker
                    anchorPoint {x: sourceItem.width / 2; y: sourceItem.height}
                    sourceItem: Icon {icon: IconType.mapmarker; color: "black"; size: dp(30)}
                }
                Component.onCompleted: {
                    if(userPositionAvailable &&shootData.location.map === undefined){
                        center = userPosition.coordinate}
                    else {center = QtPositioning.coordinate(shootData.location.map) }
                }
            }

            QL.GeocodeModel {
                id: geocodeModel
                plugin: MapBoxPlugin {geocoding: true}
                autoUpdate: true
                onLocationsChanged: {map.center = get(0).coordinate; map.zoomLevel = 19; marker.coordinate = map.center}
            }

            QL.PlaceSearchModel {
                id: suggenstionModel
                plugin:  MapBoxPlugin {geocoding: true}
                onStatusChanged: {
                    if (status == QL.PlaceSearchSuggestionModel.Ready) {suggestionsList.show()}
                }
            }
            AppPaper {
                height: searchTextField.height + suggestionsList.height
                anchors {top: parent.top; topMargin: dp(10); left: parent.left; right: parent.right; margins: dp(10)}
                AppTextField {
                    id: searchTextField; width: parent.width; anchors.horizontalCenter: parent.horizontalCenter; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Search for place")
                    //Perform search when typed term is accepted
                    onAccepted: {
                        focus = false
                        if (text != "") {
                            geocodeModel.query = text
                        }
                    }
                    //Update suggestions model when typed text changed
                    onDisplayTextChanged: {
                        console.log()
                        if (searchTextField.displayText.length > 3 && searchTextField.focus) {
                            suggenstionModel.searchTerm = searchTextField.displayText.toString()
                            suggenstionModel.update()
                        }
                    }
                    //Hide suggestions when focus is lost
                    onFocusChanged: {if (!focus) {suggestionsList.hide()}}
                    Component.onCompleted: {font.pixelSize = sp(16)}
                }
                SuggestionsList {
                    id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel
                    anchors {top: searchTextField.bottom; horizontalCenter: parent.horizontalCenter}
                    onProposalSelected: {
                        searchTextField.focus = false
                        searchTextField.text = suggestion
                        geocodeModel.query = suggestion
                        selectedLocation = suggestion
                    }
                }
            }
        }
    }
}
