import QtQuick 2.0
import Felgo 3.0
import "../Components"

FlickablePage {
    id: teamItem

    flickable.contentHeight: contentCol.height
    property var hairArray: []
    property var makeupArray: []
    property var wardrobeArray: []
    property var photoArray: []
    property var modelArray: []
    property var currentArr

    property var sectionArr: ["Hair", "Makeup", "Model", "Wardrobe", "Photographer", "Studio"]

    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

        Column {
            id: contentCol
            width: parent.width
            Rectangle {width: spacerW; height: spacerH}
            AppText {text:"Hair"}
            AppListView {
                id: hairModel
                model: hairArray
                height: dp(40)
                interactive: false
                emptyText.text: "Add your hair team"
                delegate: SimpleRow {
                    text: model.name;
                    enabled: false;
                    imageSource: model.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    Rectangle {
                        height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                        IconButton {icon: IconType.envelope}
                    }
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                }
            }
            UserSearchDropdown {
                Component.onCompleted: console.log("LOADED")
                width: parent.width
                height: dp(40)
                onSearchStarted: {console.log("Hair"); currentArr = "Hair"}
                onEndSearch: {teamItem.hairArrayChanged()}
            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text:"Makeup"}
            AppListView {
                id: makeupModel
                model: makeupArray
                height: dp(40)
                interactive: false
                emptyText.text: "Add your makeup team"
                delegate: SimpleRow {
                    text: model.name;
                    enabled: false;
                    imageSource: model.image
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    Rectangle {
                        height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                        IconButton {icon: IconType.envelope}
                    }
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                }
            }
            UserSearchDropdown {
                width: parent.width;                 height: dp(40)

                onSearchStarted: {console.log("Makeup"); currentArr = "Makeup"}
                onEndSearch: {teamItem.makeupArrayChanged()}

            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text:"Model"}
            AppListView {
                id: modelModel
                model: modelArray
                interactive: false
                height: dp(40)

                emptyText.text: "Add your models"
                delegate: SimpleRow {
                    text: model.name;
                    enabled: false;
                    imageSource: model.image
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    Rectangle {
                        height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                        IconButton {icon: IconType.envelope}
                    }
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                }
            }
            UserSearchDropdown {
                width: parent.width
                height: dp(40)

                onSearchStarted: {console.log("Model"); currentArr = "Model"}
                onEndSearch: {teamItem.modelArrayChanged()}

            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text:"Wardrobe"}
            AppListView {
                id: wardrobeModel
                model: wardrobeArray
                interactive: false
                height: dp(40)

                emptyText.text: "Add your wardrobe stylists"
                delegate: SimpleRow {
                    text: model.name;
                    enabled: false;
                    imageSource: model.image
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    Rectangle {
                        height: parent.height; width: height; anchors.right: parent.right; color: "transparent"
                        IconButton {icon: IconType.envelope}
                    }
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                }
            }
            UserSearchDropdown {
                height: dp(40)

                width: parent.width
                onSearchStarted: {console.log("Wardrobe"); currentArr = "Wardrobe"}
                onEndSearch: {teamItem.wardrobeArrayChanged()}
            }
            Rectangle {width: spacerW; height: spacerH}
            AppText {text:"Model"}
            AppListView {
                id: photoModel
                model: photoArray
                height: dp(40)

                interactive: false
                emptyText.text: "Add your photography team"
                delegate: SimpleRow {
                    text: model.name;
                    enabled: false;
                    imageSource: model.image
                    image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
                    Rectangle {
                        height: parent.height; width: height; anchors.right: parent.right; color: "transparent";
                        IconButton {icon: IconType.envelope}
                    }
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                }
            }
            UserSearchDropdown {
                width: parent.width
                height: dp(40)

                onSearchStarted: {console.log("Photo"); currentArr = "Photo"}
                onEndSearch: {teamItem.photoArrayChanged()}
            }
            Rectangle {width: spacerW; height: spacerH}
        }
    }

