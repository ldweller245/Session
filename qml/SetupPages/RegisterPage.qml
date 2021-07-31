import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.1
import Felgo 3.0
import "../Components"


Page {
    id: registerPage

    signal registerUser(var role, var gender, var firstname, var surname, var username, var email, var password, var baseLocation, var experience, var tfp, var specialities, var age, var heightCM, var ethnicity, var hairColor, var hairLength, var skinColor, var eyeColor, var shoeSize, var waist, var hips, var inseam, var suitSize, var tattoo, var piercing, var profileImagePath, var bio,var bust,var dressSize)

    property var role
    property var gender: genderCombobox.currentText
    property var specialities: []
    property var profileImagePath
    property var maleMeasurements: []; property var femaleMeasurements: []

    ParallelAnimation {id: animation; NumberAnimation {target: titleText; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutBack}}
    NumberAnimation {id: pageReturnTransitionAnimation; target: loginPage; property: "x"; from: -app.width; to: 0; duration: 1000; easing.type: Easing.InOutBack}

    FloatingActionButton {
        id: floatingBack; z:15; visible: true; enabled: animation.running !== true; anchors.right: undefined; anchors.left: parent.left; anchors.leftMargin: dp(15);icon: IconType.arrowleft
        onClicked: {
            if(view.currentIndex !== 0) {if(role !== "Model" && view.currentIndex === 4){view.currentIndex = view.currentIndex-2}
                else {view.currentIndex = view.currentIndex-1}
                animation.start()}
            else {pageReturnTransitionAnimation.start()}
        }
    }
    FloatingActionButton {
        id: floatingForward; z:15; enabled: {view.currentIndex !== 4; animation.running !== true} visible: view.currentIndex !== 0; anchors.rightMargin: dp(15); icon: IconType.arrowright
        onClicked: {if(view.currentIndex !== 4){if(role !== "Model" && view.currentIndex === 2) {view.currentIndex = view.currentIndex +2; animation.start()}
                else {view.currentIndex = view.currentIndex+1; animation.start()}}
            else if(view.currentIndex === 4) {
                registerPage.registerUser(role, genderCombobox.currentText, firstnameTextEdit.text, surnameTextEdit.text, usernameTextEdit.text, emailTextEdit.text, passwordTextEdit.text, baseLocationTextEdit.text, experienceCombobox.currentText, tfpCombobox.currentText,specialities, Math.floor(slider.value), Math.floor(heightSlider.value), ethnicityCombobox.currentText, hairColorCombobox.currentText, hairLengthCombobox.currentText, skinColorCombobox.currentText, eyeColorCombobox.currentText, shoeSizeCombobox.currentText, waistCombobox.currentText, hipsCombobox.currentText, inseamCombobox.currentText, suitSizeCombobox.currentText, tattooCombobox.currentText, piercingCombobox.currentText, profileImagePath, appTextEditBio.text,bustCombobox.currentText,dressSizeCombobox.currentText)
            }
        }
    }

    Column {
        anchors.fill: parent
        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2}
        AppText {
            id: titleText
            width: parent.width; padding: dp(20); opacity: 1; horizontalAlignment: Text.AlignHCenter
            text: {if(view.currentIndex === 0){"Welcome! Let us know your role and we'll get you set up in a flash!"}
                else if(view.currentIndex === 1) {"Thanks! Now lets get your basic details."}
                else if(view.currentIndex === 2) {"Amazing, lets get your profile fleshed out!"}
                else if(view.currentIndex === 3) {"Tell us your measurements to be found through search easier!"}
                else if(view.currentIndex === 4) {"Last step! Show us who you are."}}
        }
        Item {
            width: parent.width; height: parent.height - (titleText.height + dp(Theme.navigationBar.height))
            SwipeView {
                id: view ; currentIndex: 0; anchors.fill: parent; interactive: false
                Item{
                    id: basePage
                    Grid {
                        columns: 2; anchors.fill: parent; spacing: dp(5); scale: 0.8
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white"
                            IconButton {
                                icon: IconType.cameraretro; anchors.fill: parent; scale: 1
                                onClicked: {role = "Photographer"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Photographer"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white"
                            IconButton {
                                icon: IconType.user; anchors.fill: parent; scale: 1
                                onClicked: {role = "Model"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Model"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white";
                            IconButton {
                                icon: IconType.scissors; anchors.fill: parent; scale: 1
                                onClicked: {role = "Hairdresser"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Hairdresser"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white"
                            IconButton {
                                icon: IconType.paintbrush; anchors.fill: parent; scale: 1
                                onClicked: {role = "mua"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Makeup Artist"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white"
                            IconButton {
                                icon: IconType.usersecret; anchors.fill: parent; scale: 1
                                onClicked: {role = "Wardrobe"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Clothes Stylist"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                        Rectangle {
                            width: parent.width / 2; height: width; color: "white"
                            IconButton {
                                icon: IconType.mapmarker; anchors.fill: parent; scale: 1
                                onClicked: {role = "Location"; view.currentIndex = 1; animation.start()}
                            }
                            AppText {text: "Location"; width: parent.width; anchors.bottom: parent.bottom; padding: dp(15); horizontalAlignment: Text.AlignHCenter}
                        }
                    }
                }
                Item {
                    id: userDetailsPage
                    Column {
                        anchors.margins: dp(12)
                        spacing: dp(12)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -dp(Theme.navigationBar.height)

                        GridLayout {
                            columnSpacing: dp(20)
                            rowSpacing: dp(15)
                            columns: 2

                            AppText {font.pixelSize: sp(12); text: "Gender: "}
                            ComboBox {id: genderCombobox; onCurrentTextChanged: gender = currentText; model: ["Male", "Female", "Other"]; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35)}

                            AppText {font.pixelSize: sp(12); text: "Firstname: "}
                            AppTextField {id:firstnameTextEdit; Layout.preferredWidth: dp(200); showClearButton: true; font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0}

                            AppText {font.pixelSize: sp(12); text: "Surname: "}
                            AppTextField {id:surnameTextEdit; Layout.preferredWidth: dp(200); showClearButton: true; font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0}

                            AppText {font.pixelSize: sp(12); text: "Username: "}
                            AppTextField {id:usernameTextEdit; Layout.preferredWidth: dp(200); showClearButton: true; font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0}

                            AppText {font.pixelSize: sp(12); text: "Email: "}
                            AppTextField {id:emailTextEdit; Layout.preferredWidth: dp(200); showClearButton: true; font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0; inputMode: inputModeEmail}

                            AppText {font.pixelSize: sp(12); text: "Password: "}
                            AppTextField {id:passwordTextEdit; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0; inputMode: inputModePassword}
                        }
                    }
                }
                Item {
                    id: additionalDetailsSetupPage
                    Column {
                        anchors.margins: dp(12)
                        spacing: dp(12)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -dp(Theme.navigationBar.height)
                        GridLayout {
                            columnSpacing: dp(20)
                            rowSpacing: dp(15)
                            columns: 2

                            AppText {font.pixelSize: sp(12); text: "Where are you based? "}
                            AppTextField {id:baseLocationTextEdit; Layout.preferredWidth: dp(100); showClearButton: true; font.pixelSize: sp(14); rightPadding: dp(35); borderColor: Theme.tintColor; borderWidth: !Theme.isAndroid ? dp(2) : 0}

                            AppText {font.pixelSize: sp(12); text: "Experience Level: "}
                            ComboBox {id: experienceCombobox; model: [ "none", "some", "experienced", "highly experience"]; Layout.preferredWidth: dp(100); font.pixelSize: sp(14); rightPadding: dp(35)}

                            AppText {font.pixelSize: sp(12); text: "Open TFP work? "}
                            ComboBox {id: tfpCombobox; Layout.preferredWidth: dp(100); font.pixelSize: sp(14); rightPadding: dp(35); model: [ "Yes", "No", "Depends on job"]}

                            Rectangle {width: registerPage.width; Layout.columnSpan: 2; height: dp(Theme.navigationBar.height/2)}

                            AppText {font.pixelSize: sp(14); text: "Choose your specialities or favourite areas to work in!"; Layout.columnSpan: 2; Layout.alignment: Qt.AlignHCenter}

                            Rectangle {width: registerPage.width; Layout.columnSpan: 2; height: dp(Theme.navigationBar.height/3)}


                            AppCheckBox {text: "Catwalk"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Portrait"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Film&Tv"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Session"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Fashion"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Fashion"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Fashion"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                            AppCheckBox {text: "Fashion"; labelFontSize: sp(14); Layout.preferredWidth: dp(80); onCheckedChanged:{specialities.push(text)}}
                        }
                    }
                }
                Item {
                    id: searchUserPage
                    AppFlickable {
                        id: searchUserFlickable
                        anchors.fill: parent; contentHeight: contentCol.height
                        Column {
                            id: contentCol;
                            anchors.margins: dp(12)
                            anchors.top: titleText.bottom
                            spacing: dp(12)
                            anchors.horizontalCenter: parent.horizontalCenter


                            GridLayout {
                                columnSpacing: dp(20)
                                rowSpacing: dp(15)
                                columns: 2

                                AppText {font.pixelSize: sp(12); text: "Age: "}
                                Column {
                                    AppSlider {id: slider; from: 18; to: 100}
                                    AppText {anchors.horizontalCenter: parent.horizontalCenter; text: Math.floor(slider.value)}
                                }

                                AppText {font.pixelSize: sp(12); text: "Height Range (cm): "}
                                Column {
                                    AppSlider {id: heightSlider; from: 0; to: 300}
                                    AppText {anchors.horizontalCenter: parent.horizontalCenter; text:Math.floor(heightSlider.value)+"cm"}
                                }

                                AppText {font.pixelSize: sp(12); text: "Ethnicity: "}
                                ComboBox {id: ethnicityCombobox; model: ["Arab", "Asian", "Black", "Mixed", "White", "Other"]; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35)}

                                AppText {font.pixelSize: sp(12); text: "Hair Colour: "}
                                ComboBox {id: hairColorCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); model: ["Black", "Blonde", "Brown", "Auburn", "Chesnut", "Copper", "Grey/White", "Other"]}

                                AppText {font.pixelSize: sp(12); text: "Hair Length: "}
                                ComboBox {id: hairLengthCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); model: ["Very Short", "Short", "Shoulder", "Long", "Very Long" ]}

                                AppText {font.pixelSize: sp(12); text: "Skin Colour: "}
                                ComboBox {id: skinColorCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); model: ["Extremely Fair", "Fair", "Medium", "Olive", "Brown", "Black" ]}

                                AppText {font.pixelSize: sp(12); text: "Eye Colour: "}
                                ComboBox {id: eyeColorCombobox;  Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); model: ["Brown", "Amber", "Hazel", "Green", "Blue" ]}

                                AppText {font.pixelSize: sp(12); text: "Dress: "; visible: gender !== "Male"}
                                ComboBox {id: dressSizeCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); model: ["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]; visible: gender !== "Male"}

                                AppText {font.pixelSize: sp(12); text: "Shoe: "}
                                ComboBox {
                                    id: shoeSizeCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35);
                                    model: gender === "Female" ?["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]
                                                               :["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]

                                }

                                AppText {font.pixelSize: sp(12); text: "Waist: "}
                                ComboBox {
                                    id: waistCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35);
                                    model: ["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]
                                }

                                AppText {font.pixelSize: sp(12); text: "Hips: "; visible: gender !== "Male"}
                                ComboBox {
                                    id: hipsCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); visible: gender !== "Male";
                                    model: ["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]
                                }

                                AppText {font.pixelSize: sp(12); text: "Bust: "; visible: gender !== "Male"}
                                ComboBox {
                                    id: bustCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); visible: gender !== "Male"
                                    model: ["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ];
                                }

                                AppText {font.pixelSize: sp(12); text: "Inseam: "; visible: gender !== "Female"}
                                ComboBox {
                                    id: inseamCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); visible: gender !== "Female"
                                    model: ["0", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26" ]
                                }

                                AppText {font.pixelSize: sp(12); text: "Suit Size: "; visible: gender !== "Female"}
                                ComboBox {
                                    id: suitSizeCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35); visible: gender !== "Female"
                                    model: ["34s", "34r", "34l","36s", "36r", "36l","38s", "38r", "38l", "40s", "40r", "40l", "42s", "42r", "42l", "44s", "44r", "44l", "46s", "46r", "46l", "48s", "48r", "48l", "50s", "50r", "50l", "52s", "52r", "52l",]
                                }

                                AppText {font.pixelSize: sp(12); text: "Tattoos: "}
                                ComboBox {
                                    id: tattooCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35)
                                    model: ["None", "Some", "Many" ]
                                }

                                AppText {font.pixelSize: sp(12); text: "Piercings: "}
                                ComboBox {
                                    id: piercingCombobox; Layout.preferredWidth: dp(200); font.pixelSize: sp(14); rightPadding: dp(35)
                                    model: ["None", "Some", "Many" ]
                                }
                            }
                        }
                    }
                }
                Item {
                    id: profileSetupPage
                    Column {
                        anchors.fill: parent
                        AppText {text: "Upload your profile picture!"; padding: dp(15)}
                        Item {
                            id: maskItem; width: parent.width; height: parent.height /3
                            Rectangle {
                                id: mask; width: height; height: parent.height; radius: width/2; color: "lightgrey"; anchors.horizontalCenter: parent.horizontalCenter
                                IconButton {icon: IconType.upload; onClicked: imagePickerModal.open(); visible: profilePictureImage.source !== undefined; enabled: profilePictureImage.source !== undefined; anchors.centerIn: parent; anchors.fill: parent}
                            }
                            AppImage {id: profilePictureImage; source: profileImagePath; autoTransform: true; smooth: true; anchors.fill: mask; anchors.centerIn: mask; visible: false; fillMode: Image.PreserveAspectCrop}
                            OpacityMask {anchors.fill: profilePictureImage; source: profilePictureImage; maskSource: mask}
                        }
                        AppText {text: "Bio:"; padding: dp(15)}
                        Rectangle {
                            width: parent.width; height: parent.height/2; border.color: "black"; color: "white"; border.width: dp(1); scale: 0.93; radius: 5
                            AppFlickable {
                                id: flick; anchors.fill: parent; contentWidth: width; contentHeight: appTextEditBio.height
                                AppTextEdit {
                                    id: appTextEditBio; width: parent.width; height: Math.max(appTextEditBio.contentHeight, flick.height); verticalAlignment: TextEdit.AlignTop; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); flickable: flick
                                    text: "Tell everyone about yourself!"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    AppModal {
        id: imagePickerModal; fullscreen: true; pushBackContent: navigationRoot
        Item {
            anchors.fill: parent
            Rectangle {
                width: parent.width; height: dp(Theme.navigationBar.height); z: imagePicker.z +1
                AppText {
                    text: "Save & Close"; anchors.right: parent.right; padding: dp(15)
                    MouseArea {anchors.fill: parent; onClicked: {imagePickerModal.close()}}
                }
            }

            ImagePicker {
                id: imagePicker; clip: true; columns: 2; anchors.fill: parent; maximumNumberOfSelection: 1
                onSelectedCountChanged: {console.log("SELECTION: " +selection); profileImagePath = selection.toString()}
            }
        }
    }
}
