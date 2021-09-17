import QtQuick 2.0
import Felgo 3.0

Page {
    id: teamItem

    property var hairArray: []
    property var makeupArray: []
    property var wardrobeArray: []
    property var photoArray: []
    property var modelArray: []

    property var currentArr


    property var sectionArr: ["Hair", "Makeup", "Model", "Wardrobe", "Photographer", "Studio"]

    property var teamData: {
        "team": [
                    {"id": "u1234", "name": "Katie", "role": "Hair"},
                    {"id": "u2345", "name": "Edward", "role": "Model"},
                    {"id": "u3456", "name": "Jo", "role": "Hair"},
                    {"id": "u4567", "name": "Julie", "role": "Photographer"}
                ]
    }

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

    Component {
        id: headerItem
        Column {
            width: parent.width; height: spacerH*2
            AppText {text: "Team:"; padding: dp(15)}
            Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
        }
    }
    Component {
        id: searchHeader
        AppTextField {id: makeupTeamText; scale: 0.95; width: parent.width; placeholderText: "@"; height: AppTextField.height; inputMethodHints: Qt.ImhSensitiveData
            onTextEdited: {
                currentArr = "makeup"
                if(makeupTeamText.length > 0){searchFlickable.visible = true; dataModel.searchUsers(makeupTeamText.text); app.searchArrChanged()}
                else if(makeupTeamText.length === 0) {searchArr = []}
            }
        }
    }
    Component {
        id: searchFooter
        SimpleRow {
            IconButton {anchors.centerIn: parent; icon: IconType.times
                onClicked: {suggestionsList.hide()}
            }
        }
    }
    Component {
        id: footerItem
        SimpleRow {
            IconButton {anchors.centerIn: parent; icon: IconType.plus
                onClicked: {suggestionsList.show()}
            }
        }
        AppListView {
          id: suggestionsList
          model: searchArr

          property real rowHeight: dp(30)
          property int fontPixelSize: sp(12)

          header: searchHeader
          footer: searchFooter
          height: 0
          visible: false
          clip: true
          boundsBehavior: Flickable.StopAtBounds
          delegate: SimpleRow {
            height: suggestionsList.rowHeight
            text: modelData
            onSelected: {suggestionsList.hide()}
          }
          PropertyAnimation {
            id: showHideAnimation
            target: suggestionsList
            property: "height"
            duration: 300
          }
          function show() {if (!visible) {visible = true; showHideAnimation.to = suggestionsList.rowHeight * 4; showHideAnimation.start()}}
          function hide() {if (visible) {visible = false; showHideAnimation.to = 0; showHideAnimation.start()}}
        }
    }

    Repeater {
        model: sectionArr
        delegate: Column {
            width: teamItem.width
            AppText {
                width: teamItem.width
                height: dp(Theme.navigationBar.height)
                text: modelData
                font.bold: true
            }

            AppListView {
                id: teamList
                width: parent.width
                height: teamList.height
                model: pageEditable === true ? "" : teamData
                header: headerItem
                footer: pageEditable === true ? footerItem : undefined
                delegate: SimpleRow {
                    id: delegateRow
                    text: modelData.name
                    detailText: modelData.role
                    enabled: false
                    showDisclosure: false

                    imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
                    image.radius: image.width/2
                    image.fillMode: Image.PreserveAspectCrop

                    Rectangle {
                        height: parent.height
                        width: height
                        anchors.right: parent.right
                        color: "transparent"
                        IconButton {
                            icon: IconType.envelope
                        }
                    }
                    style: StyleSimpleRow {
                        showDisclosure: false
                        backgroundColor: "transparent"
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
                    scale: 0.96; width: teamItem.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIcon; icon: IconType.times;
                            onClicked: {let index = hairArray.indexOf(modelData.name); hairArray.splice(index, 1); teamItem.hairArrayChanged()}
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
                    scale: 0.96; width: teamItem.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconMUA; icon: IconType.times;
                            onClicked: {let index = makeupArray.indexOf(modelData.name); makeupArray.splice(index, 1); teamItem.makeupArrayChanged()}
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
                    scale: 0.96; width: teamItem.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconWardrobe; icon: IconType.times;
                            onClicked: {let index = wardrobeArray.indexOf(modelData.name); wardrobeArray.splice(index, 1); teamItem.wardrobeArrayChanged()}
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
                    scale: 0.96; width: teamItem.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconPhoto; icon: IconType.times;
                            onClicked: {let index = photoArray.indexOf(modelData.name); photoArray.splice(index, 1); teamItem.photoArrayChanged()}
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
                    scale: 0.96; width: teamItem.width / 3; height: parent.height; color: "lightgrey"
                    Row {
                        width: parent.width; height: parent.height
                        IconButton {id: closeIconModel; icon: IconType.times;
                            onClicked: {let index = modelArray.indexOf(modelData.name); modelArray.splice(index, 1); teamItem.modelArrayChanged()}
                        }
                        AppText {padding: dp(10); maximumLineCount: 1; width: parent.width - closeIconModel.width; elide: Text.ElideRight; wrapMode: Text.WrapAnywhere; text: modelData.name}
                    }
                }
            }
        }
        Rectangle {width: spacerW; height: spacerH*2}
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
                        if(currentArr === "hair"){hairArray.push(modelData); hairTeamText.text = ""; teamItem.hairArrayChanged()}
                        else if (currentArr === "makeup"){makeupArray.push(modelData); makeupTeamText.text = ""; teamItem.makeupArrayChanged()}
                        else if(currentArr === "wardrobe") {wardrobeArray.push(modelData); wardrobeTeamText.text = ""; teamItem.wardrobeArrayChanged()}
                        else if(currentArr === "photo") {photoArray.push(modelData); photoTeamText.text = ""; teamItem.photoArrayChanged()}
                        else if(currentArr === "model") {modelArray.push(modelData); modelTeamText.text = ""; teamItem.modelArrayChanged()}
                        searchFlickable.visible = false
                    }
                }
            }
        }
    }
}
