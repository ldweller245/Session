import Felgo 3.0
import QtMultimedia 5.9
import QtQuick 2.0
import "Components"
import "MessengerPages"
import "ModalPages"
import "SettingsPages"
import "SetupPages"
import "model"
import "Plugins"
import "UserPages"
import "CanvasTemplates"
import "OrganisePages"

App {
    id: app

    licenseKey: "8E04C2C81836FA28AAD7D933CE16F4F4E41FA5E7A2339BA7352E5045736E311653029D082BF368C2B1A8390EC6C5CB52DBA9F4BCF556483FB80E37D0B4653DF122DA40295DBDE0EAF7884CBDF706260754D9024014AFF76EA331071EF183F0BAFFE50B467C40F21E2E4159AC7F2C6DDF807FDF010A3E1052774A2F57C5461AAE12BA13F632CD8FCD537B65A4AFB574932B0194CEEAA09B4452FA48C08A3ADBDA52392E0911AAF6641C1B9FB0891DF1D7A7CF491A31FE5D325F3E2FBD86444E98F901E37878C6E061CD85C3D8851C8D45ECDBB1BC4F6E36EC8ADCA665B147B90F3B67C2B4F939997A41CB9488CC58121EE31269E36A7613E6C4F59920A95BDA3D46B8B8C31759587665AF62D5C4F2FEC00E479177B489D4D5368196AFF9B5B74909BCEAE6D2656C07D0565FE3D320B48695942CC06531DBB7F022BADB9BCA3614"

    onInitTheme: {
        Theme.navigationTabBar.titleColor = "black"
        Theme.navigationBar.backgroundColor = "#f8f8f8"
        Theme.navigationTabBar.backgroundColor = "#f8f8f8"
        Theme.navigationTabBar.titleOffColor = "#9e9e9e"
        Theme.navigationBar.titleColor = "black"
        Theme.colors.tintColor = "#000000"
        Theme.normalFont = arialFont
        Theme.iconFont = arialFont
        Theme.tabBar.backgroundColor = "white"
    }
    FontLoader {id: arialFont; source: "../fonts/Gravity-Book.otf"}

    property var imagePath
    property var imagePathID
    property var viewPostID
    property var exploreFilter: "Everything"
    property var otherUserID

    property var otherUserData: dataModel.otherUserJson[otherUserID]
    property var searchArr: [] //user search list

    property var userData: [] //logged in user data
    property var masterFeed: [] //filtered master feed
    property var userFeed: [] //users personal feed view

    property var timeTumblerSelection //time tumbler for event time

    //Variables for CREATE section, moodboards ect
    property var sliderValue
    property var currentRect: "none"

    property var rect1Imgsource
    property var rect2Imgsource
    property var rect3Imgsource
    property var rect4Imgsource
    property var rect5Imgsource
    property var rect6Imgsource
    property var rect7Imgsource
    property var rect8Imgsource
    property var rect9Imgsource
    property var rect10Imgsource
    property var rect11Imgsource
    property var rect12Imgsource

    property var rect1Scale: 0.9
    property var rect2Scale: 0.9
    property var rect3Scale: 0.9
    property var rect4Scale: 0.9
    property var rect5Scale: 0.9
    property var rect6Scale: 0.9
    property var rect7Scale: 0.9
    property var rect8Scale: 0.9
    property var rect9Scale: 0.9
    property var rect10Scale: 0.9
    property var rect11Scale: 0.9
    property var rect12Scale: 0.9
    //END OF VARIABLES FOR CREATE SEGMENT

    property var arr: [{"Hair": "Hairstylists"}, {"Makeup": "Makeup Artists"}, {"Wardrobe":"Clothes Stylists"}, {"Photographer": "Photographers"}, {"Model":"Models"},{"Studio": "Locations"}]

    DataModel {id: dataModel; onPostSuccess: postPage.team = []; onNameAvailable: registerPage.checkComplete()}
    LoadingPage {z: 25; id: loaderPage; visible: loaderPage.opacity > 0.1 ? true : false; Timer {interval: 7000; running: true; repeat: false; onTriggered: loaderAnim.start()}}
    InitialSetupPage {id: loginPage; z: 24; onLoginUser: dataModel.loginUser(email, password); onResetPassword: dataModel.resetPassword(email)}
    RegisterPage {z: 23; id: registerPage; visible: false; onRegisterUser: dataModel.registerUser(role, gender, firstname, surname, username, email, password, baseLocation, experience, tfp,specialities, age, heightCM, ethnicity, hairColor, hairLength, skinColor, eyeColor, shoeSize, waist, hips, inseam, suitSize, tattoo, piercing, profileImagePath,bio, bust,dressSize)}

    //Additional Menu Items
    Component {id: settingsComp;  SettingsPage {id: settingsNav}}
    Component {id: profileComp; UserProfile {id: profileNav}}
    Component {id: notificationComp; Notifications {id: notificationNav}}
    Component {id: inboxComp; Inbox {id: inboxNav}}

    //settings navigation
    Component {id: aboutComp; AboutSettings {id: aboutNav}}
    Component {id: accountComp; AccountSettings {id: accountNav}}
    Component {id: helpComp; HelpSettings {id: helpNav}}
    Component {id: notificationSettingsComp; NotificationSettings {id: notificationSettingsNav}}
    Component {id: privacyComp; PrivacySettings {id: privacyNav}}
    Component {id: securityComp; SecuritySettings {id: securityNav}}

    ParallelAnimation {
        id: loaderAnim
        NumberAnimation {target: loaderPage; properties: "opacity"; from: 1; to: 0; duration: 1000}
        NumberAnimation {target: loaderPage; properties: "scale"; from: 1; to: 0; duration: 1000}
    }

    Navigation {
        id: navigationRoot; navigationMode: navigationModeTabs
        NavigationItem {
            icon: IconType.compass; title: "Explore"
            NavigationStack {
                id: exploreStack; initialPage: initialComp
                Component {id: initialComp; HomePage {id: homePageNav; title: "EXPLORE"}}
                Component {id: viewPostComp; ViewPostModal {id: viewPostPage}}
                Component {id: otherUserComp; OtherUserProfile {id: otherUserNav}}
                Component {id: messageUserComp; ConversationPage {id: messageUserNav}}
            }
        }
        NavigationItem {
            icon: IconType.group; title: "Collaborate"
            NavigationStack {id: collabStack;  Collaborate { } }
        }
        NavigationItem {
            icon: IconType.cameraretro; title: "Post"
            NavigationStack {id: postStack; initialPage: postPageComp
                Component {id: postPageComp; PostPage {id: postPage; onPostImage: dataModel.createPost(postImagePath, imageHeight, imageWidth, imageDescription, team, location, tag)}}
                Component {id: postPreviewComp; PostPreview {id: postPreviewPage}}
            }
        }
        NavigationItem {
            icon: IconType.paintbrush; title: "Studio"
            NavigationStack {
                id: studioStack; initialPage: studioPageComp
                Component {id: studioPageComp; Create {id: studioPage } }
            }
        }
        NavigationItem {
            icon: IconType.book; title: "Organise"
            NavigationStack {
                id:organiseStack; initialPage: organiseComp
                Component {id: organiseComp; Organise {id: organiseNav}}
                Component {id:shootOrganisePage; ShootsOrganise {id: shootsOrganiseNav}}
                Component {id: calendarOrganisePage; CalendarOrganise {id: calendarOrganiseNav;
                        onAddCalendarItem: dataModel.addCalendarItem(date, name, time, location, details)
                        onEditCalendarItem: dataModel.editCalendarItem(date, name, time, location, details, id)
                        onDeleteCalendarItem: dataModel.removeCalendarItem(id)
                    }
                }
                Component {id: castingOrganisePage; CastingsOrganise {id: castingOrganiseNav}}
                Component {id: invoiceOrganisePage; InvoiceOrganise {id: invoiceOrganiseNav}}
                Component {id: viewCastingPage; ViewCastingPage {id: viewCastingNav; onUpdateCastingApplicant: dataModel.updateCastingApplicant(accept_Reject, castingName, castingID, name, id)}}
                Component {id: createCastingPageBase; CreateCasting {id: createCastingNav; onCreateCasting: dataModel.createCasting(title, seeking, location, date, time, details, image, paid, compensation)}}

                Component {id: shootSetupPage; EventSetupPage {id: shootSetupNav}} //base page for creating shoot
                Component {id: shootOverviewPage; EventOverviewPage {id: shootOverviewNav}}
                Component {id: shootConceptPage; EventConceptPage {id: shootConceptNav}}
                Component {id: shootLocationPage; EventLocationPage {id: shootLocationNav}}
                Component {id: shootTeamPage; EventTeamPage {id: shootTeamNav}}
            }
        }
        NavigationItem {icon: IconType.ellipsisv; title: "More"
        }
    }

    Column {
        id: floatingColumn; z: 5; spacing: dp(5); width: settingsButton.width; height: settingsButton.height * 4; anchors.right: parent.right; anchors.bottom: moreClickable.top; anchors.bottomMargin: dp(Theme.navigationTabBar.height) / 2; anchors.rightMargin: dp(3); visible: false; enabled: !animation.running
        FloatingActionButton {
            id: settingsButton; icon: IconType.cog; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {settingsModal.open(); floatingColumn.visible = false}}
        FloatingActionButton {
            id: userProfileButton; icon: IconType.user; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {profileModal.open(); floatingColumn.visible = false}}
        FloatingActionButton {
            id: notificationButton; icon: IconType.heart; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {notificationModal.open(); floatingColumn.visible = false}}
        FloatingActionButton {
            id: inboxButton; icon: IconType.envelope; visible: true; anchors.right: undefined; anchors.bottom: undefined
            onClicked: {inboxModal.open(); floatingColumn.visible = false}}
    }
    MouseArea {
        id: moreClickable; width: navigationRoot.width/6; height: dp(Theme.navigationTabBar.height); anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom // take care of potential safearea (e.g. iPhone 10 and up)
        onClicked: {console.log("clicked"); floatingColumn.visible === true ? floatingColumn.visible = false : floatingColumn.visible = true; animation.start()}
    }
    ParallelAnimation {
        id: animation
        NumberAnimation {target: floatingColumn; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}
        NumberAnimation {target: settingsButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: userProfileButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: notificationButton; property: "rotation"; from: 0; to: 360; duration: 1000}
        NumberAnimation {target: inboxButton; property: "rotation"; from: 0; to: 360; duration: 1000}
    }

    AppModal {
        id: profileModal; pushBackContent: navigationRoot
        NavigationStack {
            UserProfile {title: "PROFILE"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: profileModal.close()}}
        }
    }
    AppModal {
        id: inboxModal; pushBackContent: navigationRoot
        NavigationStack {
            Inbox {title: "MESSAGES"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: inboxModal.close()}}
        }
    }
    AppModal {
        id: notificationModal; pushBackContent: navigationRoot
        NavigationStack {
            Notifications {title: "NOTIFICATIONS"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: notificationModal.close()}}
        }
    }
    AppModal {
        id: settingsModal; pushBackContent: navigationRoot
        NavigationStack {
            SettingsPage {onLogoutUser: {dataModel.logoutUser(); console.log("mainlogoutuser")} title: "SETTINGS"; rightBarItem: TextButtonBarItem {text: "Close"; textItem.font.pixelSize: sp(16); onClicked: settingsModal.close()}}
        }
    }
}
