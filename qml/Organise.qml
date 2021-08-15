import QtQuick 2.0
import Felgo 3.0
import "ModalPages"

Page {
    id: organisePage

    title: "Organise"


    Rectangle {
        z:6
        anchors.fill: parent
        Grid {
            columns: 2
            anchors.fill: parent
            AppImage {
                source: "../assets/OrganiseIcons/ShootsIcon.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width/2
                height: parent.height/2
            }
            AppImage {
                source: "../assets/OrganiseIcons/CalendarIcons.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width/2
                height: parent.height/2
            }
            AppImage {
                source: "../assets/OrganiseIcons/CastingsIcon.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width/2
                height: parent.height/2
            }
            AppImage {
                source: "../assets/OrganiseIcons/InvoiceIcon.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width/2
                height: parent.height/2
            }
        }
    }

    AppFlickable {
        anchors.fill: parent; contentHeight: exploreColumn.height
        Column {
            id: exploreColumn; width: parent.width
            Rectangle {
                width: parent.width; height: organisePage.height / 4
                AppText {
                    id: setupText; width: parent.width; horizontalAlignment: Text.AlignHCenter; anchors.bottom: addIcon.top; anchors.bottomMargin: dp(15); text: "<b>Tap to set up a shoot"
                }
                IconButton {
                    id: addIcon; icon: IconType.plus; scale: 4; anchors.centerIn: parent; anchors.verticalCenterOffset: setupText.height;
                    onClicked: eventSetupModal.open()
                }
            }
            Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
            Rectangle {height: dp(Theme.navigationBar.height) /2; width: parent.width}
            AppText {text: "<b>My Shoots" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
            Repeater {
                model: 5
                AppCard {
                    id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
                    header: SimpleRow {
                        text: "BHA Avant Garde"; detailText: "Organiser: Katie Prescott"; enabled: false; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                        style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                    }
                    media: Rectangle {
                        width: parent.width; height: organisePage.height / 3
                        AppImage {width: parent.width; height: parent.height; fillMode: Image.PreserveAspectFit; source: "../assets/MapTest.PNG"}
                        AppButton{text: "View Map"; anchors.bottom: parent.bottom; anchors.right: parent.right; flat: false; anchors.margins: dp(15)}
                    }
                    actions: Row {
                        IconButton {icon: IconType.sharealt}
                        AppButton {text: "View Details"; flat: true; onClicked: viewEventModal.open()}
                    }
                }
            }
        }
    }
    AppModal {
        id: eventSetupModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ShootSetupModal {
                title: "Create Event"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: eventSetupModal.close()
                }
            }
        }
    }
    AppModal {
        id: viewEventModal; fullscreen: true; pushBackContent: navigationRoot
        NavigationStack {
            ViewEventDetails {
                title: "EVENT NAME"; clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: viewEventModal.close()
                }
            }
        }
    }
}
