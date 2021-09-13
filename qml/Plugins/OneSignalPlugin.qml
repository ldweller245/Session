import Felgo 3.0
import QtQuick 2.0

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use the plugin, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation: https://felgo.com/doc/plugin-onesignal/


  EXAMPLE USAGE:
  Add the following piece of code inside your main QML { } to display this example page.

  OneSignalPlugin {

  }

/////////////////////////////////////*/

Rectangle {
    anchors.fill: parent

    // Plugin Item - Define OneSignal once per app in GameWindow or App root component
    OneSignal {
        id: onesignal

        logLevel: OneSignal.LogLevelVerbose
        appId: "a23e646c-0d6f-4611-836e-5bf14ee96e98" // replace with your OneSignal appId
        googleProjectNumber: "522591647137" // replace with your googleProjectNumber

        onNotificationReceived: {
            console.debug("Received notification:", message, JSON.stringify(additionalData), isActive)
            // Possible actions:
            // - Read message from data payload and display a user dialog
            // - Navigate to a specific screen
            // - ...
        }

        onTagsReceived: {
            var tagStr = ""
            for(var tag in tags)
                tagStr += tag + " = " +tags[tag]

            if(tagStr != "")
                tagStr = "Current tags: "+tagStr
            else
                tagStr = "Current tags: no tags set"

            listModel.setProperty(5, "name", tagStr)
        }

        onUserIdChanged: {
            console.debug("Got OneSignal user id:", userId)
        }
    }

    // AppListView for Plugin Overview and Example Usage
    AppListView {
        id: listView
        anchors.fill: parent
        backgroundColor: parent.color

        // Plugin Overview
        header: Column {
            id: contentCol
            width: parent.width
            property real itemSpacing: dp(16)

            // Description Text
            Rectangle {
                width: parent.width
                height: descriptionText.height + 2 * contentCol.itemSpacing
                color: "lightgrey"
                AppText {
                    id: descriptionText
                    width: parent.width - 2 * contentCol.itemSpacing
                    text: "Integrate with OneSignal Push to send cross-platform push notifications."
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            // Spacer
            Item { width: parent.width; height: contentCol.itemSpacing }

            // Image of Code Sample
            Image {
                width: sourceSize.width * dp(1) * 0.75
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("code-onesignal.png")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Spacer
            Item { width: parent.width; height: contentCol.itemSpacing }

            // Detailed Description
            Rectangle {
                width: parent.width
                height: detailText1.height + 2 * contentCol.itemSpacing
                color: Qt.darker(Theme.tintColor, 4)
                AppText {
                    id: detailText1
                    width: parent.width - 2 * contentCol.itemSpacing
                    color: Theme.backgroundColor
                    text: "Increase Engagement"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: parent.width
                height: detailText2.height + 2 * contentCol.itemSpacing
                color: "lightgrey"
                AppText {
                    id: detailText2
                    width: parent.width - 2 * contentCol.itemSpacing
                    text: "Push notifications are a direct channel to your app's users. Keep them happy and engaged with app updates, promotions, and more sent directly to their device."
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: parent.width
                height: detailText3.height + 2 * contentCol.itemSpacing
                color: Qt.darker(Theme.tintColor, 4)
                AppText {
                    id: detailText3
                    width: parent.width - 2 * contentCol.itemSpacing
                    color: Theme.backgroundColor
                    text: "Targeted Push Notifications"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: parent.width
                height: detailText4.height + 2 * contentCol.itemSpacing
                color: "lightgrey"
                AppText {
                    id: detailText4
                    width: parent.width - 2 * contentCol.itemSpacing
                    text: "Send notifications to all users, a targeted segment or an individual user, thanks to push tags it has never been easier to send push notifications."
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            // Spacer
            Item { width: parent.width; height: contentCol.itemSpacing }

            // Image of Plugin Logo
            Image {
                width: sourceSize.width * dp(1) * 0.5
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("logo-onesignal.png")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Spacer
            Item { width: parent.width; height: contentCol.itemSpacing }

            // Example Headline
            Rectangle {
                width: parent.width
                height: exampleHeadline.height + 2 * contentCol.itemSpacing
                color: "lightgrey"
                AppText {
                    id: exampleHeadline
                    width: parent.width - 2 * contentCol.itemSpacing
                    text: "Example"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }
        }

        // Example Actions (Content of List)
        model: ListModel {
            id: listModel
            ListElement { section: "Notifications"; name: "Enable notifications"; clickable: true }
            ListElement { section: "Notifications"; name: "Disable notifications"; clickable: true }

            ListElement { section: "Tags"; name: "Set tag"; clickable: true }
            ListElement { section: "Tags"; name: "Remove tag"; clickable: true }
            ListElement { section: "Tags"; name: "Request tags"; clickable: true }
            ListElement { section: "Tags"; name: "Current tags: tags not yet requested"; clickable: false }
        }

        // Styling of ListView Delegate (List Items)
        delegate: SimpleRow {
            id: row
            text: name

            property bool isSelected: index === 0 && onesignal.enabled || index === 1 && !onesignal.enabled
            enabled: clickable === undefined || clickable

            Icon {
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.verticalCenter: parent.verticalCenter
                icon: IconType.check
                size: dp(14)
                color: row.style.textColor
                visible: isSelected
            }

            style.showDisclosure: false

            // Execute selected Action for plugin when list item is clicked
            onSelected: {
                if (index === 0) {
                    onesignal.enabled = true
                }
                else if (index === 1) {
                    onesignal.enabled = false
                }
                else if (index === 2) {
                    onesignal.sendTag("group", "test")
                    listModel.setProperty(5, "name", "Current tags: please request tags")
                }
                else if (index === 3) {
                    onesignal.deleteTag("group")
                    listModel.setProperty(5, "name", "Current tags: please request tags")
                }
                else if (index === 4) {
                    onesignal.requestTags()
                    listModel.setProperty(5, "name", "Current tags: requesting tags ...")
                }
            }
        }

        // Styling of List Sections
        section.property: "section"
        section.delegate: SimpleSection { }
    }
}
