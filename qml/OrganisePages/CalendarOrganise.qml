import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import Felgo 3.0

Page {
    id: calendarPage; height: parent.height; width: parent.width
/*
    function isEven(n) {
        return n % 2 == 0;
    }
    function groupBy(array, property) {
        var hash = {};
        for (var i = 0; i < array.length; i++) {
            if (!hash[array[i][property]]) hash[array[i][property]] = [];
            hash[array[i][property]].push(array[i]);
        }
        return hash;
    }
    function getSum(total, num) {
        return total + num;
    }
    function saveDate() {
        updateEvents()
        var year

        var time = new Date().getTime()
        var dayIn = calendar.selectedDate.getDay()
        if(testRange.text !== "Multiple Day"){

            var multiDeductTotal = []
            var multiDeductReduce = []
            var grouped = groupBy(multiSelectSaveArr,'leaveYear')
            var sumDays = function sumOfDays(yearArr) {
                return yearArr.reduce(function (a, b) {
                    return a + b.dayValue;
                }, 0);
            };
            var output = Object.values(grouped).reduce(function (a, yearArr) {
                a[yearArr[0].leaveYear] = sumDays(yearArr);
                return a;
            }, {});
            for (var key in output) {
                if (output.hasOwnProperty(key)) {
                    console.log(key + " -> " + output[key]);
                    var takenAllowanceMulti = dataModel.calendarUserItems.users[userName + " " + userSurname].allowances[key].taken
                    var deductMulti = takenAllowanceMulti + output[key]
                    console.log(takenAllowanceMulti)
                    console.log(deductMulti)
                    calendarPage.amendTakenAllowance(deductMulti, key)
                }
            }

            var result = multiSelectSaveArr.map(function(o) {
                o.note = note;
                return o;
            });

            multiSelectSaveArr.forEach(function (val, idx) {
                calendarPage.saveCalendarMultiItem(time = val.creationDate, val);
                if (idx === multiSelectSaveArr.length - 1)
                    calendarPage.notificationCallback();
            });
            multiSelectSaveArr = []
        } else {
            year = getMySpecialYear(calendar.selectedDate)
            var takenAllowance = dataModel.calendarUserItems.users[userName + " " + userSurname].allowances[year].taken
            var container = isEven(selectedWeekNum) ? weeklyHours2 : weeklyHours;
            var dayValue = container[(dayIn + 6) % 7].hours;                        //  mod power returns %%%
            var deduct
            if(dayCycle.text === "Full Day") {
                deduct = takenAllowance + dayValue
            } else {
                var half = dayValue / 2
                deduct = takenAllowance + half
            }
            if (dayCycle.text !== "Full Day") {
                dayValue /= 2
            }
            calendarPage.amendTakenAllowance(deduct, year);
            userData = ({"leaveYear": getMySpecialYear(new Date(calendar.selectedDate)) ,"dayValue": dayValue ,"creationDate": time ,"date": calendar.selectedDate, "name": userName +" "+ userSurname, "details": dayCycle.text, "status": "pending", "dayI": dayIn, "updated": "0", "note": note})
            calendarPage.saveCalendarItem(time, userData)
            dayValue = undefined
            deduct = undefined
            delete(deduct)
            if(dayCycle.text !== "Full Day") {
                currCycleIndex = 0
            }
        }
        currCycleIndex = 0
        dateRangeIndex = 0
        updateEvents()
        multiSelectArr = []
        calendarPage.playVideo()
    }
    function getMySpecialYear(date) {
        var yr = date.getFullYear();
        var fyStart = new Date(yr, customYearY, 1);
        return date < fyStart? yr - 1 : yr;
    }*/


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
                    Rectangle {id: calendarMarker; z: 1; anchors.fill: parent; anchors.margins: -1; width: 12; height: width; scale: 0.5; color:"lightgrey"}
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
                id:eventListView; spacing: 4; clip: true; header: eventListHeader; anchors.fill: parent; anchors.margins: 10; model: 10
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
