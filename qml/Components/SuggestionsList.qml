import Felgo 3.0
import QtQuick 2.12
import QtPositioning 5.12

AppListView {
  id: root

  property real rowHeight: dp(30)
  property int fontPixelSize: sp(12)

  signal proposalSelected(string suggestion)

  height: 0
  visible: false
  clip: true

  boundsBehavior: Flickable.StopAtBounds

  delegate: SimpleRow {
    height: root.rowHeight
    text: place.location.address.text
    onSelected: {
      root.proposalSelected(place.location.address.text)
    }
  }

  PropertyAnimation {
    id: showHideAnimation

    target: root

    property: "height"
    duration: 300
  }

  function show() {
    if (!visible) {
      visible = true
      showHideAnimation.to = root.rowHeight * 4
      showHideAnimation.start()
    }
  }

  function hide() {
    if (visible) {
      visible = false
      showHideAnimation.to = 0
      showHideAnimation.start()
    }
  }
}
