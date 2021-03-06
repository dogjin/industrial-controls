import QtQuick 2.6
import QtQuick.Templates 2.1 as T
import QtQuick.Layouts 1.3

T.ComboBox {
    id: control

    property var currentItem: model && model[currentIndex] ? model[currentIndex] : undefined
    property string iconRole: "icon"
    property string displayIcon: currentItem && currentItem[control.iconRole] !== undefined ?
                                      currentItem[control.iconRole] : ""

    property alias isValid: background.isValid
    property alias labelText: background.text
    property alias labelColor: background.textColor
    property alias backgroundColor: background.color
    property alias contentColor: content.textColor
    property alias horizontalAlignment: content.horizontalAlignment

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    font.pixelSize: controlSize.fontSize
    padding: controlSize.padding
    opacity: enabled ? 1 : 0.33
    clip: true
    textRole: "text"
    displayText: currentItem && currentItem[control.textRole] !== undefined ?
                     currentItem[control.textRole] : currentItem

    indicator: MenuIndicator {
        x: control.width - width
        y: control.height - height
        isValid: control.isValid
        focused: control.activeFocus
        opened: control.down
    }

    background: BackgroundInput {
        id: background
        anchors.fill: parent
        leftPadding: {
            if (displayIcon.length == 0) return controlSize.padding;
            return content.height + controlSize.padding + controlSize.margins;
        }
        inputed: displayText.length > 0
        highlighted: control.activeFocus
    }

    delegate: ItemDelegate {
        width: control.width
        horizontalAlignment: control.horizontalAlignment
        text: modelData[control.textRole] !== undefined ?
                  modelData[control.textRole] : modelData
        iconSource: modelData[control.iconRole] !== undefined ?
                        modelData[control.iconRole] : ""
        font: control.font
        highlighted: control.highlightedIndex === index
        isValid: control.isValid
    }

    contentItem: ContentItem {
        id: content
        anchors.fill: control
        anchors.leftMargin: control.padding
        anchors.rightMargin: control.padding
        font: control.font
        text: displayText
        iconSource: displayIcon
        verticalAlignment: labelText.length > 0 ? Text.AlignBottom : Text.AlignVCenter
        textColor: control.enabled ? customPalette.textColor : customPalette.sunkenColor
    }

    popup: Popup {
        y: control.height
        backgroundColor: background.color
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}
        }
    }
}
