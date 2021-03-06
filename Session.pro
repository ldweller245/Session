# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.yourcompany.wizardEVAP.Session
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "8E04C2C81836FA28AAD7D933CE16F4F4E41FA5E7A2339BA7352E5045736E311653029D082BF368C2B1A8390EC6C5CB52DBA9F4BCF556483FB80E37D0B4653DF122DA40295DBDE0EAF7884CBDF706260754D9024014AFF76EA331071EF183F0BAFFE50B467C40F21E2E4159AC7F2C6DDF807FDF010A3E1052774A2F57C5461AAE12BA13F632CD8FCD537B65A4AFB574932B0194CEEAA09B4452FA48C08A3ADBDA52392E0911AAF6641C1B9FB0891DF1D7A7CF491A31FE5D325F3E2FBD86444E98F901E37878C6E061CD85C3D8851C8D45ECDBB1BC4F6E36EC8ADCA665B147B90F3B67C2B4F939997A41CB9488CC58121EE31269E36A7613E6C4F59920A95BDA3D46B8B8C31759587665AF62D5C4F2FEC00E479177B489D4D5368196AFF9B5B74909BCEAE6D2656C07D0565FE3D320B48695942CC06531DBB7F022BADB9BCA3614"

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

# RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST

    FELGO_PLUGINS += firebase


}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    qml/Canvas1x1.qml \
    qml/CanvasTemplates/Canvas2x2.qml \
    qml/CanvasTemplates/Canvas2x2_1.qml \
    qml/CanvasTemplates/Canvas2x2_2.qml \
    qml/CanvasTemplates/Canvas2x2_3.qml \
    qml/CanvasTemplates/Canvas2x2_4.qml \
    qml/CanvasTemplates/Canvas2x2_5.qml \
    qml/CanvasTemplates/Canvas3x1.qml \
    qml/CanvasTemplates/Canvas3x1_1.qml \
    qml/CanvasTemplates/Canvas3x2.qml \
    qml/CanvasTemplates/Canvas3x2_1.qml \
    qml/CanvasTemplates/Canvas3x2_2.qml \
    qml/CanvasTemplates/Canvas3x3.qml \
    qml/CanvasTemplates/Canvas4x4.qml \
    qml/CanvasTemplates/Canvas4x4_1.qml \
    qml/CanvasTemplates/Canvas4x4_2.qml \
    qml/CanvasTemplates/Canvas5x5.qml \
    qml/CanvasTemplates/Canvas5x5_1.qml \
    qml/CanvasTemplates/Canvas6x6_1.qml \
    qml/CanvasTemplates/Canvas6x6_2.qml \
    qml/Collaborate.qml \
    qml/Components/ConversationPage.qml \
    qml/Components/ImagePickerPage.qml \
    qml/Components/PlaceSearchSuggestionsPage.qml \
    qml/Components/SuggestionsList.qml \
    qml/Components/TimeTumbler.qml \
    qml/Components/UserSearchDropdown.qml \
    qml/Create.qml \
    qml/HomePage.qml \
    qml/Inbox.qml \
    qml/LoadingPage.qml \
    qml/ModalPages/AddTeamPostPage.qml \
    qml/ModalPages/OtherUserProfile.qml \
    qml/ModalPages/PostPreview.qml \
    qml/ModalPages/SavedUsers.qml \
    qml/ModalPages/SearchModal.qml \
    qml/ModalPages/SearchResults.qml \
    qml/ModalPages/ViewPostModal.qml \
    qml/Notifications.qml \
    qml/Organise.qml \
    qml/OrganisePages/CalendarOrganise.qml \
    qml/OrganisePages/CastingsOrganise.qml \
    qml/OrganisePages/CreateCasting.qml \
    qml/OrganisePages/EventConceptPage.qml \
    qml/OrganisePages/EventLocationPage.qml \
    qml/OrganisePages/EventOverviewPage.qml \
    qml/OrganisePages/EventSetupPage.qml \
    qml/OrganisePages/EventTeamPage.qml \
    qml/OrganisePages/InvoiceOrganise.qml \
    qml/OrganisePages/ShootsOrganise.qml \
    qml/OrganisePages/ViewCastingPage.qml \
    qml/Plugins/MapBoxPlugin.qml \
    qml/Plugins/OneSignalPlugin.qml \
    qml/Plugins/code-onesignal.png \
    qml/Plugins/logo-onesignal.png \
    qml/PostPage.qml \
    qml/SettingsPage.qml \
    qml/SettingsPages/AboutSettings.qml \
    qml/SettingsPages/AccountSettings.qml \
    qml/SettingsPages/HelpSettings.qml \
    qml/SettingsPages/NotificationSettings.qml \
    qml/SettingsPages/PrivacySettings.qml \
    qml/SettingsPages/SecuritySettings.qml \
    qml/SetupPages/InitialSetupPage.qml \
    qml/SetupPages/RegisterPage.qml \
    qml/UserProfile.qml \
    qml/model/DataModel.qml
