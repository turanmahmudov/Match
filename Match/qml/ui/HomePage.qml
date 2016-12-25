import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

//import "../components"

import "../js/Storage.js" as Storage

Page {
    id: homePage

    header: PageHeader {
        title: i18n.tr("Match")
        contents: Row {
            spacing: units.gu(1)
            anchors.centerIn: parent

            Icon {
                source: "../images/tndr.svg"
                width: units.gu(3)
                height: units.gu(4)
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        leadingActionBar.actions: [optionsAction]
        trailingActionBar.actions: [matchesAction]
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
                tabs.selectedTabIndex = 2
            } else if (diff > 0) {
                tabs.selectedTabIndex = 1
            }
        }
    }
}
