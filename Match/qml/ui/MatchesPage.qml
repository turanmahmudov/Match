import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

//import "../components"

import "../js/Storage.js" as Storage

Page {
    id: matchesPage

    header: PageHeader {
        title: i18n.tr("Matches")
        contents: Row {
            spacing: units.gu(1)
            anchors.centerIn: parent

            Icon {
                name: "message"
                width: units.gu(4)
                height: units.gu(4)
                color: "#DF4723"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: matchesPage.header.title
                fontSize: "large"
                color: "#DF4723"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        leadingActionBar.actions: [matchAction]
    }

    MouseArea {
        anchors.fill: parent
        property string direction: "None"
        property real lastX: -1

        onPressed: lastX = mouse.x

        onReleased: {
            var diff = mouse.x - lastX
            if (Math.abs(diff) < units.gu(4)) {
                return;
            } else if (diff < 0) {
                return;
            } else if (diff > 0) {
                tabs.selectedTabIndex = 0
            }
        }
    }
}
