import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

import "qml/js/Storage.js" as Storage

import Tinder 1.0

MainView {
    id: mainView
    objectName: "mainView"

    applicationName: "match.turan-mahmudov-l"

    width: units.gu(50)
    height: units.gu(75)

    Tinder {
        id: tinder
    }

    Component.onCompleted: {
        tinder.auth("EAAGm0PX4ZCpsBAPUmfcY793jTyO7oHMg6UOXwGZAWMIPkenZAifd0Qn9aEwgvMGHoCcqsCZBdCqgbpONn2tWRmoT00m0bOUxkhqb1AlTmu8XuqLDOMI43frZAz00wXkvUBV9quhZAZATYXkR3G7PNRAKVcJQmsyaJqzh63429ZBOEZCH5b7Nlzebn")
    }

    Connections{
        target: tinder
        onAuthFinished: {
            var result = JSON.parse(answer)
            Storage.set("token", result["token"])
            Storage.set("user_id", result["user"]["_id"])

            tinder.setToken(result["token"])
        }
        onAuthNotFinished: {

        }
    }
}
