import QtQuick 2.0
import Felgo 3.0
AppImage {
    id: postImage
    MouseArea{
        anchors.fill: parent;
        onClicked: PictureViewer.show(userProfilePage, postImage.source)
    }
    fillMode: Image.PreserveAspectFit;
    source: modelImage

    Component.onCompleted: {
        populateView();
        userFeedArrChanged()
        console.log("create")
    }
    Component.onDestruction: console.log("destroy")

}


