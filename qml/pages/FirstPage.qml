/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import io.thp.pyotherside 1.2

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: container
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: page.width

        VerticalScrollDecorator { flickable: container }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: "Help"
                onClicked: pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
            }
/*            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
*/
        }

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id : integral_Column
            width: page.width
            spacing: Theme.paddingSmall

            function calculateResultIntegral() {
                result_TextArea.text = '<FONT COLOR="LightGreen">Calculating integral...</FONT>'
                py.call('integral.calculate_Integral', [integrand_TextField.text,diff1_TextField.text,diff2_TextField.text,diff3_TextField.text], function(result) {
                    result_TextArea.text = result;
                    result_TextArea.selectAll()
                    result_TextArea.copy()
                    result_TextArea.deselect()
                })
            }

            PageHeader {
                title: qsTr("Integral")
            }
            TextField {
                id: integrand_TextField
                width: parent.width
                label: qsTr("Integrand")
                placeholderText: "sin(x)**10"
                text: "sin(x)**10"
                focus: true
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: diff1_TextField.focus = true
            }
            Grid {
                id: diffs_Item
                anchors {left: parent.left; right: parent.right}
                width: parent.width*0.80
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                rows: 1
                columns: 7
                Label {
                    id: diff1_Label
                    text: "d"
                }
                TextField {
                   id: diff1_TextField
                   width: parent.width*0.20
                   text: "x"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: diff2_TextField.focus = true
                }
                Label {
                    id: diff2_Label
                    text: "d"
                }
                TextField {
                   id: diff2_TextField
                   width: parent.width*0.20
                   text: ""
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: diff3_TextField.focus = true
                }
                Label {
                    id: diff3_Label
                    text: "d"
                }
                TextField {
                   id: diff3_TextField
                   width: parent.width*0.20
                   text: ""
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                   EnterKey.onClicked: integral_Column.calculateResultIntegral()
                }
                Button {
                    id: calculate_Button
                    width: parent.width*0.30
                    text: qsTr("Calculate")
                    onClicked: integral_Column.calculateResultIntegral()
                }
            }
            Separator {
                id : integral_Separator
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width*0.9
                color: Theme.primaryColor
            }
            FontLoader { id: dejavusansmono; source: "file:DejaVuSansMono.ttf" }
            TextArea {
                id: result_TextArea
                height: Math.max(page.width, 600, implicitHeight)
                width: parent.width
                readOnly: true
                font.family: dejavusansmono.name
                font.pixelSize: Theme.fontSizeExtraSmall
                placeholderText: "Integral calculation result"
                text : '<FONT COLOR="LightGreen">Loading Python and SymPy, it takes some seconds...</FONT>'
                Component.onCompleted: {
                    _editor.textFormat = Text.RichText;
                }
            }

            Python {
                id: py

                Component.onCompleted: {
                    // Add the Python library directory to the import path
                    var pythonpath = Qt.resolvedUrl('.').substr('file://'.length);
                    addImportPath(pythonpath);
                    console.log(pythonpath);

                    // Asynchronous module importing
                    importModule('integral', function() {
                        console.log('Python version: ' + evaluate('integral.versionPython'));
                        result_TextArea.text='<FONT COLOR="LightGreen">Using Python version ' + evaluate('integral.versionPython') + '.</FONT>'
                        console.log('SymPy version ' + evaluate('integral.versionSymPy') + evaluate('(" loaded in %f seconds." % integral.loadingtimeSymPy)'));
                        result_TextArea.text+='<FONT COLOR="LightGreen">SymPy version ' + evaluate('integral.versionSymPy') + evaluate('(" loaded in %f seconds." % integral.loadingtimeSymPy)') + '</FONT><br>'
                    });
                }

                onError: {
                    // when an exception is raised, this error handler will be called
                    console.log('python error: ' + traceback);
                }

                onReceived: {
                    // asychronous messages from Python arrive here
                    // in Python, this can be accomplished via pyotherside.send()
                    console.log('got message from python: ' + data);
                }
            }
        }
    }
}
