import Felgo 3.0
import QtQuick 2.12
import QtLocation 5.12


Plugin {
  name: system.isPlatform(System.Wasm) || geocoding ? "mapbox" : "mapboxgl"

  property bool geocoding

  // Set your own map_id and access_token here
  parameters: [
    PluginParameter {
      name: "mapbox.mapping.map_id"
      value: "mapbox.streets"
    },
    PluginParameter {
      name: "mapbox.access_token"
      value: "pk.eyJ1IjoibGR3ZWxsZXI5MSIsImEiOiJja295cHYycjEwNWE1MnZuMzc0c25hNHdiIn0.8upklFYqIiaDNxKGvcqOew"
    },
    PluginParameter {
      name: "mapbox.mapping.highdpi_tiles"
      value: true
    }
  ]
}
