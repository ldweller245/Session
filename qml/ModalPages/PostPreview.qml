import QtQuick 2.0
import QtQuick 2.11
import Felgo 3.0
import QtLocation 5.12 as QL
import QtPositioning 5.12
import "../Plugins"
import "../Components"
import "../ModalPages"

Page {
    id: page; title: "PREVIEW"

    property var previewData

    property var imageToPost
    property var imageSourceWidth
    property var imageSourceHeight
    property var team:[]

    AppFlickable {
        id:flick
        anchors.fill: parent; contentWidth: width; contentHeight: card.height + dp(150)
        AppCard {
            id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
            header: SimpleRow {imageSource: userData.profile_Pic_URL; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop; text: userData.username; detailText: userData.role; enabled: false; style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}}
            media: Rectangle {
                width: parent.width; height: previewData.image === undefined ? width/2 : selectedImage.height; color: "lightgrey"
                AppText {text: "No Image Selected"; anchors.centerIn: parent}
                AppImage {id: selectedImage; source: previewData.image; width: parent.width; height: imageToPost !== undefined || "" || " " || "undefined" ? Image.height : parent.width; anchors.centerIn: parent; autoTransform: true; smooth: true; fillMode: Image.PreserveAspectFit}
            }
            content: Column {
                id: detailCol; width: parent.width
                Row {
                width: parent.width
                Icon {icon: IconType.mapmarker}
                AppText {text: previewData.location; padding: dp(15)}
                }
                AppText {text: previewData.details; width: parent.width; padding: dp(15)}
            }
            actions: Column {
                AppText {padding: dp(15); text: "<b>Hair:"; visible: hairRepeater.count !== 0}
                Repeater {
                    id: hairRepeater; model: previewData.team.hair; visible: hairRepeater.count !== 0
                    AppText {padding: dp(15); color: "grey"; text: previewData.team.hair[index].name; width: parent.width}
                }
                AppText {padding: dp(15); text: "<b>Makeup:"; visible: makeupRepeater.count !== 0}
                Repeater {
                    id: makeupRepeater; model: previewData.team.makeup; visible: makeupRepeater.count !== 0
                    AppText {padding: dp(15); color: "grey"; text: previewData.team.makeup[index].name; width: parent.width}
                }
                AppText {padding: dp(15); text: "<b>Wardrobe:"; visible: wardrobeRepeater.count !== 0}
                Repeater {
                    id: wardrobeRepeater; model: previewData.team.wardrobe; visible: wardrobeRepeater.count !== 0
                    AppText {padding: dp(15); color: "grey"; text: previewData.team.wardrobe[index].name; width: parent.width}
                }
                AppText {padding: dp(15); text: "<b>Models:"; visible: modelRepeater.count !== 0}
                Repeater {
                    id: modelRepeater; model: previewData.team.models; visible: modelRepeater.count !== 0
                    AppText {padding: dp(15); color: "grey"; text: previewData.team.models[index].name; width: parent.width}
                }
                AppText {padding: dp(15); text: "<b>Photographer:"; visible: photoRepeater.count !== 0}
                Repeater {
                    id: photoRepeater; model: previewData.team.photo; visible: photoRepeater.count !== 0
                    AppText {padding: dp(15); color: "grey"; text: previewData.team.photo[index].name; width: parent.width}
                }
            }
        }
    }
}
