import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

import "../js/Storage.js" as Storage
import "../js/Helper.js" as Helper

Item {
    property var rec_user

    Column {
        width: parent.width
        spacing: units.gu(1)
        height: parent.height - personActionButtons.height - units.gu(2)

        Image {
            width: parent.width
            height: parent.height - personBio.height - units.gu(1)
            source: rec_user ? rec_user.photos[0].url : ""
            fillMode: Image.PreserveAspectCrop

            MouseArea {
                anchors.fill: parent
                property string direction: "None"
                property real lastX: -1

                onPressed: lastX = mouse.x

                onMouseXChanged: {
                    var diff = mouse.x - lastX
                    if (Math.abs(diff) < units.gu(4)) {
                        nopeNotice.visible = false
                        likeNotice.visible = false
                    } else if (diff < 0) {
                        nopeNotice.visible = true
                    } else if (diff > 0) {
                        likeNotice.visible = true
                    }
                }

                onReleased: {
                    var diff = mouse.x - lastX
                    if (Math.abs(diff) < units.gu(4)) {
                        return;
                    } else if (diff < 0) {
                        tinder.dislike(rec_user._id)
                        nopeNotice.visible = false
                    } else if (diff > 0) {
                        tinder.like(rec_user._id)
                        likeNotice.visible = false
                    }
                }
            }

            Rectangle {
                id: likeNotice
                visible: false
                anchors.left: parent.left
                anchors.top: parent.top
                width: units.gu(12)
                height: units.gu(6)
                color: "transparent"
                border.width: units.gu(1)/2
                border.color: UbuntuColors.green
                Label {
                    text: i18n.tr("LIKE")
                    fontSize: "x-large"
                    font.weight: Font.Bold
                    color: UbuntuColors.green
                    anchors.centerIn: parent
                }
                transform: Rotation {
                    origin.x: likeNotice.width
                    origin.y: likeNotice.height
                    angle: 315
                }
            }

            Rectangle {
                id: nopeNotice
                visible: false
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: units.gu(3)
                anchors.topMargin: units.gu(9)
                width: units.gu(12)
                height: units.gu(6)
                color: "transparent"
                border.width: units.gu(1)/2
                border.color: UbuntuColors.red
                Label {
                    text: i18n.tr("NOPE")
                    fontSize: "x-large"
                    font.weight: Font.Bold
                    color: UbuntuColors.red
                    anchors.centerIn: parent
                }
                transform: Rotation {
                    origin.x: nopeNotice.width
                    origin.y: nopeNotice.height
                    angle: 45
                }
            }
        }

        Column {
            id: personBio
            spacing: units.gu(0.5)

            Flow {
                spacing: units.gu(1)

                Label {
                    text: rec_user ? (rec_user.name + ",") : ""
                    fontSize: "medium"
                    font.weight: Font.DemiBold
                }

                Label {
                    text: rec_user ? Helper.calculate_age(rec_user.birth_date) : ""
                    fontSize: "medium"
                }
            }

            Label {
                text: rec_user ? Helper.get_school(rec_user.schools) : ''
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
                maximumLineCount: 1
                wrapMode: Text.WordWrap
            }
        }
    }

    Row {
        id: personActionButtons
        spacing: units.gu(2)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        PersonActionButton {
            iconName: "reload"
            iconColor: UbuntuColors.orange

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    person--
                    loadPerson()
                }
            }
        }

        PersonActionButton {
            iconName: "close"
            iconColor: UbuntuColors.red

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    tinder.dislike(rec_user._id)
                }
            }
        }

        PersonActionButton {
            iconName: "like"
            iconColor: UbuntuColors.green

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    tinder.like(rec_user._id)
                }
            }
        }

        PersonActionButton {
            iconName: "starred"
            iconColor: UbuntuColors.blue

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    tinder.superlike(rec_user._id)
                }
            }
        }
    }
}
