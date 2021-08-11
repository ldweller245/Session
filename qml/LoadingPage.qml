import QtQuick 2.0
import Felgo 3.0

Page {
    Rectangle {
        radius: dp(width/2); width: parent.width / 2; height: width; anchors.centerIn: parent; color: "black"
        SequentialAnimation on color {
            ColorAnimation { to: "#424B54"; duration: 1000 }
            ColorAnimation { to: "#424B54"; duration: 1000 }
            ColorAnimation { to: "#B38D97"; duration: 1000 }
            ColorAnimation { to: "#D5ACA9"; duration: 1000 }
            ColorAnimation { to: "#EBCFB2"; duration: 1000 }
            ColorAnimation { to: "#C5BAAF"; duration: 1000 }
            ColorAnimation { to: "#C5BAAF"; duration: 1000 }
        }
        AppText {anchors.centerIn: parent; horizontalAlignment: Text.AlignHCenter; width: parent.width; text: "LOADING"; color: "white"}
    }
}
