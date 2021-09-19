import QtQuick 2.0
import Felgo 3.0

Page {
    id: teamItem

    //unused at current
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
                    {"id": "u2345", "name": "Edward", "role": "Model"}
                ]
    }
        //SortFilterProxyModel {id: hairSortedModel; Component.onCompleted: {app.userFeedChanged();sourceModel = jsonModel} filters: ExpressionFilter {expression: {model.tag === "Hair"; }}}
    //unused at current

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

    property var jsonData: [{"id": 1, "name": "Katie", "role": "Hair"},{"id": 2,"name": "Jo", "role": "Hair"},{"id": 3,"name": "Tracey", "role": "Photography"},{"id": 4,"name": "Edward", "role": "Model"},{"id": 5,"name": "Turtle", "role": "Director"}]

    JsonListModel {
        id: jsonModel
        source: shootSetupModal.jsonData
        keyField: "id"
        fields: ["id", "name", "role"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: sourceModel = jsonModel
        sorters: [
            StringSorter { id: typeSorter; roleName: "role"; ascendingOrder: true },
            StringSorter { id: nameSorter; roleName: "name"; ascendingOrder: true }
        ]
    }

    SortFilterProxyModel {id: sortedModel0; Component.onCompleted: {sourceModel = sectionArr} filters: ExpressionFilter {expression: {model.tag === "Hair"; }}}
    SortFilterProxyModel {id: sortedModel1; Component.onCompleted: {sourceModel = sectionArr} filters: ExpressionFilter {expression: {model.tag === "Makeup"; }}}
    SortFilterProxyModel {id: sortedModel2; Component.onCompleted: {sourceModel = sectionArr} filters: ExpressionFilter {expression: {model.tag === "Model"; }}}
    SortFilterProxyModel {id: sortedModel3; Component.onCompleted: {sourceModel = sectionArr} filters: ExpressionFilter {expression: {model.tag === "Wardrobe"; }}}
    SortFilterProxyModel {id: sortedModel4; Component.onCompleted: {sourceModel = sectionArr} filters: ExpressionFilter {expression: {model.tag === "Photographer"; }}}

    Component {
        id: headerItem
        // add underline?
        Rectangle {
            width: parent.width; height: spacerH*2
            AppText {text: "Team:"; padding: dp(15)}
        }
    }
    Column {
        anchors.fill: parent
        Repeater {
            model: sectionArr
            AppText {
                text: modelData
            }
            AppListView {
                id: teamList
                anchors.fill: parent
                model: sortedModel
                header: headerItem
                delegate: Column {
                    width: parent.width
                    id: column
                    SimpleRow {
                        id: delegateRow
                        text: model.name; detailText: model.role
                        enabled: false; showDisclosure: false
                        imageSource: "https://payload.cargocollective.com/1/10/333868/13868492/6496-20-005-f2_670.jpeg"
                        image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                        Rectangle {
                            height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                            IconButton {icon: IconType.envelope}
                        }
                        style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                    }
                }
            }
            Column {
                id: footerColumn
                //add buttonItem
                width: teamItem.width
                visible: column.ListView.section !== column.ListView.nextSection
                SimpleRow {
                    id: footer
                    //add page editable to visible
                    IconButton {id: addTeamIcon; icon: IconType.plus; state: "base"; z: 6
                        onClicked: {console.log(column.ListView.section); searchBar.visible === true ? searchBar.visible = false : searchBar.visible = true; addTeamIcon.state === "base" ? addTeamIcon.state = "searching" : addTeamIcon.state = "base"}
                        states: [
                            State {name: "base"
                                PropertyChanges {target: addTeamIcon; rotation: 0}
                                AnchorChanges { target: addTeamIcon; anchors.horizontalCenter: parent.horizontalCenter}
                            },
                            State {
                                name: "searching"
                                PropertyChanges {target: addTeamIcon; rotation: 405}
                                AnchorChanges { target: addTeamIcon; anchors.right: parent.right}
                            }
                        ]
                        transitions: [
                            Transition {
                                to: "*"
                                RotationAnimation {property: "rotation"; target: addTeamIcon;easing.type: Easing.InOutBack; duration: 1000}
                                AnchorAnimation {easing.type: Easing.InOutBack; duration: 1000}
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
                        Rectangle {
                            height: parent.height; width: height; color: "white"
                            Icon {icon: IconType.search; anchors.centerIn: parent}
                        }
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
                        delegate: SimpleRow {id: delegate; text: modelData.name; onSelected: exploreStack.push(otherUserComp, {userID: modelData.id})}
                    }
                }
            }
        }
    }
}
