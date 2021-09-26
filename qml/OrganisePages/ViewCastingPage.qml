import QtQuick 2.0
import Felgo 3.0
import "../Plugins"

Page {
    id: viewCastingPage

    title: castingData.title
    rightBarItem: TextButtonBarItem {visible: castingData.owner.owner_id === userData.id ; text: "Edit"; textItem.font.pixelSize: sp(16); onClicked: {/*edit casting*/}}


    signal updateCastingApplicant(var accept_Reject, var castingName, var castingID, var applicantName, var applicantPicture, var applicantID)

    property var castingDetails: 0

    property var castingData: dataModel.castingData

    onCastingDetailsChanged: {
        console.log("castingDetails"+ castingDetails)
        dataModel.getCasting(castingDetails)
    }
    AppFlickable {
        anchors.fill: parent
        contentHeight: contentCol.height
        Column {
            //id, location, details, title, image, date
            id: contentCol
            spacing: dp(12)
            width: parent.width

            AppImage {source: castingData.image; width: viewCastingPage.width; height: Image.height; fillMode: Image.PreserveAspectFit}
            AppText {text: castingData.title; padding: dp(12); width: parent.width; horizontalAlignment: Text.AlignHCenter; font.bold: true}
            Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
            AppText {width: parent.width; text: "<b>When" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
            AppText {text: new Date(castingData.date).toDateString(); padding: dp(12); width: parent.width}
            AppText {width: parent.width; text: "<b>Paid" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)} //title
            AppText {text: castingData.paid === "Yes" ? castingData.compensation : "No/TFP"; padding: dp(12); width: parent.width}
            AppText {width: parent.width; text: "<b>Seeking" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)} //title
            Column {width: parent.width; Repeater {model: castingData.seeking; AppText {padding: dp(20); text: "\u{2022} " +modelData}}}
            AppText {width: parent.width; text: "<b>Details" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)} //title
            AppText {text: castingData.details; padding: dp(12); width: parent.width}
            AppText {width: parent.width; text: "<b>Where" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)} //title
            AppText {id: eventAddress; text: castingData.location; width: parent.width; height: Text.height; padding: dp(12)}
            Column {
                width: parent.width
                AppMap {
                    id: eventMap; height: viewCastingPage.height / 2; width: parent.width; showUserPosition: true; zoomLevel: 19; gesture.enabled: false; plugin: MapBoxPlugin {}
                    // check for user position initially when the component is created
                    Component.onCompleted: {
                        if(userPositionAvailable)
                            center = userPosition.coordinate
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: dp(Theme.navigationBar.height)
                color: "transparent"
            }
        }
    }
    AppButton {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(15)
        radius: dp(5)
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2; minimumWidth: parent.width/2
        flat: false
        text: {
            if(castingData.owner.owner_id === userData.id){
                "View Applicants"
            } else {
                castingData.applicants.indexOf(userData.id) ? "WITHDRAW" : "APPLY"
            }
        }
        onClicked: {
            if(castingData.owner.owner_id === userData.id){viewApplicantModal.open()}
            else {
                let applicants = castingData.applications; applicants.indexOf(userData.id) ? viewCastingPage.updateCastingApplicant(false, castingData.title, castingData.id, userData.username, userData.id) : dataModel.castingApply(castingData.id, castingData.owner.id, castingData)
            }
        }
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
