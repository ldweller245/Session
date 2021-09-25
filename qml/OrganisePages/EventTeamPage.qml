import QtQuick 2.0
import Felgo 3.0
import "../Components"

FlickablePage {
    id: teamItem

    signal searchStarted()
    signal endSearch()

    property var tabIndex: tabControl.currentIndex

    onTabIndexChanged:  {
    }

    flickable.contentHeight: contentCol.height

    property var currentArr

    property var sectionArr: ["Hair", "Makeup", "Model", "Wardrobe", "Photographer", "Studio"]

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

    Column {
        id: contentCol; width: parent.width
        Rectangle {width: spacerW; height: spacerH}
        Rectangle {
            width: teamItem.width; height: dp(Theme.navigationBar.height)
            AppText {padding: dp(15); text: "<b>Hair" + "&nbsp;&nbsp;&nbsp;>"; anchors.verticalCenter: parent.verticalCenter}
        }
        AppListView {
            id: hairModel
            model: pageEditable ? hairArray : shootData.team.hair; emptyText.text: pageEditable ? "Add your hair team" : ""; spacing: 3; height: searchText.height+ (searchText.height*hairModel.count)
            delegate: SimpleRow {
                text: modelData.name; imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                Rectangle {
                    height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                    IconButton {icon: IconType.trash;
                        onClicked: {
                            if(pageEditable === true) {let index = hairArray.indexOf(modelData.name); hairArray.splice(index, 1); shootSetupModal.hairArrayChanged()}
                            else {let index = shootData.team.hair.indexOf(modelData.name); shootData.team.hair.splice(index, 1)}
                        }
                    }
                }
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
        }
        Rectangle {
            width: teamItem.width; visible: pageEditable; height: searchText.height
            IconButton {id: addTeamIcon; state: "base";
                onClicked: {console.log("clicked");
                    searchText.visible === true ? searchText.visible = false : searchText.visible = true;
                    addTeamIcon.state === "base" ? addTeamIcon.state = "searching" : addTeamIcon.state = "base";
                    searchText.state === "base" ? searchText.state = "searching" : searchText.state = "base"
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: addTeamIcon; rotation: 0}
                        AnchorChanges { target: addTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: addTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: addTeamIcon; rotation: 360}
                        AnchorChanges { target: addTeamIcon; anchors.left: parent.left}
                        PropertyChanges {target: addTeamIcon; icon: IconType.search}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: addTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        PropertyAnimation {property: "icon"; target: addTeamIcon; duration: 1000; easing.type: Easing.InOutBack}
                    }
                ]
            }
            AppTextField {
                id: searchText; z:5 ; width: parent.width - addTeamIcon; placeholderText: qsTr("Search hair team!"); inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                state: "base"; anchors.left: addTeamIcon.right
                onTextEdited: {
                    currentArr = "Hair"
                    if(searchText.length > 0){dataModel.searchUsers(searchText.text); app.searchArrChanged();}
                    else if(searchText.length === 0) {searchArr = []}
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: searchText; visible: false}
                        PropertyChanges {target: searchText; opacity: 0}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: searchText; visible: true}
                        PropertyChanges {target: searchText; opacity: 1}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: searchText; duration: 1000}
                        NumberAnimation {property: "opacity"; easing.type: Easing.InOutBack; target: searchText; duration: 1000}
                    }
                ]
            }
        }
        Repeater {
            visible: pageEditable
            model: if(currentArr === "Hair"){model = searchArr} enabled: currentArr === "Hair"
            delegate: SimpleRow {id: delegate; text: modelData.name; showDisclosure: false
                imageSource: modelData.image; image.height: parent.height; image.width: height; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop;
                onSelected: {hairArray.push(modelData); searchText.text = ""; teamItem.hairArrayChanged(); searchArr = []}
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        Rectangle {
            width: teamItem.width; height: dp(Theme.navigationBar.height)
            AppText {padding: dp(15); text: "<b>Makeup" + "&nbsp;&nbsp;&nbsp;>"; anchors.verticalCenter: parent.verticalCenter}
        }
        AppListView {
            id: makeupModel; model: pageEditable ? makeupArray : shootData.team.makeup; emptyText.text: pageEditable ? "Add your mua team" : ""; spacing: 3; height: makeupSearchText.height+ (makeupSearchText.height*makeupModel.count)
            delegate: SimpleRow {
                text: modelData.name; imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                onSelected: organiseStack.push(otherUserComp, {userID: model.id})
                Rectangle {
                    height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                    IconButton {icon: IconType.trash; onClicked: {
                            if(pageEditable === true) {
                            let index = makeupArray.indexOf(modelData.name); makeupArray.splice(index, 1); shootSetupModal.makeupArrayChanged()
                            } else {
                                let index = shootData.team.makeup.indexOf(modelData.name); shootData.team.makeup.splice(index, 1)
                            }
                        }
                    }
                }
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
        }
        Rectangle {
            visible: pageEditable; width: teamItem.width; height: makeupSearchText.height
            IconButton {id: makeupTeamIcon; state: "base";
                onClicked: {console.log("clicked");
                    makeupSearchText.visible === true ? makeupSearchText.visible = false : makeupSearchText.visible = true;
                    makeupTeamIcon.state === "base" ? makeupTeamIcon.state = "searching" : makeupTeamIcon.state = "base";
                    makeupSearchText.state === "base" ? makeupSearchText.state = "searching" : makeupSearchText.state = "base"
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: makeupTeamIcon; rotation: 0}
                        AnchorChanges { target: makeupTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: makeupTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: makeupTeamIcon; rotation: 360}
                        AnchorChanges { target: makeupTeamIcon; anchors.left: parent.left}
                        PropertyChanges {target: makeupTeamIcon; icon: IconType.search}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: makeupTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        PropertyAnimation {property: "icon"; target: makeupTeamIcon; duration: 1000; easing.type: Easing.InOutBack}
                    }
                ]
            }
            AppTextField {
                id: makeupSearchText; z:5 ; width: parent.width - makeupTeamIcon; placeholderText: qsTr("Search mua team!"); inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                state: "base"; anchors.left: makeupTeamIcon.right
                onTextEdited: {
                    currentArr = "Makeup"
                    if(makeupSearchText.length > 0){dataModel.searchUsers(makeupSearchText.text); app.searchArrChanged();}
                    else if(makeupSearchText.length === 0) {searchArr = []}
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: makeupSearchText; visible: false}
                        PropertyChanges {target: makeupSearchText; opacity: 0}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: makeupSearchText; visible: true}
                        PropertyChanges {target: makeupSearchText; opacity: 1}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: makeupSearchText; duration: 1000}
                        NumberAnimation {property: "opacity"; easing.type: Easing.InOutBack; target: makeupSearchText; duration: 1000}
                    }
                ]
            }
        }
        Repeater {
            visible: pageEditable
            model: if(currentArr === "Makeup"){model = searchArr}
            enabled: currentArr === "Makeup"
            delegate: SimpleRow {id: delegateMakeup; text: modelData.name; showDisclosure: false
                imageSource: modelData.image; image.height: parent.height; image.width: height; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop;
                onSelected: {makeupArray.push(modelData); makeupSearchText.text = ""; teamItem.makeupArrayChanged(); searchArr = []}
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        Rectangle {
            width: teamItem.width; height: dp(Theme.navigationBar.height)
            AppText {padding: dp(15); text: "<b>Wardrobe" + "&nbsp;&nbsp;&nbsp;>"; anchors.verticalCenter: parent.verticalCenter}
        }
        AppListView {
            id: wardrobeModel; model: pageEditable ? wardrobeArray : shootData.team.wardrobe; emptyText.text: pageEditable ? "Add your wardrobe team" : ""; spacing: 3; height: wardrobeSearchText.height+ (wardrobeSearchText.height*wardrobeModel.count)
            delegate: SimpleRow {
                text: modelData.name; imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                Rectangle {
                    height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                    IconButton {icon: IconType.trash; onClicked: {
                            if(pageEditable === true) {
                            let index = wardrobeArray.indexOf(modelData.name); wardrobeArray.splice(index, 1); shootSetupModal.wardrobeArrayChanged()
                            } else {
                                let index = shootData.team.wardrobe.indexOf(modelData.name); shootData.team.wardrobe.splice(index, 1)
                            }
                        }
                    }
                }
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
        }
        Rectangle {
            width: teamItem.width; visible: pageEditable; height: wardrobeSearchText.height
            IconButton {id: wardrobeTeamIcon; state: "base";
                onClicked: {console.log("clicked");
                    wardrobeSearchText.visible === true ? wardrobeSearchText.visible = false : wardrobeSearchText.visible = true;
                    wardrobeTeamIcon.state === "base" ? wardrobeTeamIcon.state = "searching" : wardrobeTeamIcon.state = "base";
                    wardrobeSearchText.state === "base" ? wardrobeSearchText.state = "searching" : wardrobeSearchText.state = "base"
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: wardrobeTeamIcon; rotation: 0}
                        AnchorChanges { target: wardrobeTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: wardrobeTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: wardrobeTeamIcon; rotation: 360}
                        AnchorChanges { target: wardrobeTeamIcon; anchors.left: parent.left}
                        PropertyChanges {target: wardrobeTeamIcon; icon: IconType.search}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: wardrobeTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        PropertyAnimation {property: "icon"; target: wardrobeTeamIcon; duration: 1000; easing.type: Easing.InOutBack}
                    }
                ]
            }
            AppTextField {
                id: wardrobeSearchText; z:5 ; width: parent.width - wardrobeTeamIcon; placeholderText: qsTr("Search wardrobe team!"); inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                state: "base"; anchors.left: wardrobeTeamIcon.right
                onTextEdited: {
                    currentArr = "Wardrobe"
                    if(wardrobeSearchText.length > 0){dataModel.searchUsers(wardrobeSearchText.text); app.searchArrChanged();}
                    else if(wardrobeSearchText.length === 0) {searchArr = []}
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: wardrobeSearchText; visible: false}
                        PropertyChanges {target: wardrobeSearchText; opacity: 0}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: wardrobeSearchText; visible: true}
                        PropertyChanges {target: wardrobeSearchText; opacity: 1}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: wardrobeSearchText; duration: 1000}
                        NumberAnimation {property: "opacity"; easing.type: Easing.InOutBack; target: wardrobeSearchText; duration: 1000}
                    }
                ]
            }
        }
        Repeater {
            visible: pageEditable; model: if(currentArr === "Wardrobe") {model = searchArr} enabled: currentArr === "Wardrobe"
            delegate: SimpleRow {text: modelData.name; showDisclosure: false
                imageSource: modelData.image; image.height: parent.height; image.width: height; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop;
                onSelected: {wardrobeArray.push(modelData); wardrobeSearchText.text = ""; teamItem.wardrobeArrayChanged(); searchArr = []}
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        Rectangle {
            width: teamItem.width; height: dp(Theme.navigationBar.height)
            AppText {padding: dp(15); text: "<b>Photography" + "&nbsp;&nbsp;&nbsp;>"; anchors.verticalCenter: parent.verticalCenter}
        }
        AppListView {
            id: photoModel; model: pageEditable ? photoArray : shootData.team.photo; emptyText.text: pageEditable ? "Add your photography team" : ""; spacing: 3; height: photoSearchText.height+ (photoSearchText.height*photoModel.count)
            delegate: SimpleRow {
                text: modelData.name; imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                Rectangle {
                    height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                    IconButton {icon: IconType.trash; onClicked: {
                            if(pageEditable === true) {
                            let index = photoArray.indexOf(modelData.name); photoArray.splice(index, 1); shootSetupModal.photoArrayChanged()
                            } else {
                                let index = shootData.team.photo.indexOf(modelData.name); shootData.team.photo.splice(index, 1)
                            }
                        }
                    }
                }
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
        }
        Rectangle {
            visible: pageEditable; width: teamItem.width; height: photoSearchText.height
            IconButton {id: photoTeamIcon; state: "base";
                onClicked: {console.log("clicked");
                    photoSearchText.visible === true ? photoSearchText.visible = false : photoSearchText.visible = true;
                    photoTeamIcon.state === "base" ? photoTeamIcon.state = "searching" : photoTeamIcon.state = "base";
                    photoSearchText.state === "base" ? photoSearchText.state = "searching" : photoSearchText.state = "base"
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: photoTeamIcon; rotation: 0}
                        AnchorChanges { target: photoTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: photoTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: photoTeamIcon; rotation: 360}
                        AnchorChanges { target: photoTeamIcon; anchors.left: parent.left}
                        PropertyChanges {target: photoTeamIcon; icon: IconType.search}

                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: photoTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        PropertyAnimation {property: "icon"; target: photoTeamIcon; duration: 1000; easing.type: Easing.InOutBack}

                    }
                ]
            }
            AppTextField {
                id: photoSearchText; z:5 ; width: parent.width - photoTeamIcon; placeholderText: qsTr("Search photography team!"); inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                state: "base"; anchors.left: photoTeamIcon.right
                onTextEdited: {
                    currentArr = "Photography"
                    if(photoSearchText.length > 0){dataModel.searchUsers(photoSearchText.text); app.searchArrChanged();}
                    else if(photoSearchText.length === 0) {searchArr = []}
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: photoSearchText; visible: false}
                        PropertyChanges {target: photoSearchText; opacity: 0}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: photoSearchText; visible: true}
                        PropertyChanges {target: photoSearchText; opacity: 1}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: photoSearchText; duration: 1000}
                        NumberAnimation {property: "opacity"; easing.type: Easing.InOutBack; target: photoSearchText; duration: 1000}
                    }
                ]
            }
        }
        Repeater {
            visible: pageEditable; model: if(currentArr === "Photography") {model = searchArr} enabled: currentArr === "Photography"
            delegate: SimpleRow {text: modelData.name; showDisclosure: false
                imageSource: modelData.image; image.height: parent.height; image.width: height; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop;
                onSelected: {photoArray.push(modelData); photoSearchText.text = ""; teamItem.photoArrayChanged(); searchArr = []}
            }
        }
        Rectangle {width: spacerW; height: spacerH}
        Rectangle {
            width: teamItem.width; height: dp(Theme.navigationBar.height)
            AppText {padding: dp(15); text: "<b>Models" + "&nbsp;&nbsp;&nbsp;>"; anchors.verticalCenter: parent.verticalCenter}
        }
        AppListView {
            id: modelModel
            model: pageEditable ? modelArray : shootData.team.model
            emptyText.text: pageEditable ? "Add your models" : ""; spacing: 3; height: modelSearchText.height+ (modelSearchText.height*modelModel.count)
            delegate: SimpleRow {
                text: modelData.name; enabled: false; imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                Rectangle {
                    height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                    IconButton {icon: IconType.trash;
                        onClicked: {
                            if(pageEditable === true) {let index = modelArray.indexOf(modelData.name); modelArray.splice(index, 1); modelSetupModal.makeupArrayChanged()}
                            else {let index = shootData.team.model.indexOf(modelData.name); shootData.team.model.splice(index, 1)}
                        }
                    }
                }
                style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
            }
        }
        Rectangle {
            width: teamItem.width; visible: pageEditable; height: modelSearchText.height
            IconButton {id: modelTeamIcon; state: "base";
                onClicked: {
                    modelSearchText.visible === true ? modelSearchText.visible = false : modelSearchText.visible = true;
                    modelTeamIcon.state === "base" ? modelTeamIcon.state = "searching" : modelTeamIcon.state = "base";
                    modelSearchText.state === "base" ? modelSearchText.state = "searching" : modelSearchText.state = "base"
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: modelTeamIcon; rotation: 0}
                        AnchorChanges { target: modelTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: modelTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: modelTeamIcon; rotation: 360}
                        AnchorChanges { target: modelTeamIcon; anchors.left: parent.left}
                        PropertyChanges {target: modelTeamIcon; icon: IconType.search}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: modelTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        PropertyAnimation {property: "icon"; target: modelTeamIcon; duration: 1000; easing.type: Easing.InOutBack}
                    }
                ]
            }
            AppTextField {
                id: modelSearchText; z:5 ; width: parent.width - modelTeamIcon; placeholderText: qsTr("Search models!"); inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                state: "base"; anchors.left: modelTeamIcon.right
                onTextEdited: {
                    currentArr = "Model"
                    if(modelSearchText.length > 0){dataModel.searchUsers(modelSearchText.text); app.searchArrChanged();}
                    else if(modelSearchText.length === 0) {searchArr = []}
                }
                states: [
                    State {name: "base"
                        PropertyChanges {target: modelSearchText; visible: false}
                        PropertyChanges {target: modelSearchText; opacity: 0}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: modelSearchText; visible: true}
                        PropertyChanges {target: modelSearchText; opacity: 1}
                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: modelSearchText; duration: 1000}
                        NumberAnimation {property: "opacity"; easing.type: Easing.InOutBack; target: modelSearchText; duration: 1000}
                    }
                ]
            }
        }
        Repeater {
            visible: pageEditable
            model: if(currentArr === "Model"){model = searchArr}
            enabled: currentArr === "Model"
            delegate: SimpleRow {text: modelData.name; showDisclosure: false
                imageSource: modelData.image; image.height: parent.height; image.width: height; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop;
                onSelected: {modelArray.push(modelData); modelSearchText.text = ""; teamItem.modelArrayChanged(); searchArr = []}
            }
        }
        Rectangle {width: spacerW; height: spacerH}
    }
}

