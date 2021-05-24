import QtQuick 2.0
import QtQuick 2.11
import Felgo 3.0
import "Components"
import "ModalPages"

Page {
    id: page
    title: "Post"
    Column {
        id: col
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: (parent.height/10)*7
            AppCard {
                id: card3
                width: parent.width
                height: parent.height
                margin: dp(15)
                paper.radius: dp(5)

                // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
                header: SimpleRow {
                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-15-033-f1_670.jpeg"
                    text: "Katie Prescott"
                    detailText: "Hairstylist"

                    enabled: false
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
                    }
                }

                // For the media cell, we use a simple AppImage
                media: Rectangle {
                    width: parent.width
                    height: (parent.height/10)*4
                    color: "lightgrey"
                    Icon {
                        icon: IconType.upload
                        anchors.centerIn: parent
                        scale: 2
                    }


                    MouseArea {
                        anchors.fill: parent
                        onClicked: imagePickerModal.open()
                    }
                }

                // For the content cell, we use some placeholder text
                content: Item {
                    width: parent.width
                    height: dp(150)

                    // Background and bottom divider for the scrollable text field
                    Rectangle {
                      anchors.fill: parent
                      color: "#fff"

                      Rectangle {
                        width: parent.width
                        height: px(1)
                        anchors.bottom: parent.bottom
                        color: Theme.listItem.dividerColor
                      }
                    }

                    // Flickable for scrolling, with text field inside
                    AppFlickable {
                      id: flick
                      anchors.fill: parent
                      contentWidth: width
                      contentHeight: appTextEdit.height

                      AppTextEdit {
                        id: appTextEdit
                        width: parent.width
                        height: Math.max(appTextEdit.contentHeight, flick.height)
                        placeholderText: "Tell us about the look!"
                        verticalAlignment: TextEdit.AlignTop
                        // This enables the text field to automatically scroll if cursor moves outside while typing
                        cursorInView: true
                        cursorInViewBottomPadding: dp(25)
                        cursorInViewTopPadding: dp(25)
                        flickable: flick
                      }
                    }

                    ScrollIndicator {
                      flickable: flick
                    }
                  }

                // Some useless buttons to display in the actions cell
                actions: Row {
                    AppButton {
                        text: "ADD TEAM"
                        flat: true
                        enabled: false
                    }
                    IconButton {
                        icon: IconType.plus
                        onClicked: addTeamModal.open()
                    }
                }
            }
        }
        Rectangle {
            id: sourceGridHolder
            width: parent.width
            height: parent.height /10*3
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0) }
                        GradientStop { position: 0.43; color: Qt.rgba(0,0,0,0.30) }
                        GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.8) }
            }

            IconButton {
                z:5
                icon: IconType.expand
                anchors.right: parent.right
                anchors.top: parent.top
                onClicked: imagePickerModal.open()
            }
            Rectangle {
                anchors.fill: parent
                anchors.margins: dp(6)
                color: "#00000000"
                ImagePicker {
                    z:4
                    id: imagePicker
                    clip: true
                    columns: 2
                    anchors.fill: parent
                }
            }
        }
    }
    AppModal {
        id: imagePickerModal
        fullscreen: true
        pushBackContent: navigationRoot
        NavigationStack {
            ImagePickerPage {
                title: "CHOOSE IMAGE"
                clip: true
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: imagePickerModal.close()
                }
            }
        }
    }
    AppModal {
        id: addTeamModal
        fullscreen: false
        pushBackContent: navigationRoot
        modalHeight: page.height *0.8
        NavigationStack {
            AddTeamPostPage {
                title: "Add your team"
                rightBarItem: TextButtonBarItem {
                    text: "Done"
                    textItem.font.pixelSize: sp(16)
                    onClicked: addTeamModal.close()
                }
            }
        }
    }
}


