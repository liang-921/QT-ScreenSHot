import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {
    id: content

    property bool isCapture: false

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    function selectImage(){
        img.source = arguments[0]
        console.log("来源是：" + img.source)
    }

    Image {
        id: img
        width: parent.width - rec2.width
        height: parent.height
        anchors.left: parent.left
        anchors.right: rec2.left
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        cache: true
        fillMode: Image.PreserveAspectFit
    }

    Connections {
        target: fullCut
        onCallImgChanged: {
            img.source = ""
            img.source = "image://screen"
            console.log(img.source)
        }
    }

    Rectangle {
        id: rec2
        width: 250
        height: parent.height
        anchors.right: parent.right
        ColumnLayout {
            id: column1
            x: 0
            y: 0
            width: 250
            height: 287
            implicitHeight: 150
            RowLayout {
                id: row
                Layout.margins: 5
                Text {
                    text: qsTr("截取方式")
                    font.pixelSize: 16
                }
            }
            RowLayout {
                id: row1
                width: 187
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Label {
                    id: lab_1
                    text: qsTr("区域：")
                }
                ComboBox {
                    id: cbb
                    model: ListModel {
                        id: model
                        ListElement {
                            text: "全屏"
                        }
                        ListElement {
                            text: "矩形区域"
                        }
                        ListElement {
                            text: "活动窗口"
                        }
                        ListElement{
                            text:"连续截图"
                        }
                        ListElement{
                            text:"钉在桌面"
                        }
                    }
                }
            }
            RowLayout {
                id: row2
                Layout.fillHeight: false
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Label {
                    id: lab_2
                    text: qsTr("延迟： ")
                }
                SpinBox {
                    id: spinBox
                    minimumValue: 0
                    suffix: "秒"
                    decimals: 0
                    stepSize: 1
                }
                CheckBox {
                    id: checkBox
                    text: "点击时"
                    onCheckedChanged: {
                        if (checkBox.checked) {
                            spinBox.enabled = false
                        } else {
                            spinBox.enabled = true
                        }
                    }
                }
            }
            RowLayout {
                id: row3
                Layout.margins: 5
                Text {
                    text: qsTr("选项")
                    font.pixelSize: 16
                }
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                CheckBox {
                    text: "包含鼠标指针"
                }
                CheckBox {
                    id:check_2
                    text: "隐藏当前窗口"
                }
                CheckBox {
                    text: "手动保存或复制后退出"
                }
            }
        }
        Button {
            x: 76
            y: 425
            width: 100
            height: 40
            text: qsTr("截取屏幕")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            iconName: "applications-system"
            onClicked: {
                countDown.start()
            }
        }
    }

    Timer{
        id:timer
    }

    Timer {
        id: countDown
        interval: 1000
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            console.log(spinBox.value)
            spinBox.value -= 1
            if(spinBox.value < 1 && cbb.currentText === "全屏"){
                countDown.stop()
                if(check_2.checked == true){
                    appRoot.hide()
                    delay(200,function(){
                        fullCut.startFullScreen()
                    })
                    delay(400,function(){
                        appRoot.show()
                    })
                }else{
                    fullCut.startFullScreen()
                }

            } else if (spinBox.value < 1 && cbb.currentText === "矩形区域") {
                countDown.stop()
                if(check_2.checked == true){
                    appRoot.hide()
                    delay(500,function(){
                        fullCut.startCaptureImage()
                    })
                }else{
                    fullCut.startCaptureImage()
                }
            } else if (spinBox.value < 1 && cbb.currentText === "连续截图") {
                countDown.stop()
                if(check_2.checked == true){
                    appRoot.hide()
                    delay(500,function(){
                        fullCut.startContinueCapture()
                    })
                }else{
                    fullCut.startContinueCapture()
                }
            } else if(spinBox.value < 1 && cbb.currentText === "钉在桌面"){
                countDown.stop()
                if(check_2.checked == true){
                    appRoot.hide()
                    delay(500,function(){
                        fullCut.startCaptureImage()
                    })
                }else{
                    fullCut.startCaptureImage()
                }
            }
        }
    }

    Connections {
        target: fullCut
        onFinishCapture:{
            appRoot.showNormal()
            console.log("显示隐藏当前窗口后 重新显示approot")
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

