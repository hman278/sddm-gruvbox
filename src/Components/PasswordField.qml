import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "Password"
  placeholderTextColor: config.text
  echoMode: TextInput.Password
  passwordCharacter: "•"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.overlay
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pointSize: config.FontSize
  font.bold: false
  color: config.text
  horizontalAlignment: TextInput.AlignHCenter

  // Property to track error state
  property bool hasError: false
  
  // Clear error when user starts typing
  onTextChanged: {
    if (hasError && text.length > 0) {
      hasError = false
    }
  }

  background: Rectangle {
    id: passFieldBackground
    radius: 6
    color: config.surface0
    border.color: passwordField.hasError ? config.borderError : config.border  
    border.width: passwordField.hasError ? 2 : 1
  }

  states: [
    State {
      name: "error"
      when: passwordField.hasError
      PropertyChanges {
        target: passFieldBackground
        color: config.surface0
        border.color: config.borderError
        border.width: 2
      }
    },
    State {
      name: "focused"
      when: passwordField.activeFocus && !passwordField.hasError
      PropertyChanges {
        target: passFieldBackground
        color: config.surface1
        border.color: config.border
        border.width: 1
      }
    },
    State {
      name: "hovered"
      when: !passwordField.hasError && !passwordField.activeFocus
      PropertyChanges {
        target: passFieldBackground
        color: config.surface1
        border.color: config.border
        border.width: 1
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
