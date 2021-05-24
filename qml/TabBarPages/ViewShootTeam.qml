import QtQuick 2.0
import Felgo 3.0

Page {
    id: teamItem
    readonly property real spacerH: dp(Theme.navigationBar.height)/2
    readonly property real spacerW: teamItem.width

    Component {
        id: headerItem
        Rectangle {
            width: parent.width
            height: spacerH*2
            AppText {
                text: "Team:"
                padding: dp(15)
            }
        }
    }

    AppListView {
        id: teamList
        anchors.fill: parent
        model: sortedModel
        header: headerItem
        delegate: SimpleRow {
            id: delegateRow
            text: model.name
            detailText: model.role
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
        section.property: "role"
        section.delegate: SimpleSection { }
    }
}
