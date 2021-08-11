import QtQuick 2.0
import Felgo 3.0
import "../Components"

Page {
    id: page
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width

    transitions: [
        Transition {
            to: "*"
            NumberAnimation {id: animation; target: hairTeamText; property: "visible"; duration: 1000; easing.type: Easing.InOutBack}
        }
    ]
    AppFlickable {
        anchors.fill: parent; contentHeight: contentCol
        Column {
            id: contentCol
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Add your hair team"; padding: dp(15)}
            AppTextField {
                id: hairTeamText;
                scale: 0.95
                width: parent.width
                placeholderText: "@"
                inputMethodHints: Qt.ImhSensitiveData
                onTextEdited: if(hairTeamText.length > 2){dataModel.searchUsers(hairTeamText.text)}
            }
            Column {
                id: hairSearchColumn
                width: parent.width/ 2
                height: SimpleRow.height*10
                anchors.top: hairTeamText.bottom

                visible: hairTeamText.length > 0 ? true : false
                Repeater {model: searchArr; SimpleRow {text: modelData}}

            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Add your makeup team"; padding: dp(15)}
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"
            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Add your wardrobe team"; padding: dp(15)}
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"
            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Add your photography team"; padding: dp(15)}
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"

            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text: "Add your models"; padding: dp(15)}
            AppTextField {
                scale: 0.95
                width: parent.width
                placeholderText: "@"
            }
        }
    }
}
