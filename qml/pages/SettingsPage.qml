import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Page {
    id: settingsPage

    allowedOrientations: integralScreenOrientation

    SilicaFlickable {
        id: setttingsFlick
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: setttingsFlick.width

        VerticalScrollDecorator { flickable: setttingsFlick }

        Column {
            id: settingsColumn
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            spacing: Theme.paddingSmall

            PageHeader {
                title: qsTr('Integral Settings')
            }
            ComboBox {
                id: orientation_ComboBox
                label: qsTr("Screen orientation")
                currentIndex: orientation_index
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Portrait")
                        onClicked: {
                            integralScreenOrientation = Orientation.Portrait
                            orientation_index = 0
                        }
                    }
                    MenuItem {
                        text: qsTr("Landscape")
                        onClicked: {
                            integralScreenOrientation = Orientation.Landscape
                            orientation_index = 1
                        }
                    }
                    MenuItem {
                        text: qsTr("Automatic")
                        onClicked: {
                            integralScreenOrientation = Orientation.Portrait | Orientation.Landscape
                            orientation_index = 2
                        }
                    }
                }
            }
            TextSwitch {
                id: showIntegral_TextSwitch
                text: qsTr("Show not calculated integral")
                description: qsTr("before integral result")
                checked: showIntegral
                onCheckedChanged : { showIntegral = checked }
            }
            TextSwitch {
                id: showTime_TextSwitch
                text: qsTr("Show calculation time")
                description: qsTr("before integral result")
                checked: showTime
                onCheckedChanged : { showTime = checked }
            }
            TextField {
                id: numDig_TextField
                width: parent.width
                label: qsTr("Number of digits for numerical integration")
                placeholderText: numDigText
                text: numDigText
                validator: IntValidator{bottom: 1; top: 1000000}
                inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                onTextChanged: { numDigText = text }
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: { numDigText = text; simplifyResult_ComboBox.focus = true }
            }
            ComboBox {
                id: numerIntegralType_ComboBox
                label: qsTr("Numerical integration method")
                currentIndex: numerIntegralType_index
                menu: ContextMenu {
                    MenuItem { id: numerApproxDefIntegral_MenuItem ; text: qsTr("Numerical approximation of definite integral") }
                    MenuItem { text: qsTr("Optimized for infinities") }
                    MenuItem { text: qsTr("Optimized for smooth integrands") }
                    onActivated: {
                        numerIntegralType_index = index
                    }
                }
            }
            ComboBox {
                id: simplifyResult_ComboBox
                label: qsTr("Simplification method for non-numerical integration")
                currentIndex: simplifyResult_index
                menu: ContextMenu {
                    MenuItem { text: qsTr("None") }
                    MenuItem { text: qsTr("Expand terms") }
                    MenuItem { text: qsTr("Simplify terms") }
                    MenuItem { text: qsTr("Expand all") }
                    MenuItem { text: qsTr("Simplify all") }
                    onActivated: {
                        simplifyResult_index = index
                    }
                }
            }
            ComboBox {
                id: outputTypeResult_ComboBox
                label: qsTr("Output type for integral result")
                currentIndex: outputTypeResult_index
                menu: ContextMenu {
                    MenuItem { text: qsTr("Simple") }
                    MenuItem { text: qsTr("Bidimensional") }
                    MenuItem { text: qsTr("LaTex") }
                    MenuItem { text: qsTr("C") }
                    MenuItem { text: qsTr("Fortran") }
                    MenuItem { text: qsTr("Javascript") }
                    MenuItem { text: qsTr("Python/SymPy") }
                    onActivated: {
                        outputTypeResult_index = index
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "inLandscape"
            when: orientation === Orientation.Landscape
            PropertyChanges {
                target: showIntegral_TextSwitch
                text: qsTr("Show not calculated integral before integral result")
                description: ''
            }
            PropertyChanges {
                target: showTime_TextSwitch
                text: qsTr("Show calculation time before integral result")
                description: ''
            }
            PropertyChanges {
                target: numDig_TextField
                label: qsTr("Number of digits for numerical integration")
            }
            PropertyChanges {
                target: numerApproxDefIntegral_MenuItem
                text: qsTr("Numerical approximation of definite integral")
            }
            PropertyChanges {
                target: simplifyResult_ComboBox
                label: qsTr("Simplification method for non-numerical integral result")
            }
        },
        State {
            name: "inPortrait"
            when: orientation === Orientation.Portrait
            PropertyChanges {
                target: showIntegral_TextSwitch
                text: qsTr("Show not calculated integral")
                description: qsTr("before integral result")
            }
            PropertyChanges {
                target: showTime_TextSwitch
                text: qsTr("Show calculation time")
                description: qsTr("before integral result")
            }
            PropertyChanges {
                target: numDig_TextField
                label: qsTr("# of digits for numerical integration")
            }
            PropertyChanges {
                target: numerApproxDefIntegral_MenuItem
                text: qsTr("Numer. approx. of definite integral")
            }
            PropertyChanges {
                target: simplifyResult_ComboBox
                label: qsTr("Simplification")
                description: qsTr("method for non-numerical integral result")
            }
        }
    ]
}
