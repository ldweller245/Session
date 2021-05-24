import QtQuick 2.0
import Felgo 3.0

Page {
    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: dp(Theme.navigationBar.height)/2
        }
        AppText {
            id: titleText
            width: parent.width
            padding: dp(15)
            horizontalAlignment: Text.AlignHCenter
            text: "Welcome! Let us know your role and we'll get you set up in a flash!"
        }
        Grid {
            columns: 2
            width: parent.width
            height: parent.height - titleText.height
            spacing: dp(5)
            scale: 0.8
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.scissors
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Hairdresser"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.cameraretro
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Photographer"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.mapmarker
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Location"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.paintbrush
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Makeup Artist"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.user
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Model"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                color: "white"
                IconButton {
                    icon: IconType.usersecret
                    anchors.fill: parent
                    scale: 4
                }
                AppText {
                    text: "Clothes Stylist"
                    width: parent.width
                    anchors.bottom: parent.bottom
                    padding: dp(15)
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

}
