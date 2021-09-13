import QtQuick 2.0
import Felgo 3.0
import "../Plugins"

FlickablePage {
    id: viewCastingPage

    title: castingData.title
    flickable.contentHeight: contentCol.height
    scrollIndicator.visible: true

    rightBarItem: TextButtonBarItem {visible: castingData.owner.owner_id === userData.id ; text: "Edit"; textItem.font.pixelSize: sp(16); onClicked: {/*edit casting*/}}


    signal updateCastingApplicant(var accept_Reject, var castingName, var castingID, var applicantName, var applicantPicture, var applicantID)

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
        anchors.bottom: parent.bottom;anchors.bottomMargin: dp(15); width: parent.width/2; minimumWidth: parent.width/2; flat: false; text: applicants.indexOf(userData.id) ? "WITHDRAW" : "APPLY"; visible: castingData.owner.owner_id !== userData.id
        onClicked: {let applicants = castingData.applications; applicants.indexOf(userData.id) ? viewCastingPage.updateCastingApplicant(false, castingData.title, castingData.id, userData.username, userData.id) : dataModel.castingApply(castingData.id, castingData.owner.id, castingData)}
        //add check for already applied
    }
    AppButton {
        anchors.bottom: parent.bottom;anchors.bottomMargin: dp(15); width: parent.width/2; minimumWidth: parent.width/2; flat: false; text: "View Applicants"; visible: castingData.owner.owner_id === userData.id
        onClicked: {viewApplicantModal.open()}
    }
    AppModal {
        id: viewApplicantModal
        pushBackContent: navigationRoot
        fullscreen: false
        modalHeight: viewCastingPage.height / 2
        NavigationStack {
            Page {rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: viewApplicantModal.close()}
                AppListView {
                    anchors.fill: parent
                    model: castingData.applications
                    delegate: SwipeOptionsContainer {
                        SimpleRow {
                            id: row
                            text: modelData.username
                            imageSource: modelData.picture
                            image.radius: image.width/2
                            image.fillMode: Image.PreserveAspectCrop
                            style: StyleSimpleRow {
                                showDisclosure: false
                                backgroundColor: "transparent"
                            }
                            onSelected: organiseStack.push(otherUserComp, {userID: modelData.id})
                        }
                        rightOption: Rectangle {
                            height: row.height; width: height
                            Row {
                                anchors.fill: parent
                                Rectangle {
                                    height: parent.height; width: parent.width/2; color: "red"
                                    Icon {anchors.fill: parent; icon: IconType.times}
                                    MouseArea {anchors.fill: parent; onClicked: {viewCastingPage.updateCastingApplicant(false, castingData.title, castingData.id, modelData.username, modelData.id)}}
                                }
                                Rectangle {
                                    height: parent.height; width: parent.width/2; color: "green"
                                    Icon {anchors.fill: parent; icon: IconType.check}
                                    MouseArea {anchors.fill: parent; onClicked: {viewCastingPage.updateCastingApplicant(true, castingData.title, castingData.id, modelData.username, modelData.id)}}
                                }

                            }
                        }
                    }
                }
            }
        }


    }
}
