import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import Felgo 3.0

Page {
    id: calendarPage; height: parent.height; width: parent.width

Flow {
        id: row
        anchors.fill: parent
        spacing: 10
        layoutDirection: Qt.RightToLeft
        Calendar {
            id: calendar
            width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
            height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
            selectedDate: new Date()
            focus: true
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
                        onClicked: {
                            control.showNextMonth()
                        }
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
                    readonly property color selectedDateColor: "#81b1c2"
                    readonly property color selectedDateTextColor: "#4e4e4e"
                    readonly property color differentMonthDateTextColor: "#bbb"
                    readonly property color invalidDatecolor: "#dddddd"
                    
                    //calendar marker
                    GridView {
                    id: calendarMarker
                    anchors.fill: parent
                    model: 5
                    delegate: Rectangle {id: calendarMarkerRect; z: 1; width: parent.width / 4; anchors.margins: -1; height: width; radius: parent.width/2 ; color:"lightgrey"}
                    }
                    //calendar marker 
                    
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
                model: 10
                delegate: Rectangle {
                    width: eventListView.width; height: eventItemColumn.height; anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {width: parent.width; height: 1; color: "#eee"}
                    Column {
                        id: eventItemColumn; anchors.left: parent.left; anchors.leftMargin: 20; anchors.right: parent.right; height: timeLabel.height + nameLabel.height + 8
                        Label {id: nameLabel; width: parent.width; wrapMode: Text.Wrap; text: modelData.name; color: "#4e4e4e"}
                        Label {id: timeLabel; width: parent.width; wrapMode: Text.Wrap; color: "#aaa"; text: modelData}
                    }
                }
            }
        }
    }
}
