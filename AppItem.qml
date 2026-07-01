import QtQuick
import QtQuick.Controls

Item {
    id: root

    property string appName: ""
    property string appIcon: ""
    property bool isSelected: false
    property int distance: 0
    property real listHeight: 0

    readonly property real absDist: Math.abs(distance)
    readonly property bool isVisible: absDist <= 3
    readonly property real normDist: absDist / 3.0

    width: 300
    height: 60

    x: isVisible ? 30 + 20 * (1 - normDist * normDist) : -width

    y: {
        var centerY = listHeight / 2 + distance * 72
        return centerY - height / 2
    }

    opacity: isVisible ? 0.15 + 0.85 * (1 - normDist * normDist) : 0
    visible: isVisible
    z: isSelected ? 100 : Math.max(0, 100 - absDist * 10)

    transform: Scale {
        origin.x: 0
        origin.y: height / 2
        xScale: isVisible ? 0.7 + 0.3 * (1 - normDist * normDist) : 0
        yScale: isVisible ? 0.7 + 0.3 * (1 - normDist * normDist) : 0
    }

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: isSelected ? "#3dd1b033" : "#18ffffff"
    }

    Row {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 16
            rightMargin: 16
        }
        spacing: 16

        Rectangle {
            id: iconCircle
            width: 40
            height: 40
            radius: 20
            color: isSelected ? "#3dd1b0" : "#22ffffff"

            Image {
                id: iconImg
                anchors.centerIn: parent
                width: 22
                height: 22
                source: root.appIcon
                sourceSize.width: 22
                sourceSize.height: 22
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                visible: status === Image.Ready
            }

            Text {
                anchors.centerIn: parent
                text: appName.length > 0 ? appName.charAt(0).toUpperCase() : "?"
                color: isSelected ? "#1a1b26" : "#aaaaaa"
                font.pixelSize: 17
                font.bold: true
                visible: iconImg.status !== Image.Ready
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: appName
                color: isSelected ? "#ffffff" : "#aaaaaa"
                font.pixelSize: isSelected ? 16 : 13
                font.bold: isSelected
                elide: Text.ElideRight
                width: root.width - 80
            }
        }
    }

    Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
    Behavior on y { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
    Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
}
