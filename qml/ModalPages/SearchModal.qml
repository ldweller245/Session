import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4


FlickablePage {
    id: searchUserPage

    flickable.contentHeight: contentCol.height
    scrollIndicator.visible: false

    Column {
        id: contentCol; spacing: dp(15)
        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)}
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15); text: "Gender: "; width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Male", "Female", "Other" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Location: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Male", "Female", "Other" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Radius: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "5 miles", "10 miles", "25 miles", "50 miles", "100+ miles" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Experience: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "None", "Some", "Very" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Age Range: "
                width: parent.width/3

            }
            Column {
                AppRangeSlider {
                    id: slider
                }
                AppText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:Math.round(slider.first.position * 100)+" - "+Math.round(slider.second.position * 100)
                }
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Height Range (cm): "
                width: parent.width/3

            }
            Column {
                AppRangeSlider {
                    id: heightSlider
                }
                AppText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:Math.round(heightSlider.first.position * 100)+" - "+Math.round(heightSlider.second.position * 100)
                }
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Ethnicity: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Arab", "Asian", "Black", "Mixed", "White", "Other"]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Hair Colour: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Black", "Blonde", "Brown", "Auburn", "Chesnut", "Copper", "Grey/White", "Other"]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Hair Length: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Very Short", "Short", "Shoulder", "Long", "Very Long" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Skin Colour: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Extremely Fair", "Fair", "Medium", "Olive", "Brown", "Black" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                width: parent.width/3
                text: "Eye Colour: "
            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "Brown", "Amber", "Hazel", "Green", "Blue" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Tattoos: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "None", "Some", "Many" ]
            }
        }
        Row {
            width: searchUserPage.width
            AppText {
                padding: dp(15)
                text: "Piercings: "
                width: parent.width/3

            }
            ComboBox {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
                model: [ "Any", "None", "Some", "Many" ]
            }
        }
        Rectangle {
            width: parent.width
            height: searchButton.height
            AppButton {
                id: searchButton
                text: "Search"
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            width: parent.width
            height: dp(Theme.navigationBar.height)
        }
    }
}
