import QtQuick 2.6

import "../Shaders" as Shaders

Item {
    id: control

    property bool highlighted: false
    property bool hovered: false
    property bool isValid: true
    property bool shadow: false
    property int leftPadding: controlSize.padding
    property int croppig: radius
    readonly property int offset: radius + 1

    property alias radius: bg.radius
    property alias color: bg.color

    implicitHeight: controlSize.inputControlHeight

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            id: bg
            color: customPalette.backgroundColor
            anchors.fill: parent
            radius: controlSize.rounding
            anchors.bottomMargin: -croppig

            Rectangle {
                anchors.fill: parent
                color: customPalette.textColor
                radius: parent.radius
                opacity: 0.1
                visible: hovered
            }
        }
    }

    Shaders.Hatch {
        anchors.fill: parent
        color: customPalette.sunkenColor
        visible: !enabled
    }


    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: controlSize.underline
        color: control.isValid ? customPalette.highlightColor : customPalette.dangerColor
        visible: control.highlighted && control.enabled
    }

    Shadow {
        visible: shadow
        source: parent
    }
}
