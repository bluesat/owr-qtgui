import QtQuick 2.0
import QtQuick.Window 2.2
import bluesat.owr 1.0
import bluesat.owr.singleton 1.0

Window {
    id: main_window
    width: 800
    height: 800
    property alias cmd_vel_display: cmd_vel_display
    title: "BLUEsat OWR"
    visible: true
    minimumHeight: 600
    minimumWidth: 600
    
    Image {
        id: logo
        source: "/images/bluesatLogo.png"
        width: 244
        height: 116
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }


    Item {
        id: video_pane
        x: 198
        width: 245
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        anchors.topMargin: 83
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 351
        ROSVideoComponent {
            // @disable-check M16
            objectName: "videoStream"
            id: videoStream
            // @disable-check M16`
            anchors.bottom: parent.bottom
            // @disable-check M16
            anchors.bottomMargin: 0
            // @disable-check M16
            anchors.top: parent.top
            // @disable-check M16
            anchors.left: parent.left
            // @disable-check M16
            anchors.right: parent.right
            // @disable-check M16
            topic: topic.text
        }
    }

    TextInput {
        id: topic
        x: 40
        y: 335
        width: 80
        height: 20
        text: qsTr("/cam0")
        font.pixelSize: 12
    }

    Cmd_Vel_Display {
        id: cmd_vel_display
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 7
        anchors.left: video_pane.left
        anchors.leftMargin: -265
        anchors.right: video_pane.right
        anchors.rightMargin: 265
        anchors.top: video_pane.bottom
        anchors.topMargin: 100
    }

    Item {
        id: arm_acutator_display
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 7
        anchors.left: cmd_vel_display.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 205
        anchors.top: video_pane.bottom
        anchors.topMargin: 100
        Arm_Acutator_Display {
            id: arm_lower
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.verticalCenter
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            name_text: "Arm Lower"

            Component.onCompleted: {
                RoverCmdState.onArm_lower_changed.connect(stateChanged);
            }

            function stateChanged() {

                if(RoverCmdState.arm_lower == 1500) {
                    extension_state = qsTr("Stop");
                } else if (RoverCmdState.arm_lower > 1500) {
                    extension_state = qsTr("Extend");
                } else {
                    extension_state = qsTr("Retract");
                }
            }

        }
        Arm_Acutator_Display {
            id: arm_upper
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: arm_lower.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            name_text: "Arm Upper"

            Component.onCompleted: {
                RoverCmdState.onArm_upper_changed.connect(stateChanged);
                console.log("connected");
            }

            function stateChanged() {
                console.log("changed");
                if(RoverCmdState.arm_upper == 1500) {
                    extension_state = qsTr("Stop");
                } else if (RoverCmdState.arm_upper < 1500) {
                    extension_state = qsTr("Extend");
                } else {
                    extension_state = qsTr("Retract");
                }
            }
        }
    }

}
