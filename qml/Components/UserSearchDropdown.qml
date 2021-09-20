import QtQuick 2.0
import Felgo 3.0

AppListView {
    id: root

    property real rowHeight: searchText.height
    property int fontPixelSize: sp(12)

    signal searchStarted()
    signal endSearch()

    height: 0
    visible: false
    clip: true

    boundsBehavior: Flickable.StopAtBounds

    header: headerComponent

    model: searchArr

    delegate: SimpleRow {
        text: modelData.name;
        height: root.rowHeight
        showDisclosure: false
        imageSource: model.image
        image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
        onSelected: {
            if(currentArr === "Hair"){hairArray.push(modelData); searchText.text = ""; }
            else if (currentArr === "Makeup"){makeupArray.push(modelData); searchText.text = ""; }
            else if(currentArr === "Wardrobe") {wardrobeArray.push(modelData); searchText.text = "";}
            else if(currentArr === "Photo") {photoArray.push(modelData); searchText.text = ""; }
            else if(currentArr === "Model") {modelArray.push(modelData); searchText.text = ""; }
        }}

    PropertyAnimation {
        id: showHideAnimation

        target: root

        property: "height"
        duration: 300
    }

    function show() {
        if (!visible) {
            visible = true
            showHideAnimation.to = root.rowHeight * 4
            showHideAnimation.start()
        }
    }

    function hide() {
        if (visible) {
            visible = false
            showHideAnimation.to = 0
            showHideAnimation.start()
        }
    }

    Component {
        id: headerComponent
        Rectangle {
            width: root.width
            height: searchText.height
            AppTextField {
                id: searchText; z:5 ; width: parent.width - addTeamIcon; placeholderText: "Search team members!"; inputMethodHints: Qt.ImhSensitiveData; backgroundColor: "white"
                onTextEdited: {
                    if(searchText.length > 0){dataModel.searchUsers(searchText.text); app.searchArrChanged()}
                    else if(searchText.length === 0) {searchArr = []}
                }
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
            }
            IconButton {id: addTeamIcon; state: "base";
                onClicked: {console.log("clicked"); root.searchStarted(); searchBar.visible === true ? searchBar.visible = false : searchBar.visible = true; addTeamIcon.state === "base" ? addTeamIcon.state = "searching" : addTeamIcon.state = "base"; searchBar.state === "base" ? searchBar.state = "searching" : searchBar.state = "base"}
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
        }
    }
}


