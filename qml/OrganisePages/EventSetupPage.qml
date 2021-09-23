import QtQuick 2.0
import Felgo 3.0

Page {
    id: shootSetupModal

    signal createEvent(var eventName, var eventOrganiser, var eventDate, var eventTime, var everOverview, var coverImage, var eventConcept, var eventLocation, var eventTeam)

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: shootSetupModal.width
    property var jsonData: [{"id": 1, "name": "Katie", "role": "Hair"},{"id": 2,"name": "Jo", "role": "Hair"},{"id": 3,"name": "Tracey", "role": "Photography"},{"id": 4,"name": "Edward", "role": "Model"},{"id": 5,"name": "Turtle", "role": "Director"}]

    property var pageEditable: 0
    property var eventID: 0

    property var shootData: dataModel.shootData


    property var eventName
    property var coverImage
    property var eventDate
    property var eventTime
    property var eventDetails
    property var keyContact

    property var moodboards: []

    property var eventLocation

    property var hairArray: []
    property var makeupArray: []
    property var wardrobeArray: []
    property var photoArray: []
    property var modelArray: []

    property var team: []


    onEventIDChanged: {
        if(pageEditable === false) {
            dataModel.getEvent(eventID)
        }
    }
    Connections {
        target: nativeUtils
        onMessageBoxFinished: {if(accepted){shootSetupModal.createEvent(eventName, coverImage, eventDate, eventTime, eventDetails, eventLocation, moodboards, team)}}
    }

    rightBarItem: TextButtonBarItem {
        text: "Create Event"; textItem.font.pixelSize: sp(16); onClicked: {
             team = {"hair": shootSetupModal.hairArray,"makeup": shootSetupModal.makeupArray,"model": shootSetupModal.modelArray,"wardrobe": shootSetupModal.wardrobeArray,"photo": shootSetupModal.photoArray}

            if(eventName === undefined || coverImage === undefined || eventDate === undefined || eventTime === undefined || eventDetails === undefined) {
                nativeUtils.displayMessageBox(qsTr("We need at least the basic details to set up an event!"))
            }
            else if(moodboards.length === 0) {
                nativeUtils.displayMessageBox(qsTr("No Moodboards?"), qsTr("Are you sure you don't want to add moodboards & inspirations?"), 2)

            }
            else if(eventLocation === undefined) {
                nativeUtils.displayMessageBox(qsTr("Location?"), qsTr("Are you sure you don't want to add a location?"), 2)
            } else {
                shootSetupModal.createEvent(eventName, coverImage, eventDate, eventTime, eventDetails, eventLocation, moodboards, team)
            }
        }

    }

    TabControl {
        id: tabControl
        anchors.fill: parent
        onCurrentIndexChanged: {
            teamPage.tabIndex = currentIndex
            overViewPage.tabIndex = currentIndex
            locationPage.tabIndex = currentIndex
        }

        NavigationItem {
            id: eventOverview
            title: "Overview"
            EventOverviewPage {
                id: overViewPage

            }
        }
        NavigationItem {
            title: "Concept"
            EventConceptPage {
                id: conceptPage
            }
        }
        NavigationItem {
            title: "Location"
            EventLocationPage {
                id: locationPage
            }
        }
        NavigationItem {
            title: "Team"
            EventTeamPage {
                id: teamPage
            }
        }
    }
}
