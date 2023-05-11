import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    allowedOrientations: integralScreenOrientation

    Item {
        id: helpInfos
        property string text: if(orientation === Orientation.Portrait) {
                                  '<style>a:link { color: ' + Theme.primaryColor  + '; }</style>' +
                                  '<i>Mathematical operators :</i>' +
                                  '<br>+ - * / ** (power)' +
                                  '<br><br><i>Examples of functions :</i>' +
                                  '<br>sqrt, exp, log, sin, acos' +
                                  '<br><br><i>Examples of integrands :</i>' +
                                  '<br>1/(alpha*x+delta)**3, sin(kappa*x)**5,<br>exp(omega*t**2)*t' +
                                  '<br><br><i>Examples of variables (beta and<br>gamma can\'t be variables because<br>they are already used as functions) :</i>' +
                                  '<br>x, t, alpha, Omega' +
                                  '<br><br><i>Examples of limits :</i>' +
                                  '<br>0, -oo, pi/2, E, sqrt(1-y**2)' +
                                  '<br><br>Look at the SymPy site :</FONT>' +
                                  '<br><a href="http://sympy.org"><b>http://sympy.org</b></a>'
                             } else {
                                  '<style>a:link { color: ' + Theme.primaryColor  + '; }</style>' +
                                  '<i>Mathematical operators :</i>' +
                                  '<br>+ - * / ** (power)' +
                                  '<br><br><i>Examples of functions :</i>' +
                                  '<br>sqrt, exp, log, sin, acos' +
                                  '<br><br><i>Examples of integrands :</i>' +
                                  '<br>1/(alpha*x+delta)**3, sin(kappa*x)**5, exp(omega*t**2)*t' +
                                  '<br><br><i>Examples of variables (beta and gamma can\'t be variables <br>because they are already used as functions) :</i>' +
                                  '<br>x, t, alpha, Omega' +
                                  '<br><br><i>Examples of limits :</i>' +
                                  '<br>0, -oo, pi/2, E, sqrt(1-y**2)' +
                                  '<br><br>Look at the SymPy site :</FONT>' +
                                  '<br><a href="http://sympy.org"><b>http://sympy.org</b></a>'
                             }
    }

    SilicaFlickable {
        id: helpFlick
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: helpFlick.width

        VerticalScrollDecorator { flickable: helpFlick }

        Column {
            id: helpColumn
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            spacing: Theme.paddingLarge

            PageHeader {
                title: 'Help on Integral'
            }
            Label {
                id: content
                text: helpInfos.text
                textFormat: Text.RichText
                width: helpFlick.width
                horizontalAlignment: Text.AlignHCenter;
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingMedium
                }
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
        }
    }
}

