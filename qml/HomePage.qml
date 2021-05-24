import QtQuick 2.0
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: page
    title: "EXPLORE"

    property var arr: ["Hairstylists", "Makeup Artists", "Clothes Stylists", "Photographers", "Models", "Videograpehrs", "Locations"]
    property var testImageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"

    AppFlickable {
        anchors.fill: parent
        contentHeight: content.height

        Column {
            id: content
            width: parent.width
            Rectangle {
                width: parent.width
                height: dp(Theme.navigationBar.height)
            }
            Repeater {
                id: repeater
                model: arr.length
                Rectangle {
                    width: parent.width
                    height: page.height /3
                    Column {
                        id: contentCol
                        width: parent.width
                        height: parent.height
                        AppText {
                            id: titleText
                            width: page.width
                            text: "<b>"+arr[index] + "&nbsp;&nbsp;&nbsp;>"
                            leftPadding: dp(15)
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    exploreModalPage.title = arr[index]
                                    exploreModal.open()
                                }
                            }
                        }
                        HomeFlickable {

                        }
                    }
                }
            }
        }
    }
    AppModal {
        id: exploreModal
        fullscreen: true
        pushBackContent: navigationRoot
        NavigationStack {
            Explore {
                id: exploreModalPage
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: exploreModal.close()
                }
            }
        }
    }
}
