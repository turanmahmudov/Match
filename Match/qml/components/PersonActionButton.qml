import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

import "../js/Storage.js" as Storage
import "../js/Helper.js" as Helper

Rectangle {
    property string iconName: ""
    property string iconColor: ""

    width: units.gu(8)
    height: width
    radius: width/2
    color: Qt.lighter(UbuntuColors.silk, 1.21)

    Rectangle {
        width: units.gu(7)
        height: width
        radius: width/2
        anchors.centerIn: parent

        Icon {
            name: iconName
            color: iconColor
            width: units.gu(4)
            height: width
            anchors.centerIn: parent
        }
    }
}
