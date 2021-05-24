import QtQuick 2.0
import QtQuick.Controls 2.4
import Felgo 3.0
import "ModalPages"

Page {
    id: collabPage

    title: "Collaborate"

    Column {
        id: searchColumn
        width: parent.width
        height: parent.height
        spacing: dp(Theme.navigationBar.height)/2
        Rectangle {
            id: spacerRect
            width: parent.width
            height:
                dp(Theme.navigationBar.height) / 2
        }
        AppText {
            text: "<b>I AM SEEKING"
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
        Rectangle {
            width: parent.width
            height: searchGrid.height
            Grid {
                id: searchGrid
                spacing: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter
                /*hairstylist
               Makeup Artist
               Clothes Stylist
               Photographer
               Model
               Videographer
               Ltion */
                columns: 2
                AppCheckBox {
                    text: "Hair Stylist"

                }
                AppCheckBox {
                    text: "Makeup Artist"

                }
                AppCheckBox {
                    text: "Wardrobe"

                }
                AppCheckBox {
                    text: "Photographer"

                }
                AppCheckBox {
                    text: "Model"

                }
                AppCheckBox {
                    text: "Videographer"

                }
            }
        }
        Row {
            width: parent.width
            Rectangle {
                width: parent.width/2
                height: searchButton.height
                AppButton {
                    id: searchButton
                    text: "View Saved"
                    flat: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: savedModal.open()
                }
            }
            Rectangle {
                width: parent.width/2
                height: searchButton.height
                AppButton {
                    text: "Start Search"
                    flat: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: searchModal.open()
                }
            }
        }
        AppText {
            text: "<b>DISCOVER NEAR YOU"
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
        AppCard {
            id: card
            width: parent.width
            margin: dp(15)
            paper.radius: dp(5)
            swipeEnabled: true
            cardSwipeArea.rotationFactor: 0

            // If the card is swiped out, this signal is fired with the direction as parameter
            cardSwipeArea.onSwipedOut: {
                console.debug("card swiped out: " + direction)
            }

            // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
            header: SimpleRow {
                text: "Katie Prescott"
                detailText: "Hairstylist, London"
                enabled: false
                style: StyleSimpleRow {
                    showDisclosure: false
                    backgroundColor: "transparent"
                }
            }
            // For the media cell, we use a simple AppImage
            media: AppImage {
                width: parent.width
                height: width / 2
                fillMode: Image.PreserveAspectFit
                source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-13-032-f2-copy_670.jpeg"
            }
            // For the content cell, we use some placeholder text
            content: AppText{
                width: parent.width
                padding: dp(15)
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
                text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
            }
            // Some useless buttons to display in the actions cell
            actions: Row {
                AppButton {
                    text: "Follow"
                    flat: true
                }
            }
        }
    }

    AppModal {
        id: searchModal
        pushBackContent: navigationRoot
        fullscreen: true
        NavigationStack {
            SearchModal {
                title: "Search Users"
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: searchModal.close()
                }
            }
        }

    }
    AppModal {
        id: savedModal
        pushBackContent: navigationRoot
        fullscreen: true
        NavigationStack {
            SavedUsers {
                title: "Saved Users"
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: savedModal.close()
                }
            }
        }

    }

}
