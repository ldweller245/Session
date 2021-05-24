import QtQuick 2.0
import Felgo 3.0

Page {
    id: userProfilePage
    Column {
        anchors.fill: parent
        spacing: 10

        Column {
            id: profileColumn
            width: parent.width
            height: parent.height / 3
            Rectangle {
                width: parent.width
                height: parent.height
                Row {
                    id: profileRow
                    anchors.fill: parent

                    Rectangle {
                        height: profileRow.height
                        width: profileRow.width / 2
                        Column {
                            id: detailsRow
                            anchors.verticalCenter: parent.verticalCenter
                            AppText {
                                id: profileName
                                padding: dp(10)
                                text: "<b>Katie<br>Prescott</b><br>Hairstylist"
                            }
                            AppText {
                                fontSize: profileName.fontSize / 1.3
                                padding: dp(10)
                                color: "grey"
                                text: "<b>London</b>, UK<br><b>Last Active:</b> " + new Date().toDateString()
                            }
                        }
                    }
                    RoundedImage  {
                        id: profileImage
                        width: parent.width / 2
                        height: width
                        scale: 0.9
                        anchors.rightMargin: dp(10)
                        anchors.verticalCenter: parent.verticalCenter
                        source: "https://payload.cargocollective.com/1/10/333868/13868492/6496-13-032-f2-copy_670.jpeg"
                        fillMode: Image.PreserveAspectCrop
                        radius: profileImage.width/2
                    }
                }
            }
        }

        Column {
            id: userStatistics
            width: parent.width
            height: statRow.height
            Row {
                id: statRow
                anchors.horizontalCenter: parent.horizontalCenter
                AppText {
                    text: "<b>PORTFOLIO"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        AppFlickable {
            id: userFeedFlickable
            width: parent.width
            height: parent.height -y
            contentHeight: userFeed.height
            Row {
                width: parent.width
                spacing: 5
                Column {
                    id: userFeed
                    width: parent.width / 3
                    spacing: 5
                    AppImage {MouseArea{anchors.fill: parent; onClicked: PictureViewer.show(userProfilePage, "https://static.wixstatic.com/media/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.webp")} width: parent.width; fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_fceae00c691448708c46c8a3b83b75b2~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_032c471dca1149b1b860927a13525368~mv2.jpeg/v1/fill/w_650,h_767,al_c,q_85/d26481_032c471dca1149b1b860927a13525368~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_5582da7d11e649298358832e94e87da7~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_5582da7d11e649298358832e94e87da7~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_dcea1c70030c4223a348a20c595c3b24~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_dcea1c70030c4223a348a20c595c3b24~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_25f5069dac45495eb674588297777c46~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_25f5069dac45495eb674588297777c46~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_89e69cbd4dc343d0932b1b166534e3a8~mv2.jpg/v1/fill/w_751,h_886,al_c,q_85/d26481_89e69cbd4dc343d0932b1b166534e3a8~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_89e69cbd4dc343d0932b1b166534e3a8~mv2.jpg/v1/fill/w_751,h_886,al_c,q_85/d26481_89e69cbd4dc343d0932b1b166534e3a8~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_e7948fc299764fc0955afabda4ff0484~mv2.jpg/v1/fill/w_558,h_659,al_c,q_85/d26481_e7948fc299764fc0955afabda4ff0484~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_328ca51eec824b1f84f777c69120fea4~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_328ca51eec824b1f84f777c69120fea4~mv2.webp"}
                }
                Column {
                    spacing: 5
                    width: parent.width / 3
                    AppImage {width: parent.width; height: Image.height;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_328ca51eec824b1f84f777c69120fea4~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_328ca51eec824b1f84f777c69120fea4~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_963eb3338625445d904a9fb4a40e54d2~mv2.jpg/v1/fill/w_542,h_640,al_c,q_80/d26481_963eb3338625445d904a9fb4a40e54d2~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_7c8e12e2fc8d41668f4fa74b0f860b87~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_7c8e12e2fc8d41668f4fa74b0f860b87~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_b99a24c50e3044968d350f13e59800b2~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_b99a24c50e3044968d350f13e59800b2~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_79e61e5688e14507a5e6e33e50d6411f~mv2.png/v1/fill/w_850,h_579,al_c,q_90/d26481_79e61e5688e14507a5e6e33e50d6411f~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_83cf4d13274548c099ee6a1b4e01e582~mv2.jpeg/v1/fill/w_542,h_640,al_c,q_80/d26481_83cf4d13274548c099ee6a1b4e01e582~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_4750a7540b0b48d5a617b763e22e747a~mv2.jpg/v1/fill/w_438,h_517,al_c,q_80/d26481_4750a7540b0b48d5a617b763e22e747a~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_45ca6dd8977f4dce839114773258fcda~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_45ca6dd8977f4dce839114773258fcda~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_6b9bee5c977e4a93b3228840c1ced3b7~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_6b9bee5c977e4a93b3228840c1ced3b7~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_e9ace1093c0444cf9749e534c0672272~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_e9ace1093c0444cf9749e534c0672272~mv2.webp	"}
                }
                Column {
                    spacing: 5
                    width: parent.width / 3
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_9c22c1a3c78741979415165293e80759~mv2.jpg/v1/fill/w_735,h_868,al_c,q_85/d26481_9c22c1a3c78741979415165293e80759~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_bfe73963060649c88629e12913733280~mv2.jpg/v1/fill/w_568,h_671,al_c,q_85/d26481_bfe73963060649c88629e12913733280~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_9d86f6a06af8449e906573ce0523431d~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_9d86f6a06af8449e906573ce0523431d~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_9d86f6a06af8449e906573ce0523431d~mv2.jpg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_9d86f6a06af8449e906573ce0523431d~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_db10d4ced03f4c3bbcd46f1a73156cc1~mv2.jpeg/v1/fill/w_824,h_972,al_c,q_85,usm_0.66_1.00_0.01/d26481_db10d4ced03f4c3bbcd46f1a73156cc1~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_fc93bb56cf5f446cbd4506444da8ffe2~mv2.jpg/v1/fill/w_576,h_680,al_c,lg_1,q_85/d26481_fc93bb56cf5f446cbd4506444da8ffe2~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_e6696e0d955945be914cbad19875a124~mv2.jpg/v1/fill/w_576,h_680,al_c,lg_1,q_85/d26481_e6696e0d955945be914cbad19875a124~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_e6696e0d955945be914cbad19875a124~mv2.jpg/v1/fill/w_576,h_680,al_c,lg_1,q_85/d26481_e6696e0d955945be914cbad19875a124~mv2.webp"}
                    AppImage {width: parent.width;fillMode: Image.PreserveAspectFit; source: "https://static.wixstatic.com/media/d26481_c7c804e594cb40fcb8dec064e1270190~mv2.jpeg/v1/fill/w_1703,h_1136,al_c,q_85,usm_0.66_1.00_0.01/d26481_c7c804e594cb40fcb8dec064e1270190~mv2.webp"}
                }
            }
        }
    }
    Row {
        id: floatingProfileRow
        height: floatingProfileRowButton.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: dp(7)
        z: 5
        FloatingActionButton {
            id: floatingProfileRowButton
            visible: true
            anchors.right: undefined
            icon: IconType.book
            onClicked: detailsModal.open()
        }
        FloatingActionButton {
            visible: true
            anchors.right: undefined
            icon: IconType.edit
        }
    }
    AppModal {
        id: detailsModal
        pushBackContent: navigationStack
        fullscreen: false
        modalHeight: userProfilePage.height *0.8
        AppListView {
           model: ListModel {
             ListElement { type: "Bio"; name: "Banana" }
             ListElement { type: "Clients"; name: "Apple"}
             ListElement { type: "Clients"; name: "Fellowship"}
             ListElement { type: "Clients"; name: "Google Zeitgeist"}
             ListElement { type: "Clients"; name: "Pinewood"}
             ListElement { type: "Measurements"; name: "Height: 5'4"}
             ListElement { type: "Measurements"; name: "Shoe: 4"}
           }
           delegate: SimpleRow { text: name; showDisclosure: false }
           section.property: "type"
           section.delegate: SimpleSection { }
         }
    }
}
