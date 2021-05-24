import QtQuick 2.0
import Felgo 3.0
import "../ModalPages"

Page {
    id: explorePage

    AppFlickable {
        anchors.fill: parent
        contentHeight: exploreColumn.height
        Column {
            id: exploreColumn
            width: parent.width
            AppCard {
                id: card
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
                    text: "Katie Prescott"
                    detailText: "Annroy Studios, London."

                    enabled: true
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                    onSelected: otherUserModal.open()
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Absolutely LOVED working with @Rankin with the @FAMEteam18 for our Rankin x Fame collab shoot!"
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }
            AppCard {
                id: card2
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-13-032-f2-copy_670.jpeg"
                    text: "Lorem ipsum"
                    detailText: "Ut enim ad minim veniam"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-13-032-f2-copy_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }
            AppCard {
                id: card3
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-15-033-f1_670.jpeg"
                    text: "Lorem ipsum"
                    detailText: "Ut enim ad minim veniam"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-15-033-f1_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }
            AppCard {
                id: card4
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-15-039-f1_670.jpeg"
                    text: "Lorem ipsum"
                    detailText: "Ut enim ad minim veniam"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-15-039-f1_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }
            AppCard {
                id: card5
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-17-002-f1_670.jpeg"
                    text: "Lorem ipsum"
                    detailText: "Ut enim ad minim veniam"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-17-002-f1_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }
            AppCard {
                id: card6
                width: parent.width
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-21-035-f2_670.jpeg"
                    text: "Lorem ipsum"
                    detailText: "Ut enim ad minim veniam"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: AppImage {
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-21-035-f2_670.jpeg"
                }

                // For the content cell, we use some placeholder text
                content: AppText{
                    width: parent.width
                    padding: dp(15)
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    IconButton {
                        icon: IconType.thumbsup
                    }
                    IconButton {
                        icon: IconType.sharealt
                    }
                    AppButton {
                        text: "Follow"
                        flat: true
                    }
                }
            }

        }
    }

    AppModal {
        id: otherUserModal
        fullscreen: true
        pushBackContent: navigationRoot
        NavigationStack {
            OtherUserProfile {
                id: userProfilePage
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: otherUserModal.close()
                }
            }
        }
    }
}
