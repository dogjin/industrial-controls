import QtQuick 2.6
import QtQuick.Templates 2.2 as T

import "../Shaders" as Shaders

T.RadioButton {
    id: control

    property alias horizontalAlignment: label.horizontalAlignment

    font.pixelSize: controlSize.fontSize
    height: controlSize.baseSize
    leftPadding: 0
    spacing: controlSize.spacing
    implicitWidth: text.length > 0 ? contentItem.implicitWidth + spacing : indicator.implicitWidth
    hoverEnabled: true

    indicator: BackgroundItem {
        x: control.leftPadding
        y: parent.height * 0.5 - height * 0.5
        radius: width * 0.5
        implicitWidth: controlSize.baseSize
        implicitHeight: controlSize.baseSize
        highlighted: control.activeFocus
        hovered: control.hovered

        Rectangle {
            anchors.fill: parent
            anchors.margins: parent.width * 0.25
            radius: width * 0.5
            color: control.down ? customPalette.highlightColor : customPalette.textColor
            visible: control.checked || control.down
        }
    }

    contentItem: Label {
        id: label
        text: control.text
        font: control.font
        leftPadding: indicator.width + spacing
        verticalAlignment: Text.AlignVCenter
    }
}
