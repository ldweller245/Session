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

    onEventIDChanged: {
        if(pageEditable === false) {
            dataModel.getEvent(eventID)
        }
    }

    TabControl {
        anchors.fill: parent
        NavigationItem {
            id: eventOverview
            title: "Overview"
            EventOverviewPage {
            }
        }
        NavigationItem {
            title: "Concept"
            EventConceptPage {
            }
        }
        NavigationItem {
            title: "Location"
            EventLocationPage {
            }
        }
        NavigationItem {
            title: "Team"
            EventTeamPage {
            }
        }
    }
}
