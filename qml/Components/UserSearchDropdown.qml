import QtQuick 2.0
import Felgo 3.0

Column {
    id: footerColumn

    signal searchStarted()
    signal endSearch()

    Rectangle {
        width: footerColumn.width
        height: footer.height
        SimpleRow {
            id: footer
            //add page editable to visible
            IconButton {id: addTeamIcon; icon: IconType.plus; state: "base"; z: 6
                onClicked: {footerColumn.searchStarted(); searchBar.visible === true ? searchBar.visible = false : searchBar.visible = true; addTeamIcon.state === "base" ? addTeamIcon.state = "searching" : addTeamIcon.state = "base"}
                states: [
                    State {name: "base"
                        PropertyChanges {target: addTeamIcon; rotation: 0}
                        AnchorChanges { target: addTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                        PropertyChanges {target: addTeamIcon; icon: IconType.plus}
                    },
                    State {
                        name: "searching"
                        PropertyChanges {target: addTeamIcon; rotation: 360}
                        AnchorChanges { target: addTeamIcon; anchors.right: parent.right}
                        PropertyChanges {target: addTeamIcon; icon: IconType.search}

                    }
                ]
                transitions: [
                    Transition {
                        to: "*"
                        RotationAnimation {property: "rotation"; target: addTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                        AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
                        NumberAnimation {property: "icon"; target: addTeamIcon; easing.type: Easing.InOutBack; duration: 1000}
                    }
                ]
            }
        }
        Column {
            id: searchBar
            width: parent.width
            state: "base"
            visible: false
            states: [
                State {name: "base"
                    PropertyChanges {target: searchBar; visible: false}
                },
                State {
                    name: "searching"
                    PropertyChanges {target: searchBar; visible: true}
                }
            ]
            transitions: [
                Transition {
                    to: "*"
                    NumberAnimation {property: "visible"; easing.type: Easing.InOutBack; target: searchBar; duration: 1000}
                }
            ]
            Row {
                width: parent.width; height: searchText.height;
                AppTextField {
                    id: searchText; width: parent.width; height: AppTextField.height; placeholderText: "Search team members!"; inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                    onTextEdited: {
                        if(searchText.length > 0){dataModel.searchUsers(searchText.text); app.searchArrChanged()}
                        else if(searchText.length === 0) {searchArr = []}
                    }
                }
            }
            Repeater {
                model: searchArr
                //need to push to array or emit signal
                delegate: SimpleRow {id: delegate; text: modelData.name;
                    showDisclosure: false
                    imageSource: model.image
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    onSelected: {
                        if(currentArr === "Hair"){hairArray.push(modelData); searchText.text = ""; }
                        else if (currentArr === "Makeup"){makeupArray.push(modelData); searchText.text = ""; }
                        else if(currentArr === "Wardrobe") {wardrobeArray.push(modelData); searchText.text = ""; page.wardrobeArrayChanged()}
                        else if(currentArr === "Photo") {photoArray.push(modelData); searchText.text = ""; page.photoArrayChanged()}
                        else if(currentArr === "Model") {modelArray.push(modelData); searchText.text = ""; }
                    }}
            }
        }
    }

}

