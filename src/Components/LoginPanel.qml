import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: Screen.height * 0.028
  property var inputWidth: Screen.width * 0.1
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      right: parent.right
    }
    SessionPanel {
      id: sessionPanel
    }
    SleepButton {
      id: sleepButton
    }
    RebootButton {
      id: rebootButton
    }
    PowerButton {
      id: powerButton
    }
    z: 5
  }
  Column {
    spacing: 8
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: inputHeight
      width: parent.width
    }
    PasswordField {
      id: passwordField
      height: inputHeight
      width: parent.width
      onAccepted: loginButton.clicked()
    }
    Item {
        height: 16
        width: 1
    }
    Button {
      id: loginButton
      height: inputHeight
      width: parent.width
      enabled: user != "" && password != "" ? true : false
      hoverEnabled: true
      contentItem: Text {
        id: buttonText
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize
          bold: false
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.onPrimary
        text: "Login"
      }
      background: Rectangle {
        id: buttonBackground
        color: config.Primary
        radius: 6
      }
      states: [
        State {
          name: "pressed"
          when: loginButton.down
          PropertyChanges {
            target: buttonBackground
            color: config.hover
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "hovered"
          when: loginButton.hovered
          PropertyChanges {
            target: buttonBackground
            color: config.hover
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "enabled"
          when: loginButton.enabled
          PropertyChanges {
            target: buttonBackground
          }
          PropertyChanges {
            target: buttonText
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 300
        }
      }
      onClicked: {
        sddm.login(user, password, session)
      }
    }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
