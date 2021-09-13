import QtQuick 2.0
import Felgo 3.0
import "../Plugins"

FlickablePage {
    id: viewCastingPage

    title: castingData.title
    flickable.contentHeight: contentCol.height
    scrollIndicator.visible: true

    property var castingDetails: 0

    property var castingData: dataModel.castingData

    onCastingDataChanged: {
        dataModel.getCasting(castingDetails)
    }
    Column {
        //id, location, details, title, image, date
        id: contentCol
        spacing: dp(12)
        width: parent.width
        Rectangle {
            width: parent.width; height: width
            AppImage {source: castingData.image; width: parent.width; height: Image.height; fillMode: Image.PreserveAspectFit}
        }
        AppText {text: castingData.title; padding: dp(12); width: parent.width}

        SimpleSection {title: "When:"}
        AppText {text: castingData.date; padding: dp(12); width: parent.width}
        SimpleSection {title: "Paid:"}
        AppText {text: castingData.paid === "Yes" ? castingData.compensation : "No"; padding: dp(12); width: parent.width}

        SimpleSection {title: "Seeking:"}
        Column {width: parent.width; Repeater {model: castingData.seeking; AppText {padding: dp(20); text: "\u{2022} " +modelData}}}

        SimpleSection {title: "Details:"}
        AppText {text: castingData.details; padding: dp(12); width: parent.width}

        SimpleSection {title: "Where:"}
        Column {
            width: parent.width
            AppText {id: eventAddress; text: castingData.loction; width: parent.width; height: Text.height}
            AppMap {
                id: eventMap; height: viewCastingPage.height / 2; width: parent.width; showUserPosition: true; zoomLevel: 13; plugin: MapBoxPlugin {}
                // check for user position initially when the component is created
                Component.onCompleted: {
                    if(userPositionAvailable)
                        center = userPosition.coordinate
                }
            }
        }
    }
    AppButton {
        anchors.bottom: parent.bottom;anchors.bottomMargin: dp(15); width: parent.width/2; minimumWidth: parent.width/2; flat: false; text: "Apply"; visible: castingData.owner.owner_id !== userData.id
        onClicked: {}
    }
}
