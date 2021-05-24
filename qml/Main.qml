import Felgo 3.0
import QtQuick 2.0
import "../sketch.js" as Sketch
import "Components"
import "ModalPages"
import "SetupPages"

App {
    id: app


    onInitTheme: {
        Theme.navigationTabBar.titleColor = "black"
        Theme.navigationBar.backgroundColor = "#f8f8f8"
        Theme.navigationTabBar.backgroundColor = "#f8f8f8"
        Theme.navigationTabBar.titleOffColor = "#9e9e9e"
        Theme.navigationBar.titleColor = "black"
        Theme.colors.tintColor = "#000000"
        Theme.normalFont = arialFont
        Theme.tabBar.backgroundColor = "white"

    }
    FontLoader {
        id: arialFont
        source: "../fonts/Gravity-Book.otf" // loaded from your assets folder
    }

    property var imagePath

    Navigation {
        id: navigationRoot

        navigationMode: navigationModeTabs

        NavigationItem {
            icon: IconType.compass
            title: "Explore"

            NavigationStack {
                id: stack
                HomePage {
                }
            }
        }

        NavigationItem {
            icon: IconType.group
            title: "Collaborate"

            NavigationStack {
                Collaborate {
                }
            }
        }
        NavigationItem {
            icon: IconType.cameraretro
            title: "Post"
            NavigationStack {
                PostPage {

                }
            }
        }
        NavigationItem {
            icon: IconType.paintbrush
            title: "Studio"

            NavigationStack {
                Create {
                }
            }
        }
        NavigationItem {
            icon: IconType.book
            title: "Organise"

            NavigationStack {
                Organise {
                }
            }
        }
        NavigationItem {
            icon: IconType.ellipsisv
            title: "More"
        }
    }

    MouseArea {
        id: moreClickable
        width: navigationRoot.width/6
        height: dp(Theme.navigationTabBar.height)
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom // take care of potential safearea (e.g. iPhone 10 and up)
        onClicked: {
            floatingColumn.visible === true ? floatingColumn.visible = false : floatingColumn.visible = true
            animation.start()
        }
    }
    ParallelAnimation {
        id: animation
        NumberAnimation {
            target: floatingColumn
            property: "scale"
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InOutBack
        }
        NumberAnimation {
            target: settingsButton
            property: "rotation"
            from: 0
            to: 360
            duration: 1000
        }
        NumberAnimation {
            target: userProfileButton
            property: "rotation"
            from: 0
            to: 360
            duration: 1000
        }
        NumberAnimation {
            target: notificationButton
            property: "rotation"
            from: 0
            to: 360
            duration: 1000
        }
        NumberAnimation {
            target: inboxButton
            property: "rotation"
            from: 0
            to: 360
            duration: 1000
        }
    }

    Column {
        id: floatingColumn
        z: 5
        spacing: dp(5)
        width: settingsButton.width
        height: settingsButton.height * 4
        anchors.right: parent.right
        anchors.bottom: moreClickable.top
        anchors.bottomMargin: dp(Theme.navigationTabBar.height) / 2
        anchors.rightMargin: dp(3)
        visible: false

        enabled: !animation.running

        FloatingActionButton {
            id: settingsButton
            icon: IconType.cog
            visible: true
            anchors.right: undefined
            anchors.bottom: undefined
            onClicked: {settingsModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: userProfileButton
            icon: IconType.user
            visible: true
            anchors.right: undefined
            anchors.bottom: undefined
            onClicked: {profileModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: notificationButton
            icon: IconType.heart
            visible: true
            anchors.right: undefined
            anchors.bottom: undefined
            onClicked: {notificationModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: inboxButton
            icon: IconType.envelope
            visible: true
            anchors.right: undefined
            anchors.bottom: undefined
            onClicked: {inboxModal.open(); floatingColumn.visible = false}
        }
    }
    AppModal {
        id: profileModal
        // Set your main content root item
        pushBackContent: navigationRoot

        // Add any custom content for the modal
        NavigationStack {
            UserProfile {
                title: "Profile"
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: profileModal.close()
                }
            }
        }
    }
    AppModal {
        id: inboxModal
        // Set your main content root item
        pushBackContent: navigationRoot

        // Add any custom content for the modal
        NavigationStack {
            Inbox {
                title: "Messages"
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: inboxModal.close()
                }
            }
        }
    }
    AppModal {
        id: notificationModal
        // Set your main content root item
        pushBackContent: navigationRoot

        // Add any custom content for the modal
        NavigationStack {
            Notifications {
                title: "Notifications"
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: notificationModal.close()
                }
            }
        }
    }
    AppModal {
        id: settingsModal
        // Set your main content root item
        pushBackContent: navigationRoot

        // Add any custom content for the modal
        NavigationStack {
            SettingsPage {
                title: "Settings"
                rightBarItem: TextButtonBarItem {
                    text: "Close"
                    textItem.font.pixelSize: sp(16)
                    onClicked: settingsModal.close()
                }
            }
        }
    }
}
