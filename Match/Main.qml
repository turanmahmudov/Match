import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

import "qml/js/Storage.js" as Storage

import "qml/ui"
//import "qml/components"

import Tinder 1.0

MainView {
    id: mainView
    objectName: "mainView"
    applicationName: "match.turan-mahmudov-l"
    anchorToKeyboard: true
    automaticOrientation: false

    width: units.gu(50)
    height: units.gu(75)

    // Main Actions
    actions: [
        Action {
            id: optionsAction
            text: i18n.tr("Options")
            iconName: "contact"
            onTriggered: {
                tabs.selectedTabIndex = 1
            }
        },
        Action {
            id: matchAction
            text: i18n.tr("Match")
            iconName: "like"
            onTriggered: {
                tabs.selectedTabIndex = 0
            }
        },
        Action {
            id: matchesAction
            text: i18n.tr("Matches")
            iconName: "message"
            onTriggered: {
                tabs.selectedTabIndex = 2
            }
        }
    ]

    Tinder {
        id: tinder
    }

    PageStack {
        id: pageStack
    }

    Tabs {
        id: tabs
        visible: false

        Tab {
            id: homeTab

            HomePage {
                id: homePage
            }
        }

        Tab {
            id: optionsTab

            OptionsPage {
                id: optionsPage
            }
        }

        Tab {
            id: matchesTab

            MatchesPage {
                id: matchesPage
            }
        }

        onSelectedTabIndexChanged: {

        }
    }

    Component.onCompleted: {
        tinder.auth("EAAGm0PX4ZCpsBAHQOuQ4IGoRvp8Lt6v7fMmeZB8yimML4agGdyKP4WWpqPxB22ZBjdAFFq2TquH66grJsAqTzbizYAq6J7uRfe55cauNEejwufZBorxKjAtKsl2qJ5w7tAWOFP9W2xieBZBRwqLJQBHnP1Ejky0ZCL8m2uAYRDVAZDZD")

        pageStack.push(tabs);
    }

    Connections{
        target: tinder
        onAuthFinished: {
            var result = JSON.parse(answer)
            Storage.set("token", result["token"])
            Storage.set("user_id", result["user"]["_id"])

            tinder.setToken(result["token"])

            pageStack.push(tabs);

            tinder.recs()
            tinder.updates()
        }
        onAuthNotFinished: {
            var result = JSON.parse(answer)
            console.log(result.error)
        }
    }
}
