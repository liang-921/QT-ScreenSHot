import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

ApplicationWindow{
    id: appRoot
    title: qsTr("麒麟截屏")
    width: 900; height: 480;
    minimumHeight: 400;
    minimumWidth: 600;
    visible: true

    Content1 {
        id: content1
        anchors.fill: parent
    }

    Content2{
        id:content2
        anchors.fill: parent
        visible: false
    }

    statusBar:StatusBar{
        //height: 40
        RowLayout{
            id:row
            width:parent.width

            RowLayout{
                id:row1
                Layout.alignment: Qt.AlignLeft
                Button{
                    Layout.preferredWidth: 100
                    text:qsTr("帮助(H)")
                    iconSource: "./icons/help.png"
                    menu:Menu{
                        MenuItem{
                            text: qsTr("这是什么？");
                            iconSource: "./icons/help.png"
                            shortcut: "Ctrl+H"
                        }
                    }
                }
                Button{
                    text: qsTr("打开本地图片")
                    iconSource: "./icons/open.png"
                    onClicked: {
                        dialogs1.openFileDialog()
                    }
                }
            }

            RowLayout{
                id:row2
                Layout.alignment: Qt.AlignRight

                Button{
                    id:btn
                    iconSource: "./icons/edit.png"
                    text: qsTr("注释")
                    onClicked: {
                        if(btn.text==="注释"){
                            btn_1.enabled=false
                            btn_2.enabled=false
                            btn_4.enabled=false
                            btn_3.enabled=true
                            content1.visible=false
                            content2.visible=true
                            btn.text="注释完成"

                        }else{
                            //将修改过后的涂鸦内容保存
                            content2.paint1.save("file:///tmp/1.jpg")
                            content1.tempDisplay()
                            btn.text="注释"
                            btn_1.enabled=true
                            btn_2.enabled=true
                            btn_3.enabled=true
                            btn_4.enabled=true
//                            content2.paint1.clear()
                            content1.visible=true
                            content2.visible=false
                        }
                    }
                }
                Button{
                    id:btn_1
                    text:qsTr("打印(P)")
                    iconSource: "./icons/print.png"
                    onClicked: {
                        share.startPrinter()
                    }
                }

                Button{
                    id:btn_2
                    iconSource: "./icons/send.png"
                    text: qsTr("导出")
                    menu:Menu{
                        Menu{
                            title:qsTr("分享")
                            //点击分享 图片会自动保存至剪贴板 然后分享
                            iconName:"document-save"
                            MenuItem{
                                text:qsTr("发送到QQ")
                                iconSource: "./icons/qq.png"
                                onTriggered: {
                                    capture.copytoClip()
                                    share.shareToQQ()
                                }
                            }
                            MenuItem{
                                text:qsTr("发送到微信")
                                iconSource: "./icons/wexin.png"
                                onTriggered: {
                                    capture.copytoClip()
                                    share.shareToWeChat()
                                }
                            }
                            MenuItem{
                                text:qsTr("通过电子邮件发送...")
                                iconSource: "./icons/mail.png"
                                onTriggered: {
                                    capture.copytoClip()
                                    share.sendMail()
                                }
                            }
                            MenuItem{
                                text:qsTr("发送到设备")
                                iconSource: "./icons/phone.png"
                            }
                        }
                        Menu{
                            title:qsTr("更多")
                            iconName:"./icons/recoder.png"
                            MenuItem{
                                text:qsTr("全屏录制")
                                iconSource: "./icons/recoder.png"
                                onTriggered: {
                                    console.log("开始录屏")
//                                    record.show()
                                }
                            }
                            MenuItem{
                                text: qsTr("区域录屏")
                                iconSource: "./icons/record.png"
                                onTriggered: {
                                    area_record.show()
                                }
                            }
                        }
                    }
                }
                Button{
                    id:btn_4
                    iconSource: "./icons/clip.png"
                    text: qsTr("复制到剪贴板")
                    onClicked: {
                        capture.copytoClip();
                    }
                }
                Button{
                    id:btn_3
                    text:qsTr("保存")
                    iconSource:"./icons/document-save.png"
                    menu:Menu{
                        id:menu_4
                        MenuItem{
                            text:qsTr("保存")
                            iconSource:"./icons/document-save.png"
                            shortcut: "Ctrl+S"
                            onTriggered:{
                                btn_3.text = text
                                btn_3.iconName = iconName
//                                dialogs1.fileSaveDialog.selectExisting=false;
//                                dialogs1.saveFileDialog()
//                                content2.paint1.save("")
                            }
                        }
                        MenuItem{
                            text:qsTr("另存为")
                            iconSource:"./icons/document-save-as.png"
                            shortcut: "Ctrl+Shift+S"
                            onTriggered:{
                                dialogs1.fileSaveDialog.selectExisting=false;
                                dialogs1.saveFileDialog()
                            }
                        }
                    }
                }
            }
        }
    }

    //打开 对话框导入图片 另存为对话框 保存图片
    Dialogs{
        id:dialogs1
        fileOpenDialog.onAccepted:{
            content1.selectImage(fileOpenDialog.fileUrl)
            content2.selectImage(fileOpenDialog.fileUrl)
        }
        fileSaveDialog.onAccepted:{
            content2.paint1.save(fileSaveDialog.fileUrl)
        }

    }
}
