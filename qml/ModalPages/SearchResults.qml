import QtQuick 2.0
import Felgo 3.0

Page {

    title: "Results"

    JsonListModel {
        id: searchModel
        keyField: ""
        fields: []
    }
    SortFilterProxyModel {
        id: sortedModel
        Component.onCompleted: sourceModel = searchModel
        filters: [
            ExpressionFilter {
                id: tagFilter
                expression: model.tag === tagSearch
            },
            ExpressionFilter {
                id: genderFilter
                expression: model.gender === genderSearch
                enabled: genderSearch !== "any"
            },
            ExpressionFilter {
                id: experienceFilter
                expression: model.experience === experienceSearch
                enabled: experienceSearch !== "any"
            },
            ExpressionFilter {
                id: ageFilter
                expression: model.age < ageFloor && model.age > ageCeiling
            },
            ExpressionFilter {
                id: heightFilter
                expression: model.height < heightFloor && model.height > heightCeiling
            },
            ExpressionFilter {
                id: ethnicityFilter
                expression: model.ethnicity === ethnicitySearch
                enabled: ethnicitySearch !== "any"
            },
            ExpressionFilter {
                id: hairFilter
                expression: model.hair === hairSearch
                enabled: hairSearch !== "any"
            },
            ExpressionFilter {
                id: hairLenghtFIlter
                expression: model.hairLength === hairLengthSearch
                enabled: hairLengthSearch !== "any"
            },
            ExpressionFilter {
                id: skinFilter
                expression: model.skin === skinSearch
                enabled: skinSearch !== "any"
            },
            ExpressionFilter {
                id: eyeFilter
                expression: model.eye === eyeSearch
                enabled: eyeSearch !== "any"
            },
            ExpressionFilter {
                id: tattooFilter
                expression: model.tattoo === tattooSearch
                enabled: tattooSearch !== "any"
            },
            ExpressionFilter {
                id: piercingFilter
                expression: model.piercing === piercingSearch
                enabled: piercingSearch !== "any"
            }
        ]
        sorters: [
            StringSorter {
                id: activeSorter
                roleName: "lastActive"
            }

        ]

    }
    AppListView {
        anchors.fill: parent
        model: sortedModel
        emptyText.text: qsTr("No search results!")
        delegate: AppCard {
            id: card

            width: explorePage.width
            margin: dp(15)
            paper.radius: dp(5)

            // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
            header: SimpleRow {
                text: ""
                detailText: ""
                enabled: true
                image.radius: image.width/2
                image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {
                    showDisclosure: false
                    backgroundColor: "transparent"
                }
                onSelected: {}
            }
            // For the media cell, we use a simple AppImage
            media: AppImage {
                width: parent.width
                fillMode: Image.PreserveAspectFit
                source: model.owner.profile_Pic_URL
            }

            // For the content cell, we use some placeholder text
            content: Column {
                width: parent.width
                AppText {
                    width: parent.width
                    padding: dp(15)
                    text: ""
                }
                AppText{
                    id: descriptionText
                    width: parent.width
                    padding: dp(15)
                    text: ""
                }
            }
            // Some useless buttons to display in the actions cell
            actions: Row {
                IconButton {
                    icon: IconType.hearto
                    selectedIcon: IconType.heart
                    selected: model.liked_by.liked_by_me
                    toggle: true
                }
                AppText {
                    width: Text.width
                    height: Text.height
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.liked_by.count
                }

                IconButton {
                    icon: IconType.sharealt
                }
                AppButton {
                    text: "Follow"
                    flat: true
                }
            }
        }


    }

}
