import Felgo 3.0
import QtQuick 2.0
import "../sketch.js" as Sketch
import "Components"
import "MessengerPages"
import "ModalPages"
import "SettingsPages"
import "SetupPages"
import "model"
import "Plugins"
import "UserPages"

App {
    id: app

    DataModel {
        id: dataModel
        onNameAvailable: registerPage.checkComplete()

        //onLoggedIn: regUser === true ? stack.push(setupPage) : stack.push(homePage)

    }
    LocationModel {
        id: locationModel
    }
    HomePage {
        id: homePage
    }
    HomeFlickable {
        id: homeFlickable
    }
    OtherUserProfile {
        id: otherUserProfile
        onUpdateList: userFeedArrChanged()
    }
    LoadingPage {
        z: 25
        id: loaderPage
        visible: loaderPage.opacity > 0.1 ? true : false
        Timer {
            interval: 7000
            running: true
            repeat: false
            onTriggered: loaderAnim.start()
        }
    }
    ParallelAnimation {
        id: loaderAnim
        NumberAnimation {
            target: loaderPage
            properties: "opacity"
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation {
            target: loaderPage
            properties: "scale"
            from: 1
            to: 0
            duration: 1000
        }
    }

    InitialSetupPage {
        id: loginPage
        z: 24
        onLoginUser: dataModel.loginUser(email, password)
        //onRegisterUser: dataModel.registerUser(role, gender, firstname, surname, username, email, password, baseLocation, experience, tfp,specialities, age, heightCM, ethnicity, hairColor, hairLength, skinColor, eyeColor, dressSize, shoeSize, waist, hips, bust, inseam, suitSize, tattoo, piercing, profileImagePath,bio)

        //onResetPassword: dataModel.resetPassword(email)
        /*onLogin: {
            if(isRegister) {
                dataModel.registerUser(email, password, firstname, surname, groupName, subGroupName)
            } else {
                dataModel.loginUser(email, password)
            }
        }*/
    }
    RegisterPage {
        z: 23
        id: registerPage
        visible: false
        onRegisterUser: dataModel.registerUser(role, gender, firstname, surname, username, email, password, baseLocation, experience, tfp,specialities, age, heightCM, ethnicity, hairColor, hairLength, skinColor, eyeColor, shoeSize, waist, hips, inseam, suitSize, tattoo, piercing, profileImagePath,bio, bust,dressSize)

    }

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
    FontLoader {id: arialFont; source: "../fonts/Gravity-Book.otf"}

    property var imagePath
    property var imagePathID
    property var viewPostID
    property var exploreFilter
    property var otherUserID

    property var userData: []
    property var otherUserData: dataModel.otherUserJson[otherUserID]
    property var discoverHair: dataModel.discover_hair
    property var feed: dataModel.otherUserJson[10].feed_posts
    property var feed2: Object.values(dataModel.feedJson)
    property var userFeedArr: []


    property var arr: [{"hair": "Hairstylists"}, {"makeup": "Makeup Artists"}, {"wardrobe":"Clothes Stylists"}, {"photo": "Photographers"}, {"model":"Models"},{"location": "Locations"}]

    property var testImageSource: []
    Component.onCompleted: {
        for(var i in discoverHair){
            for(var ia in discoverHair[i]){
                testImageSource.push(discoverHair[i][ia].display_url)
            }
        }
    }

    function populateView() {
        userFeedArr = []
        let posts = otherUserData.feed_posts
        for(var i in posts) {
            userFeedArr.push(posts[i].display_url)
        }
        console.log(userFeedArr)
    }

    Navigation {       
        id: navigationRoot; navigationMode: navigationModeTabs

        NavigationItem {            
            icon: IconType.compass; title: "Explore"
            NavigationStack {HomePage { } }
        }
        NavigationItem {
            icon: IconType.group; title: "Collaborate"
            NavigationStack { Collaborate { } }
        }
        NavigationItem {
            icon: IconType.cameraretro; title: "Post"
            NavigationStack { PostPage { } }
        }
        NavigationItem {
            icon: IconType.paintbrush; title: "Studio"
            NavigationStack { Create { } }
        }
        NavigationItem {
            icon: IconType.book; title: "Organise"
            NavigationStack { Organise { } }
        }
        NavigationItem {icon: IconType.ellipsisv; title: "More"}
    }




    MouseArea {
        id: moreClickable; width: navigationRoot.width/6; height: dp(Theme.navigationTabBar.height); anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom // take care of potential safearea (e.g. iPhone 10 and up)
        onClicked: {floatingColumn.visible === true ? floatingColumn.visible = false : floatingColumn.visible = true; animation.start()}
    }
    ParallelAnimation {
        id: animation
        NumberAnimation {target: floatingColumn; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}
        NumberAnimation {target: settingsButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: userProfileButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: notificationButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: inboxButton; property: "rotation"; from: 0; to: 360; duration: 1000}
    }

    Column {
        id: floatingColumn; z: 5; spacing: dp(5); width: settingsButton.width; height: settingsButton.height * 4; anchors.right: parent.right; anchors.bottom: moreClickable.top; anchors.bottomMargin: dp(Theme.navigationTabBar.height) / 2; anchors.rightMargin: dp(3); visible: false; enabled: !animation.running
        FloatingActionButton {
            id: settingsButton; icon: IconType.cog; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {settingsModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: userProfileButton; icon: IconType.user; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {profileModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: notificationButton; icon: IconType.heart; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {notificationModal.open(); floatingColumn.visible = false}
        }
        FloatingActionButton {
            id: inboxButton; icon: IconType.envelope; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {inboxModal.open(); floatingColumn.visible = false}
        }
    }
    AppModal {
        id: profileModal
        pushBackContent: navigationRoot
        NavigationStack {
            UserProfile {title: "Profile"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: profileModal.close()}}
        }
    }
    AppModal {
        id: inboxModal
        pushBackContent: navigationRoot
        NavigationStack {
            Inbox {title: "Messages"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: inboxModal.close()}}
        }
    }
    AppModal {
        id: notificationModal
        pushBackContent: navigationRoot
        NavigationStack {
            Notifications {title: "Notifications"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: notificationModal.close()}}
        }
    }
    AppModal {
        id: settingsModal
        pushBackContent: navigationRoot
        NavigationStack {
            SettingsPage {onLogoutUser: {dataModel.logoutUser(); console.log("mainlogoutuser")} title: "Settings"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: settingsModal.close()}}
        }
    }
}
