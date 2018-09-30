import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Media 1.0
//import com.jolla.camera 1.0
import QtMultimedia 5.4
import QtQuick.Layouts 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.Landscape

    Rectangle {
        parent: window
        anchors.fill: parent
        z: -1
        color: "black"
    }

    VideoOutput {
        id: captureView
        anchors.fill: parent
        source: camera
        rotation: 180
        orientation: camera.orientation
        onOrientationChanged: {
            console.log(orientation)
        }
    }

    Camera {
        id: camera

        imageProcessing.colorFilter: CameraImageProcessing.ColorFilterNormal

        viewfinder.resolution: Qt.size(1920, 1080)
        exposure {
            //exposureCompensation: -1.0
            exposureMode: Camera.ExposureAuto
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview  // Show the preview in an Image
            }
        }
    }

    Rectangle {
        id: btnCapture

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 50

        color: "red"

        height: parent.height / 6
        width: height
        radius: width/2

        border.color: "white"
        border.width: 20

        MouseArea {
            anchors.fill: parent
            onClicked: {
                camera.imageCapture.capture();
            }
        }
    }

    RowLayout {
        id: buttonLayout
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 20
        height: parent.height / 8
        spacing: 20
        Rectangle {
            color: '#999999'
            Layout.fillWidth: false
            Layout.minimumWidth: 300
            Layout.preferredWidth: 300
            Layout.maximumWidth: 300
            Layout.minimumHeight: 150
            Layout.preferredHeight: parent.height
            radius: 10
            Text {
                anchors.centerIn: parent
                text: "Effect"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (panelEffects.expanded) {
                        panelEffects.hide();
                    } else {
                        panelEffects.show();
                        panelExposure.hide();
                    }
                }
            }
        }

        Rectangle {
            color: '#999999'
            Layout.fillWidth: false
            Layout.minimumWidth: 300
            Layout.preferredWidth: 300
            Layout.maximumWidth: 300
            Layout.minimumHeight: 150
            Layout.preferredHeight: parent.height
            radius: 10
            Text {
                anchors.centerIn: parent
                text: "Exposure"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (panelExposure.expanded) {
                        panelExposure.hide();
                    } else {
                        panelExposure.show();
                        panelEffects.hide();
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
        }

    }

    DockedPanel {
        id: panelEffects

        width: parent.width / 2
        height: parent.height - buttonLayout.height - 40

        dock: Dock.Left
        clip:true

        SilicaListView {
            anchors.fill: parent
            anchors.margins: Theme.paddingMedium

            model: modelEffects
            clip: true

            delegate: ListItem {
                width: ListView.view.width
                height: Theme.itemSizeSmall

                Label {
                    text: name
                }
                onClicked: {
                    camera.imageProcessing.colorFilter = filter
                }

            }
        }
    }

    DockedPanel {
        id: panelExposure
        width: parent.width / 2
        height: parent.height - buttonLayout.height - 40

        dock: Dock.Left
        clip:true

        SilicaListView {
            anchors.fill: parent
            anchors.margins: Theme.paddingMedium

            model: modelExposure
            clip: true

            delegate: ListItem {
                width: ListView.view.width
                height: Theme.itemSizeSmall

                Label {
                    text: name
                }
                onClicked: {
                    camera.exposure.exposureMode = exposure;
                }

            }
        }
    }

    ListModel {
        id:modelEffects
        ListElement {
            name:"Normal"
            filter: 0
        }
        ListElement {
            name:"Sepia"
            filter: 4
        }
        ListElement {
            name:"Solarize"
            filter: 3
        }
        ListElement {
            name:"Aqua"
            filter: 8
        }
        ListElement {
            name:"Blackboard"
            filter: 7
        }
        ListElement {
            name:"Grayscale"
            filter: 1
        }
        ListElement {
            name:"Negative"
            filter: 2
        }
        ListElement {
            name:"Posterize"
            filter: 5
        }
        ListElement {
            name:"Whiteboard"
            filter: 6
        }

    }

    ListModel {
        id:modelExposure
        ListElement {
            name:  "Auto"
            exposure: 0
        }
        ListElement {
            name:  "Manual"
            exposure: 1
        }
        ListElement {
            name:  "Portrait"
            exposure: 2
        }
        ListElement {
            name:  "Night"
            exposure: 3
        }
        ListElement {
            name:  "Backlight"
            exposure: 4
        }
        ListElement {
            name:  "Spotlight"
            exposure: 5
        }
        ListElement {
            name:  "Sports"
            exposure: 6
        }
        ListElement {
            name:  "Snow"
            exposure: 7
        }
        ListElement {
            name:  "Beach"
            exposure: 8
        }
        ListElement {
            name:  "Large"
            exposure: 9
        }
        ListElement {
            name:  "Small"
            exposure: 10
        }
        ListElement {
            name:  "Action"
            exposure: 11
        }
        ListElement {
            name:  "Landscape"
            exposure: 12
        }
        ListElement {
            name:  "Night Portrait"
            exposure: 13
        }
        ListElement {
            name:  "Theatre"
            exposure: 14
        }
        ListElement {
            name:  "Sunset"
            exposure: 15
        }
        ListElement {
            name:  "Steady Photo"
            exposure: 16
        }
        ListElement {
            name:  "Fireworks"
            exposure: 17
        }
        ListElement {
            name:  "Party"
            exposure: 18
        }
        ListElement {
            name:  "Candlelight"
            exposure: 19
        }
        ListElement {
            name:  "Barcode"
            exposure: 20
        }
        ListElement {
            name:  "HDR"
            exposure: 1000
        }
    }

    /*
    GStreamerVideoOutput {
        id: videoOutput
        source: camera
        orientation: camera.orientation

        onOrientationChanged: {
            console.log(orientation)
        }

        z: -1
        anchors.fill: parent

        Behavior on y {
            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }
    }
    */
}
