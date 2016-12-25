import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

import "../components"

import "../js/Storage.js" as Storage

Page {
    id: optionsPage

    header: PageHeader {
        title: i18n.tr("Options")
        contents: Row {
            spacing: units.gu(1)
            anchors.centerIn: parent

            Icon {
                name: "contact"
                width: units.gu(4)
                height: units.gu(4)
                color: "#DF4723"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: optionsPage.header.title
                fontSize: "large"
                color: "#DF4723"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        trailingActionBar.actions: [matchAction]
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
                tabs.selectedTabIndex = 0
            } else if (diff > 0) {
                return;
            }
        }
    }
}
