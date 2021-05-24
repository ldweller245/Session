import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4

Page {

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: dp(Theme.navigationBar.height)/2
        }
        AppText {
            width: parent.width
            padding: dp(15)
            horizontalAlignment: Text.AlignHCenter
            text: "Lets get some details from you to help others find you in their search!"
        }

        Row {
            id: genderRow
            width: parent.width
            AppText {
                text: "Are you.."
            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: ["Male", "Female", "Other"]
            }
        }
        Row {
            id: locationRow
            width: parent.width
            AppText {
                text: "Based in:"
            }
            AppTextField {

            }
        }

    }
}
