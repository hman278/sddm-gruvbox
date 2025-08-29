import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: userField
  height: inputHeight
  width: inputWidth
  selectByMouse: true
  echoMode: TextInput.Normal
  selectionColor: config.overlay
  renderType: Text.NativeRendering
  font {
    family: config.Font
    pointSize: config.FontSize
    bold: false
  }
  color: config.text
  horizontalAlignment: Text.AlignHCenter
  placeholderText: "Username"
  placeholderTextColor: config.text
  text: userModel.lastUser
  background: Rectangle {
    id: userFieldBackground
    color: config.surface0
    radius: 6
    border.color: config.border

     // Add icon to background
    Image {
      source: "../icons/user.svg"
      width: 20
      height: 20
      anchors {
        left: parent.left
        leftMargin: 10
        verticalCenter: parent.verticalCenter
      }
    }
  }
  states: [
    State {
      name: "focused"
      when: userField.activeFocus
      PropertyChanges {
        target: userFieldBackground
        color: config.surface1
      }
    },
    State {
      name: "hovered"
      when: userField.hovered
      PropertyChanges {
        target: userFieldBackground
        color: config.surface1
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
}
