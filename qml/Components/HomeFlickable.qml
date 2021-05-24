import QtQuick 2.0
import Felgo 3.0
import "../ModalPages"

FlickablePage {
    id: item
    flickable.contentHeight: contentRow.height
    flickable.contentWidth: contentRow.width
    scrollIndicator.visible: false
    flickable.flickableDirection: AppFlickable.HorizontalFlick

    property var testImageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"

    Row {
        id: contentRow
        Repeater {
            model: 5
            Rectangle {
                height: (item.width / 10)*5
                width: (item.width / 10)*4
                AppImage {
                    width: parent.width
                    height: parent.height
                    scale: 0.8
                    fillMode: Image.PreserveAspectFit
                    source: testImageSource
                    MouseArea {
                        anchors.fill: parent
                        onClicked: viewPostModal.open()
                    }
                }
            }
        }
    }
    AppModal {
        id: viewPostModal
        pushBackContent: navigationRoot
        NavigationStack {
            ViewPostModal {
                id: exploreModalPage
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: viewPostModal.close()
                }
            }
        }

    }
}
