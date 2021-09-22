import QtQuick 2.0
import Felgo 3.0

AppListView {
    id: root

    property real rowHeight: dp(40)
    property int fontPixelSize: sp(12)

    visible: true
    clip: true

    boundsBehavior: Flickable.StopAtBounds

    model: searchArr

    delegate: SimpleRow {
        text: modelData.name;
        height: root.rowHeight
        showDisclosure: false
        imageSource: modelData.image; image.radius: image.width/2; image.fillMode: Image.PreserveAspectCrop
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
        duration: 1000
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
}


