import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0

Page {
    id: loginPage
    z: 24
    opacity: 1

    signal loginUser (var email, var password)

    NumberAnimation {
        id: pageTransitionAnimation
        target: loginPage
        property: "x"
        from: x
        to: -app.width
        duration: 1000
        easing.type: Easing.InOutBack
    }


    Column {
        anchors.fill: parent
        AppImage {width: parent.width; source: "../../assets/SESSIONlogo.png"; fillMode: Image.PreserveAspectFit}
        AppText {text: "Login or join our community."; width: parent.width; horizontalAlignment: Text.AlignHCenter}
        Rectangle {height: dp(Theme.navigationBar.height); width: parent.width}
        Rectangle {
            id: loginRect
            anchors.horizontalCenter: parent.horizontalCenter
            height: width
            color: "#424B54"
            state: "base"
            MouseArea {anchors.fill: parent; onClicked: loginRect.state === "base" ? loginRect.state = "clicked" : loginRect.state = "base"}
            AppText {
                id: loginText
                anchors.centerIn: parent
                text: "login"
                color: "white"
            }
            Column {
                anchors.margins: dp(12)
                spacing: dp(12)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -dp(Theme.navigationBar.height/ 2)
                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    id: loginCol
                    columnSpacing: dp(20)
                    rowSpacing: dp(10)
                    columns: 2
                    AppText {
                        id:loginTextForm
                        text: "login"
                        Layout.topMargin: dp(8)
                        Layout.bottomMargin: dp(12)
                        Layout.columnSpan: 2
                        Layout.alignment: Qt.AlignHCenter
                    }

                    AppText {
                        id: usernameTextForm
                        font.pixelSize: sp(12)
                        text: "Email:"
                    }
                    AppTextField {
                        id:usernameTextField
                        Layout.preferredWidth: dp(200)
                        showClearButton: true
                        font.pixelSize: sp(14)
                        rightPadding: dp(35)
                        borderColor: Theme.tintColor
                        borderWidth: !Theme.isAndroid ? dp(2) : 0
                        inputMode: inputModeEmail
                    }

                    AppText {
                        id:passwordTextForm
                        font.pixelSize: sp(12)
                        text: "Password:"
                    }
                    AppTextField {
                        id:passwordTextField
                        Layout.preferredWidth: dp(200)
                        showClearButton: true
                        font.pixelSize: sp(14)
                        rightPadding: dp(35)
                        borderColor: Theme.tintColor
                        borderWidth: !Theme.isAndroid ? dp(2) : 0
                        inputMode: inputModePassword
                    }
                    AppButton {
                        id: loginButton
                        Layout.topMargin: dp(12)
                        Layout.columnSpan: 2
                        flat: false
                        Layout.alignment: Qt.AlignHCenter
                        text: "login"
                        onClicked: {
                            loginPage.forceActiveFocus();
                            usernameTextField.length > 0 && passwordTextField.length > 0 ?
                                        loginPage.loginUser(usernameTextField.text, passwordTextField.text)
                                      : ""
                        }
                    }
                }
            }

            IconButton {
                id: iconCloseButton
                icon: IconType.times
                anchors.bottom: parent.bottom
                anchors.bottomMargin: dp(12)
                scale: 1.5
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: loginRect.state === "base" ? loginRect.state = "clicked" : loginRect.state = "base"
            }

            states: [
                State {
                    name: "base"
                    PropertyChanges {
                        target: loginRect
                        width: parent.width / 2.5
                    }
                    PropertyChanges {
                        target: loginRect
                        radius: dp(width/2)
                    }
                    PropertyChanges {
                        target: loginRect
                        color: "#424B54"
                    }
                    PropertyChanges {
                        target: loginText
                        visible: true
                    }
                    PropertyChanges {
                        target: loginTextForm
                        visible: false
                    }
                    PropertyChanges {
                        target: usernameTextForm
                        visible: false
                    }
                    PropertyChanges {
                        target: usernameTextField
                        visible: false
                    }
                    PropertyChanges {
                        target: passwordTextForm
                        visible: false
                    }
                    PropertyChanges {
                        target: passwordTextField
                        visible: false
                    }
                    PropertyChanges {
                        target: loginButton
                        visible: false
                    }
                    PropertyChanges {
                        target: iconCloseButton
                        visible: false
                    }
                },
                State {
                    name: "clicked"
                    PropertyChanges {
                        target: loginRect
                        width: parent.width
                    }
                    PropertyChanges {
                        target: loginRect
                        radius: dp(0)
                    }
                    PropertyChanges {
                        target: loginRect
                        color: "#eceded"
                    }
                    PropertyChanges {
                        target: loginText
                        visible: false
                    }
                    PropertyChanges {
                        target: loginTextForm
                        visible: true
                    }
                    PropertyChanges {
                        target: usernameTextForm
                        visible: true
                    }
                    PropertyChanges {
                        target: usernameTextField
                        visible: true
                    }
                    PropertyChanges {
                        target: passwordTextForm
                        visible: true
                    }
                    PropertyChanges {
                        target: passwordTextField
                        visible: true
                    }
                    PropertyChanges {
                        target: loginButton
                        visible: true
                    }
                    PropertyChanges {
                        target: iconCloseButton
                        visible: true
                    }
                }
            ]
            transitions: [
                Transition {
                    to: "*"
                    NumberAnimation {property: "width"; easing.type: Easing.InOutBack; target: loginRect; duration: 1000}
                    NumberAnimation {property: "radius"; easing.type: Easing.InOutBack; target: loginRect; duration: 1000}


                    ColorAnimation {target: loginRect; duration: 1000}
                    NumberAnimation {property: "visible"; target: loginText; duration: 1000}

                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: loginTextForm; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: usernameTextForm; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: usernameTextField; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: passwordTextForm; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: passwordTextField; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: loginButton; duration: 1000}
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: iconCloseButton; duration: 1000}

                }
            ]
        }
        Rectangle {
            height: dp(Theme.navigationBar.height) / 2
            width: parent.width
        }
        Rectangle {
            width: parent.width / 2.5
            anchors.horizontalCenter: parent.horizontalCenter

            height: width
            radius: dp(width / 2)
            color: "#424B54"
            MouseArea {
                anchors.fill: parent
                onClicked: {registerPage.visible = true; pageTransitionAnimation.start()}
                //page.navigationStack.push(subPage)
            }
            AppText {
                anchors.centerIn: parent
                text: "register"
                color: "white"
            }
        }
    }
}
