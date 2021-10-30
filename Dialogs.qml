import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Item {
    property alias fileOpenDialog: fileOpen
    property alias fileSaveDialog: fileSave
    property alias aboutDialog: about

    function openFileDialog() { fileOpen.open(); }
    function saveFileDialog() { fileSave.open(); }
    function openAboutDialog()  {about.open()}

    FileDialog{
        id:fileOpen
        title:"Open A Picture"
        folder: shortcuts.pictures
        nameFilters: [ "Image files (*.png *.jpeg *.jpg)" ]
    }

    FileDialog{
        id:fileSave
        title:"Save A Picture"
        folder: shortcuts.pictures
        nameFilters: [ "Image files (*.png *.jpeg *.jpg)"]
    }

    Dialog{
        id:about
        width: 400
        height: 600
        title: qsTr("About")
        Label{
            anchors.centerIn: parent
            text:
                qsTr("优麒麟系统自带的截图软件（抓图）所实现的只是简单的
截图功能（全屏、矩形、活动窗口截图），基于此背景，
我们开发了一款可用于捕获和编辑桌面截图的应用程序。该软件在优化
优麒麟系统自带截屏功能的基础上，添加了活动窗口截屏，
不规则截屏，长截屏以及钉在桌面等功能，然后可以对所截取的图片进
行注释编辑，例如对图片进行涂鸦（涂鸦、添加文字、画各种图形等）、
裁剪，添加马赛克，滤镜等。除此之外，可对图像进行打印，发送到
其他应用程序，或者复制到粘贴版，快速保存，以及进行桌面的全屏
录制和区域录制等.")
        }

    }
}
