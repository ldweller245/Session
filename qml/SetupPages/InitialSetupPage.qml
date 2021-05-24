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
            padding: dp(15)
            text: "Firstname"
        }
        AppText {
            padding: dp(15)
            text: "Surname"
        }
        AppText {
            padding: dp(15)
            text: "Username"
        }
        AppText {
            padding: dp(15)
            text: "Email"
        }
        AppText {
            padding: dp(15)
            text: "Password"
        }
        AppButton {
            flat: false
            text: "Register"
        }
    }

}
