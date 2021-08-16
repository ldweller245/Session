import QtQuick 2.0
import Felgo 3.0
import "ModalPages"
import "OrganisePages"

Page {
    id: organisePage
    title: "ORGANISE"
    Rectangle {
        anchors.fill: parent
        Grid {
            columns: 2; anchors.fill: parent
            Rectangle {
                width: organisePage.width/2; height: organisePage.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(shootOrganisePage)}
                }
                AppImage {source: "../assets/OrganiseIcons/ShootsIcon.png"; anchors.fill: parent; fillMode: Image.PreserveAspectFit}
            }
            Rectangle {
                width: organisePage.width/2; height: organisePage.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(calendarOrganisePage)}
                }
                AppImage {source: "../assets/OrganiseIcons/CalendarIcons.png"; anchors.fill: parent; fillMode: Image.PreserveAspectFit}
            }
            Rectangle {
                width: organisePage.width/2; height: organisePage.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(castingOrganisePage)}
                }
                AppImage {source: "../assets/OrganiseIcons/CastingsIcon.png"; anchors.fill: parent; fillMode: Image.PreserveAspectFit}
            }
            Rectangle {
                width: organisePage.width/2; height: organisePage.height/2
                MouseArea {
                    anchors.fill: parent
                    onClicked: {console.log("clicked"); organiseStack.push(invoiceOrganisePage)}
                }
                AppImage {source: "../assets/OrganiseIcons/InvoiceIcon.png"; anchors.fill: parent; fillMode: Image.PreserveAspectFit}
            }
        }
    }
}
