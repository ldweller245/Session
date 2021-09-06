import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0

Page {

    id: castingPage
    title: "Castings"

    readonly property real spacerH: dp(Theme.navigationBar.height)
    readonly property real spacerW: parent.width
    property var castingArr: [{"id": 1,"location": "", "details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 15th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        }, {"id": 2,"location": "", "details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "December 15th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        }, {"id": 3,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 20th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        }, {"id": 4,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 14th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        }, {"id": 5,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 6,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 7,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 8,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 9,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 10,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        },{"id": 11,"location": "","details": "seeking female models over 5'7 to fit dress size 6-8 ", "title": "LFW FEMALE MODELS NEEDED","date": "November 11th", "image": "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/743/cached.offlinehbpl.hbpl.co.uk/news/OMC/Fyodor_Golan_LFW_experiential-2017022212522093.jpg"
        }
    ]
    JsonListModel {
        id: jsonModel
        source: castingArr
        keyField: "id"
        fields: ["id", "date", "details", "title", "image", "location"]
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: {sourceModel = jsonModel}
        sorters: RoleSorter {roleName: "date"; ascendingOrder: true}
    }
    Column {
        anchors.fill: parent
        Rectangle {width: spacerW; height: spacerH; color: "transparent"}
        AppText {text: "<b>Create Casting" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        Rectangle {
            width: spacerW; height: parent.height/4
            IconButton {
                anchors.fill: parent
                icon: IconType.plus
                onClicked: createCastingModal.open()
            }
        }
        AppText {text: "<b>View My Castings" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15); bottomPadding: dp(15)}
        AppListView {
            width: parent.width; height: parent.height/2; model: sortedModel
            delegate: AppCard {
                id: card; width: parent.width; margin: dp(15); paper.radius: dp(5)
                header: SimpleRow {
                    text: model.title; detailText: model.date; enabled: false
                    style: StyleSimpleRow {showDisclosure: false; backgroundColor: "transparent"}
                    onSelected: {organiseStack.push(viewCastingPage, {castingDetails: castingDetails})}
                }
                media: AppImage {width: parent.width; fillMode: Image.PreserveAspectFit; source: model.image}
                content: AppText{width: parent.width; padding: dp(15); text: model.details}
                actions: Row {
                    IconButton {icon: IconType.thumbsup}
                    IconButton {icon: IconType.sharealt}
                    AppButton {text: "View Details"; flat: true; onClicked: organiseStack,push(viewCastingPage, {castingDetails: castingDetails})}
                }
            }
        }
    }
    AppModal {
        id: createCastingModal; pushBackContent: navigationRoot
        NavigationStack {
            CreateCasting {
                id: createCastingPage
                rightBarItem: TextButtonBarItem {
                    text: "Close"; textItem.font.pixelSize: sp(16); onClicked: createCastingModal.close()
                }
            }
        }
    }//end modal
}
