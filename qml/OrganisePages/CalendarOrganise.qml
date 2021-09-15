import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import QtLocation 5.12 as QL
import QtPositioning 5.12
import Felgo 3.0
import "../Plugins"
import "../Components"

Page {
    id: calendarPage;
    title: "CALENDAR"

    signal addCalendarItem(var date, var name, var time, var location, var details)
    signal editCalendarItem (var id, var calendarItem)
    signal deleteCalendarItem(var id)

    property var jsonArray: Object.values(dataModel.calendarData)

    JsonListModel {
        id: jsonModel
        source: jsonArray
        keyField: "id"
        fields: ["id", "creation_date", "date", "details", "location", "name", "time"]
    }
        SortFilterProxyModel {
            id: sortedModel; Component.onCompleted: {sourceModel = jsonModel}
            filters: ExpressionFilter {id: calendarDateFilter; expression: model.date  === calendar.selectedDate.getTime(); enabled: true}
            sorters: RoleSorter {roleName: "time"; ascendingOrder: false}
        }
    Flow {
        id: row; anchors.fill: parent; spacing: 10; layoutDirection: Qt.RightToLeft
        Calendar {
            id: calendar
            width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width); height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
            selectedDate: new Date(); focus: true
            onSelectedDateChanged: {
                var date = calendar.selectedDate
                var time = new Date().getTime()
                const day = selectedDate.getDate();
                const month = selectedDate.getMonth() + 1;
                const year = selectedDate.getFullYear();
            }
            style: CalendarStyle {
                id: calendarStyle
                navigationBar: Rectangle {
                    height: Math.round(TextSingleton.implicitHeight * 2.73)
                    color: "#f9f9f9"
                    Rectangle {color: Qt.rgba(1,1,1,0.6); height: 1; width: parent.width}
                    Rectangle {anchors.bottom: parent.bottom; height: 1; width: parent.width; color: "#ddd"}
                    HoverButton {
                        id: previousMonth; width: parent.height; height: width; anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; source: "../../assets/leftanglearrow.png"
                        onClicked: {control.showPreviousMonth()}
                    }
                    Label {id: dateText; text: styleData.title; elide: Text.ElideRight; color: "#4e4e4e"; horizontalAlignment: Text.AlignHCenter; font.pixelSize: TextSingleton.implicitHeight * 1.25; anchors.verticalCenter: parent.verticalCenter; anchors.left: previousMonth.right; anchors.leftMargin: 2; anchors.right: nextMonth.left; anchors.rightMargin: 2; }
                    HoverButton {
                        id: nextMonth; width: parent.height; height: width; anchors.verticalCenter: parent.verticalCenter; anchors.right: parent.right; source: "../../assets/rightanglearrow.png"
                        onClicked: {control.showNextMonth()}
                    }
                }
                dayOfWeekDelegate: Item {
                    height: dp(30); width: parent.width
                    Rectangle {
                        height: parent.height; width: parent.width; anchors.fill: parent; border.color: "#00000000"
                        Label {id: dayOfWeekDelegateText; text: Qt.locale().dayName(styleData.dayOfWeek, Locale.ShortFormat); anchors.centerIn: parent; color: "#4e4e4e"}
                    }
                }
                dayDelegate: Item {
                    id: container

                    readonly property color sameMonthDateTextColor: "#444"
                    readonly property color selectedDateColor: "#424B54"
                    readonly property color selectedDateTextColor: "#bbb"
                    readonly property color differentMonthDateTextColor: "#bbb"
                    readonly property color invalidDatecolor: "#dddddd"
                    
                    Grid {
                        id: calendarMarkerEventGrid
                        z:2
                        columns: 4
                        anchors.fill: parent
                        Repeater {
                            model: {
                                var found = jsonArray.filter(function (element) {return element.date === styleData.date.getTime();});
                                if(found === undefined)
                                    return 0;
                                return found.length;
                            }
                            delegate: Rectangle {id: calendarMarkerRect; z: 1;scale: 0.9 ; width: calendarMarkerEventGrid.width / 4; anchors.margins: -1; height: width; radius: parent.width/2; color: "#B38D97"}
                        }
                    }
                    Rectangle {id: calendarCurrentDayMarker; z: 1; anchors.fill: parent; anchors.margins: -1; width: 12; height: width;
                        color: {
                            if (styleData.date !== undefined) {
                                if (styleData.selected)
                                    return selectedDateColor;
                            }
                            return "transparent"
                        }
                    }
                    Label {
                        id: dayDelegateText; z: 5; text: styleData.date.getDate(); anchors.centerIn: parent
                        color:  {
                            var color = invalidDatecolor;
                            if (styleData.valid) {
                                color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor ;
                                if (styleData.selected) {
                                    color = selectedDateTextColor;
                                }
                            }
                            color ;
                        }
                    }
                }
            }
        }
        Component {
            id: eventListHeader
            Row {
                z: 6; id: eventDateRow; width: parent.width; height: eventDayLabel.height; spacing: 10
                Label {id: eventDayLabel; text: calendar.selectedDate.getDate(); font.pointSize: 35; color: "#4e4e4e"}
                Column {
                    height: eventDayLabel.height
                    Label {readonly property var options: { weekday: "long" } text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat); font.pointSize: 18; color: "#4e4e4e"}
                    Label {text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())+ calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy"); font.pointSize: 12; color: "#4e4e4e"}
                }
            }
        }
        Rectangle {
            width: (parent.width > parent.height ? parent.width * 0.4 - parent.spacing : parent.width); height: (parent.height > parent.width ? parent.height * 0.4 - parent.spacing : parent.height); border.color: Qt.darker(color, 1.2)
            ListView {
                id:eventListView; spacing: 4; clip: true; header: eventListHeader; anchors.fill: parent; anchors.margins: 10;
                model: sortedModel
                delegate: SwipeOptionsContainer {
                    id: swipeContainer
                    Rectangle {
                        width: eventListView.width; height: eventItemColumn.height; anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle {width: parent.width; height: 1; color: "#eee"}
                        Column {
                            id: eventItemColumn; anchors.left: parent.left; anchors.leftMargin: 20; anchors.right: parent.right; height: timeLabel.height + nameLabel.height + 8
                            Label {id: nameLabel; width: parent.width; wrapMode: Text.Wrap; text: model.time + "<br>" + model.details; color: "#4e4e4e"}
                            Label {id: timeLabel; width: parent.width; wrapMode: Text.Wrap; color: "#aaa"; text: model.location}
                            Rectangle {width: parent.width; height: 1; color: "#eee"}
                        }
                        IconButton {
                            height: eventItemColumn.height; width: height; anchors.right: parent.right; anchors.rightMargin: dp(15); icon: IconType.arrowleft
                            onClicked: swipeContainer.showRightOption()
                        }
                    }
                    rightOption: Rectangle {
                        height: eventItemColumn.height; width: calendarPage.width /2 + 3
                        color: "#eee"
                        Row {
                            anchors.fill: parent
                            IconButton {
                                height: parent.height; width: parent.width/4; icon: IconType.arrowright
                                onClicked: swipeContainer.hideOptions()
                            }
                            Rectangle {color: "black"; height: parent.height * 0.8; width: 1; anchors.verticalCenter: parent.verticalCenter}
                            IconButton {
                                height: parent.height; width: parent.width/4; icon: IconType.trash
                                onClicked: calendarPage.deleteCalendarItem(model.id)
                            }
                            Rectangle {color: "black"; height: parent.height * 0.8; width: 1; anchors.verticalCenter: parent.verticalCenter}
                            IconButton {
                                height: parent.height; width: parent.width/4; icon: IconType.edit
                                onClicked: {}
                            }
                            Rectangle {color: "black"; height: parent.height * 0.8; width: 1; anchors.verticalCenter: parent.verticalCenter}
                            IconButton {
                                height: parent.height; width: parent.width/4; icon: IconType.externallink
                                onClicked: {}
                            }
                        }
                    }
                }
            }
        }
    }
    FloatingActionButton {visible: true; icon: IconType.plus; onClicked: createCalendarItemModal.open()}
    AppModal {
        id: createCalendarItemModal; fullscreen: false; modalHeight: calendarPage.height*0.8
        NavigationStack {
            Page {
                id: eventItemPage
                clip: true
                leftBarItem: TextButtonBarItem {
                    text: "Cancel"; textItem.font.pixelSize: sp(16); onClicked: createCalendarItemModal.close()
                }
                rightBarItem: TextButtonBarItem {
                    text: "Save"; textItem.font.pixelSize: sp(16); onClicked:{
                        if(calendarEventTitle.length === 0) {nativeUtils.displayMessageBox(qsTr("You need to add a title"))}
                        else {calendarPage.addCalendarItem(new Date(calendar.selectedDate).getTime(), calendarEventTitle.text, timeTextField.text, searchTextField.text, appTextEdit.text); createCalendarItemModal.close()}
                    }
                }
                AppFlickable {
                    anchors.fill: parent; contentHeight: addEventCol.height
                    Column {
                        id: addEventCol; width: parent.width
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        AppText {
                            horizontalAlignment: Text.AlignHCenter; width: parent.width; font.bold: true; text: "Create an event for: <br>" + new Date(calendar.selectedDate).toDateString()
                        }
                        Rectangle {color: "black"; width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter}
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        AppText {width: parent.width; text: "<b>TITLE" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        Row {
                            width: parent.width
                            AppText {padding: dp(15)}
                            AppTextField {id: calendarEventTitle; placeholderText: "Event name";}
                        }
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        AppText {width: parent.width; text: "<b>TIME" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        Row {
                            width: calendarPage.width
                            AppText {id: timeText; padding: dp(15)}
                            AppTextField {id: timeTextField; placeholderText: "Start time"; enabled: false; text: timeTumblerSelection === undefined ? "" : timeTumblerSelection}
                            IconButton {id: timeIconButton; icon: IconType.clocko; onClicked: timeTumblerModal.open()}
                        }
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        AppText {width: parent.width; text: "<b>LOCATION" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        Row {
                            width: eventItemPage.width
                            AppText {id: locationText; padding: dp(15)}
                            Item {
                                width: parent.width; height: searchTextField.displayText.length > 2 ? searchTextField.height + suggestionsList.height : searchTextField.height
                                Column {
                                    anchors.fill: parent; z:5; height: searchTextField.height + suggestionsList.height;width: parent.width
                                    AppTextField {
                                        id: searchTextField; leftPadding: Theme.navigationBar.defaultBarItemPadding; placeholderText: qsTr("Add Location")
                                        onAccepted: {focus = false; if (text != "") {geocodeModel.query = text}}
                                        onDisplayTextChanged: {
                                            if (searchTextField.displayText.length > 2 && searchTextField.focus) {
                                                suggenstionModel.searchTerm = searchTextField.displayText.toString();suggenstionModel.update()}
                                            else if(searchTextField.displayText.length === 0) {suggestionsList.hide()}
                                        }
                                        onFocusChanged: {if (!focus) {suggestionsList.hide()}}
                                        Component.onCompleted: {font.pixelSize = sp(16)}
                                    }
                                    SuggestionsList {
                                        id: suggestionsList; rowHeight: searchTextField.height; width: parent.width; model: suggenstionModel; anchors {horizontalCenter: parent.horizontalCenter}
                                        onProposalSelected: {searchTextField.focus = false; searchTextField.text = suggestion; geocodeModel.query = suggestion}
                                    }
                                }
                            }
                        }
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        AppText {width: parent.width; text: "<b>DETAILS" + "&nbsp;&nbsp;&nbsp;>"; leftPadding: dp(15)}
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height)/2; color: "transparent"}
                        Rectangle {
                            width: eventItemPage.width; height: eventItemPage.height / 4;
                            Rectangle {
                                id: overviewBorderRect; border.color: "black"; border.width: dp(1); width: parent.width; scale: 0.93; height: calendarPage.height / 6
                                AppFlickable {
                                    id: flick; anchors.fill: parent; contentWidth: width; contentHeight: appTextEdit.height
                                    AppTextEdit {
                                        id: appTextEdit; width: parent.width; wrapMode: Text.WrapAtWordBoundaryOrAnywhere; height: Math.max(appTextEdit.contentHeight, flick.height); verticalAlignment: TextEdit.AlignTop; cursorInView: true; cursorInViewBottomPadding: dp(25); cursorInViewTopPadding: dp(25); flickable: flick
                                        placeholderText: " Any details?"
                                    }
                                }
                                ScrollIndicator {flickable: flick}
                            }
                        }
                        Rectangle {width: parent.width; height: dp(Theme.navigationBar.height); color: "transparent"}
                    }
                }
            }
        }
    }
    AppModal {
        id: timeTumblerModal; fullscreen: false; pushBackContent: navigationRoot; modalHeight: calendarPage.height / 2.5;
        NavigationStack {
            TimeTumbler {
            }
        }
    }
    QL.GeocodeModel {id: geocodeModel; plugin: MapBoxPlugin {geocoding: true} autoUpdate: true
        onLocationsChanged: {
            console.log("count: " + count)
            for(var i = 0; i < count; i++){
                var address = get(i).address
                var fullText
                fullText = "str: "+ address.street + " City: " + address.city + " Country: " + address.country

                console.log("get: " + fullText + "<br>")
            }
        }
    }
    QL.PlaceSearchModel {
        id: suggenstionModel; plugin:  MapBoxPlugin {geocoding: true}
        onStatusChanged: {if (status == QL.PlaceSearchSuggestionModel.Ready) {suggestionsList.show()}}
    }
}

