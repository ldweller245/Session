import QtQuick 2.0
import QtQuick.Extras 1.4
import Felgo 3.0

Page {
    id: timeTumbler

    property var minutesModel: ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]

    rightBarItem: TextButtonBarItem {
        text: "Close"; textItem.font.pixelSize: sp(16); onClicked: {
            let tumblerHoursText = tumblerHours.currentIndex + 1; let ampmSwitch = tumblerAMPM.currentIndex === 1 ? "PM" : "AM"
            timeTumblerSelection = tumblerHoursText + ":" + minutesModel[tumblerMinutes.currentIndex] + " "+ampmSwitch; timeTumblerModal.close()
        }
    }
    Tumbler {
        anchors.centerIn: parent
        TumblerColumn {id: tumblerHours; model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]}
        TumblerColumn {id: tumblerMinutes; model: minutesModel}
        TumblerColumn {id: tumblerAMPM; model: ["AM", "PM"]}
    }
}
