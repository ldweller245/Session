import QtQuick 2.0
import Felgo 3.0
import "../Components"

FlickablePage {
    id: page

    flickable.contentHeight: contentCol.height

    property var hairArray: []
    property var makeupArray: []
    property var wardrobeArray: []
    property var photoArray: []
    property var modelArray: []

    property var currentArr

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: page.width

    Rectangle {
        z:4; anchors.fill: parent; color: Qt.rgba(0,0,0,0.35); opacity:  visible === true ? 1 : 0; visible: searchFlickable.visible
        Behavior on opacity {NumberAnimation {duration: 400; easing.type: Easing.InOutBack}}
    }

    AppFlickable {
        z:5; id: searchFlickable; contentHeight: hairSearchColumn.height; width: parent.width/2;height: width; anchors.right: parent.right; visible: searchArr.length === 0 ? false: true; opacity: visible === true ? 1 : 0
        Behavior on opacity {NumberAnimation {duration: 400; easing.type: Easing.InOutBack}}
        Column {
            id: hairSearchColumn; width: parent.width; anchors.right: parent.right; height: searchArr.length === 0 ? 0 : SimpleRow.height*searchArr.length
            Repeater {
                model: searchArr
                SimpleRow {
                    text: modelData.name;
                    onSelected: {
                        if(currentArr === "hair"){hairArray.push(modelData); hairTeamText.text = ""; page.hairArrayChanged()}
                        else if (currentArr === "makeup"){makeupArray.push(modelData); makeupTeamText.text = ""; page.makeupArrayChanged()}
                        else if(currentArr === "wardrobe") {wardrobeArray.push(modelData); wardrobeTeamText.text = ""; page.wardrobeArrayChanged()}
                        else if(currentArr === "photo") {photoArray.push(modelData); photoTeamText.text = ""; page.photoArrayChanged()}
                        else if(currentArr === "model") {modelArray.push(modelData); modelTeamText.text = ""; page.modelArrayChanged()}
                        searchFlickable.visible = false
                    }
                }
            }
        }
    }
    Column {
        id: contentCol; width: parent.width
        Rectangle {width: spacerW; height: spacerH}
        AppText {text: "Add your hair team"; padding: dp(15); height: Text.height}
        AppTextField {
            id: hairTeamText; scale: 0.95; width: parent.width; height: AppTextField.height; placeholderText: "@"; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "hair";
                if(hairTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(hairTeamText.text); app.searchArrChanged()}
                else if(hairTeamText.length === 0) {searchArr = []}
            }
        }
        Rectangle {
            width: parent.width; height: dp(Theme.navigationBar.height); radius: dp(3)
            AppListView {
                width: parent.width; height: parent.height; orientation: ListView.Horizontal; spacing: dp(15); model: hairArray
                delegate: Rectangle {
                    scale: 0.96; width: page.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIcon; icon: IconType.times;
                            onClicked: {let index = hairArray.indexOf(modelData.name); hairArray.splice(index, 1); page.hairArrayChanged()}
                        }
                        AppText {padding: dp(10); maximumLineCount: 1; width: parent.width - closeIcon.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        AppText {text: "Add your makeup team"; padding: dp(15); height: Text.height}
        AppTextField {id: makeupTeamText; scale: 0.95; width: parent.width; placeholderText: "@"; height: AppTextField.height; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "makeup"
                if(makeupTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(makeupTeamText.text); app.searchArrChanged()}
                else if(makeupTeamText.length === 0) {searchArr = []}
            }
        }
        Rectangle {
            width: parent.width; height: dp(Theme.navigationBar.height); radius: dp(3)
            AppListView {
                width: parent.width; height: parent.height; orientation: ListView.Horizontal; spacing: dp(15); model: makeupArray
                delegate: Rectangle {
                    scale: 0.96; width: page.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconMUA; icon: IconType.times;
                            onClicked: {let index = makeupArray.indexOf(modelData.name); makeupArray.splice(index, 1); page.makeupArrayChanged()}
                        }
                        AppText {padding: dp(10); maximumLineCount: 1; width: parent.width - closeIconMUA.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        AppText {text: "Add your wardrobe team"; padding: dp(15); height: Text.height}
        AppTextField {id: wardrobeTeamText; scale: 0.95; width: parent.width; placeholderText: "@"; height: AppTextField.height; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "wardrobe"
                if(wardrobeTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(wardrobeTeamText.text); app.searchArrChanged()}
                else if(wardrobeTeamText.length === 0) {searchArr = []}
            }
        }
        Rectangle {
            width: parent.width; height: dp(Theme.navigationBar.height); radius: dp(3)
            AppListView {
                width: parent.width; height: parent.height; orientation: ListView.Horizontal; spacing: dp(15); model: wardrobeArray
                delegate: Rectangle {
                    scale: 0.96; width: page.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconWardrobe; icon: IconType.times;
                            onClicked: {let index = wardrobeArray.indexOf(modelData.name); wardrobeArray.splice(index, 1); page.wardrobeArrayChanged()}
                        }
                        AppText {padding: dp(10); maximumLineCount: 1; width: parent.width - closeIconWardrobe.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        AppText {text: "Add your photography team"; padding: dp(15); height: Text.height}
        AppTextField {id: photoTeamText; scale: 0.95; width: parent.width; placeholderText: "@"; height: AppTextField.height; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "photo"
                if(photoTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(photoTeamText.text); app.searchArrChanged()}
                else if(photoTeamText.length === 0) {searchArr = []}
            }
        }
        Rectangle {
            width: parent.width; height: dp(Theme.navigationBar.height); radius: dp(3)
            AppListView {
                width: parent.width; height: parent.height; orientation: ListView.Horizontal; spacing: dp(15); model: photoArray
                delegate: Rectangle {
                    scale: 0.96; width: page.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconPhoto; icon: IconType.times;
                            onClicked: {let index = photoArray.indexOf(modelData.name); photoArray.splice(index, 1); page.photoArrayChanged()}
                        }
                        AppText { padding: dp(10); maximumLineCount: 1; width: parent.width - closeIconPhoto.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        AppText {text: "Add your models"; padding: dp(15); height: Text.height}
        AppTextField {id: modelTeamText; scale: 0.95; width: parent.width; placeholderText: "@"; height: AppTextField.height; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "model"
                if(modelTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(modelTeamText.text); app.searchArrChanged()}
                else if(modelTeamText.length === 0) {searchArr = []}
            }
        }
        Rectangle {
            width: parent.width; height: dp(Theme.navigationBar.height); radius: dp(3)
            AppListView {
                width: parent.width; height: parent.height; orientation: ListView.Horizontal; spacing: dp(15); model: modelArray
                delegate: Rectangle {
                    scale: 0.96; width: page.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconModel; icon: IconType.times;
                            onClicked: {let index = modelArray.indexOf(modelData.name); modelArray.splice(index, 1); page.modelArrayChanged()}
                        }
                        AppText {padding: dp(10); maximumLineCount: 1; width: parent.width - closeIconModel.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH*2}
    }
}
