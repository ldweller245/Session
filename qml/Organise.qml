import QtQuick 2.0
import Felgo 3.0
import "ModalPages"
import "OrganisePages"

Page {
    id: organisePage

    title: "Organise"

    Rectangle {
        anchors.fill: parent
        Grid {
            columns: 2
            anchors.fill: parent
            Rectangle {
                width: parent.width/2
                height: parent.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(shootOrganisePage)}
                }
                AppImage {
                    source: "../assets/OrganiseIcons/ShootsIcon.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }
            Rectangle {
                width: parent.width/2
                height: parent.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(shootOrganisePage)}
                }
                AppImage {
                    anchors.fill: parent
                    source: "../assets/OrganiseIcons/CalendarIcons.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
            Rectangle {
                width: parent.width/2
                height: parent.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(shootOrganisePage)}
                }
                AppImage {
                    anchors.fill: parent
                    source: "../assets/OrganiseIcons/CastingsIcon.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
            Rectangle {
                width: parent.width/2
                height: parent.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(shootOrganisePage)}
                }
                AppImage {
                    anchors.fill: parent
                    source: "../assets/OrganiseIcons/InvoiceIcon.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
}
