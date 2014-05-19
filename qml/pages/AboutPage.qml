import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0


Page {
    id: page

     Item {
        id: aboutInfos
        property string version:'0.6'
        property string text:'<style>a:link { color: ' + Theme.primaryColor  + '; }</style>' +
                             '<p align="justify">Integral calculates mathematical indefinite integrals symbolically (in future versions, also definite and numerical integrals).</p>' +
                             '<p align="justify">This version of Integral is written using Python, SymPy, PyOtherSide, Qt5, Qt Quick 2 (Silica Components).</p>' +
                             '<center><br>© 2011-2014 by Roberto Colistete Jr.</center>' +
                             '<center>Free & Open Source :</center>' +
                             '<center><a href="http://www.gnu.org/licenses/lgpl-3.0.html"><b>License LGPLv3</b></a></center>' +
                             '<center><br>For more information, see the web site :</center>' +
                             '<center><a href="http://www.RobertoColistete.net/Integral"><b>www.RobertoColistete.net/Integral</b></a></center>' +
                             '<center><br><FONT COLOR="violet">In l&hearts;ving memory of my wife Lorena</FONT></center>'
    }

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: aboutFlick.width

        Column {
            id: aboutColumn
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            spacing: Theme.paddingMedium

            PageHeader {
                title: 'About Integral'
            }
            Label {
                id:title
                text: 'Integral  v' + aboutInfos.version
                font.pixelSize: Theme.fontSizeLarge
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                id: slogan
                text: 'for Sailfish OS'
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item {
                width: 1
                height: Theme.paddingMedium
            }
            Label {
                id: content
                text: aboutInfos.text
                width: aboutFlick.width
                wrapMode: TextEdit.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.RichText
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
