import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

import "../components"

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

    Connections{
        target: tinder
        onUpdatesFinished: {
            //console.log(answer)
            var result = JSON.parse(answer)
            for (var i in result['matches']) {
                matchesMessagesModel.append({"match":result['matches'][i]})
            }
        }
    }

    ListModel {
        id: matchesMessagesModel
    }

    ListView {
        id: matchesMessagesList
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: matchesPage.header.bottom
            topMargin: units.gu(1)
        }
        model: matchesMessagesModel
        delegate: ListItem {
            height: layout.height + divider.height + units.gu(2)
            SlotsLayout {
                id: layout
                anchors.verticalCenter: parent.verticalCenter
                mainSlot: Column {
                    id: mainSlot
                    spacing: units.gu(0.5)

                    RowLayout {
                        width: parent.width
                        Flow {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: units.gu(0.5)

                            Label {
                                text: match.person.name
                                fontSize: "medium"
                                maximumLineCount: 1
                                wrapMode: Text.WordWrap
                            }

                            Icon {
                                width: match.is_boost_match || match.is_super_like ? units.gu(2) : 0
                                height: width
                                name: match.is_boost_match ? "flash-on" : (match.is_super_like ? "starred" : "")
                                color: match.is_boost_match ? UbuntuColors.purple : (match.is_super_like ? UbuntuColors.blue : "")
                            }
                        }
                    }

                    RowLayout {
                        width: parent.width
                        Flow {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: units.gu(0.5)

                            Label {
                                text: match.messages[0].message
                                fontSize: "small"
                                color: theme.palette.normal.backgroundSecondaryText
                                maximumLineCount: 1
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }
                        }
                    }
                }

                Rectangle {
                    SlotsLayout.position: SlotsLayout.Leading
                    SlotsLayout.overrideVerticalPositioning: true

                    width: units.gu(10)
                    height: parent.height
                    color: "#dfdfdf"

                    Image {
                        width: parent.width
                        height: parent.height
                        source: match.person.photos[0].url ? match.person.photos[0].url : ""
                        clip: true
                        asynchronous: true
                        cache: true // maybe false
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }

            onClicked: {

            }
        }
    }
}
