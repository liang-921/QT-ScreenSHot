import QtQuick 2.15
import QtQuick.Controls 1.4 as QQC
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.3
import qml.Controls 1.0

Item {

    id: content2

    property alias  paint1: paint

    //设置画笔颜色，画笔粗细
    property var painterColor:"red"

    //设置文字颜色，文字粗细
    property var textpaintColor:"black"

    function selectImage(){
        img.source = arguments[0]
        console.log("来源是：" + img.source)
    }

    //左边编辑栏
    Column {

        id: leftside

        height: parent.height

        Grid {

            id: grid

            padding: 15
            spacing: 15
            columns: 2

            //点击后为鼠标选项
            Rectangle {
                id: mouse

                width: 40
                height: 40
                radius: 3

                color: "#d3d3d3"
                Image {
                    anchors.centerIn: parent
                    width: 35
                    height: 35
                    source: "/icons/mouse.png"

                }

                MouseArea {
                    anchors.fill: mouse
                    onEntered: mouse.color = "#808080"
                    onExited: mouse.color = "#d3d3d3"
                    onClicked: {
                        paint.enabled=false
                    }
                }
            }

            //画笔
            Rectangle {
                id: painter

                width: 40
                height: 40
                radius: 3
                color: "#d3d3d3"

                Image {
                    anchors.centerIn: parent
                    width: 35
                    height: 35
                    source: "/icons/paint.png"
                }

                MouseArea {
                    anchors.fill: painter
                    onEntered: painter.color = "#808080"
                    onExited: painter.color = "#d3d3d3"
                    onClicked: {
                        paint.enabled=true;
                        paint.flag=5
                    }
                }
            }

            //文本
            Rectangle {
                id: text

                width: 40
                height: 40
                radius: 3
                color: "#d3d3d3"

                Image {
                    anchors.centerIn: parent
                    width: 35
                    height: 35
                    source: "/icons/draw-text.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onEntered: text.color = "#808080"
                    onExited: text.color = "#d3d3d3"
                    onClicked: {
                        paint.enabled=true
                        console.log("1")
                        paint.flag=1
                    }

                }
            }

            //马赛克
            /*Rectangle {
                id: mosaic

                width: 40
                height: 40
                radius: 3
                color: "#d3d3d3"

                Image {
                    anchors.centerIn: parent
                    width: 35
                    height: 35
                    source: "/icons/kdenlive-composite.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onEntered: mosaic.color = "#808080"
                    onExited: mosaic.color = "#d3d3d3"
                }
            }*/

            //画线
            Button {
                id: drawline
                iconSource: "/icons/color.png"
                width: 40
                height: 40
                menu: Menu {
//                    MenuItem {
                        //                    text: qsTr("Double line(D)")
//                        iconSource: "/icons/fill-color.png"
//                        iconName: "edit-copy"
//                    }
                    MenuItem {
                        text: qsTr("Line(L)")
                        iconSource: "/icons/mouse.png"
                        onTriggered:  {
                            paint.enabled=true;
                            paint.flag=4;
                        }
                    }
//                    MenuItem {
//                        text: qsTr("Arrow(A)")
//                        iconSource: "/icons/paint.png"
//                    }
                }
            }

            //画框
            Button {
                id: drawframe
                iconSource: "/icons/color.png"

                width: 40
                height: 40
                menu: Menu {
                    MenuItem {
                        action: Action {
                            text: qsTr("Rectangle")
                            iconSource: "/icons/rectangle.png"
                            onTriggered: {
                                drawframe.iconSource = iconSource
                                paint.enabled=true;
                                paint.flag=3;
                            }
                        }
                    }
                    MenuItem {
                        action: Action {
                            text: qsTr("circle")
                            iconSource: "/icons/draw-ellipse.png"
                            onTriggered: {
                                drawframe.iconSource = iconSource
                                paint.enabled=true
                                console.log("2")
                                paint.flag=2;
                            }
                        }
                    }
                }
            }
        }

        //画笔颜色选择
        Row {
            id: selectColor

            padding: 10

            Image {
                source: "/icons/color.png"
            }

            ColorDialog {
                id: colordialog
                onAccepted: {
                    rect.color = color
                    painterColor=color
                }
            }

            QQC.Button {
                id: colorbutton
                width: 80
                height: 30

                Rectangle {
                    id: rect
                    width: colorbutton.width - 20
                    height: colorbutton.height - 10
                    anchors.centerIn: colorbutton
                    color: painterColor
                }
                onClicked: {
                    colordialog.open()
                }
            }
        }

        //画笔宽度3
        Row {
            id: width

            padding: 10
            Image {
                width: 24
                height: 24
                source: "/icons/width.png"
            }
            QQC.SpinBox {
                id:paintSpinBox
                width: colorbutton.width
                height: 30
                minimumValue: 1
                maximumValue: 32
//                decimals : 3
                activeFocusOnPress: false
            }
        }

        //文字颜色选择
        Row {
            id: textcolor

            padding: 10

            Image {
                source: "/icons/textcolor.png"
            }

            ColorDialog {
                id: textcolordialog
                onAccepted: {
                    rect1.color = color
                    textpaintColor=color
                    console.log(textcolor)
                }
            }

            QQC.Button {
                id: textcolorbutton
                width: 80
                height: 30

                Rectangle {
                    id: rect1
                    width: colorbutton.width - 20
                    height: colorbutton.height - 10
                    anchors.centerIn: textcolorbutton
                    color: textpaintColor
                }
                onClicked: {
                    textcolordialog.open()
                }
            }
        }

        //字号大小
        Row {
            id: fontsize

            padding: 10
            Image {
                width: 24
                height: 24
                source: "/icons/fontsize.png"
            }
            QQC.SpinBox {
                id:fontSpinBox
                width: colorbutton.width
                height: colorbutton.height
                activeFocusOnPress : false
                stepSize: 10
                minimumValue: 10
                maximumValue: 320

            }
        }

        //图片填充方式
        /*Row {

            id: fillfunction
            padding: 10

            Image {
                width: 24
                height: 24
                source: "/icons/fill-color.png"
            }

            QQC.ComboBox {
                width: 80
                model: ["border and fill", "border and no fill", "no border and no fill"]
            }
        }*/

        //进行撤销的操作
        Row{
            id:undo

            padding: 20

            spacing: 50

            Rectangle{
                id:rdo
                width: 24
                height: 24
                color: "#d3d3d3"
                Image{
                    source: "/icons/revoke.png"
                    anchors.fill: parent
                    MouseArea{
                        anchors.fill: parent
                        onEntered: rdo.color="#808080"
                        onExited: rdo.color="#d3d3d3"
                        onClicked: {
                            paint.clear();
                        }
                    }
                }
            }

            Rectangle{
                id:udo
                width: 24
                height: 24
                color: "#d3d3d3"
                Image{
                    source: "/icons/undo.png"
                    anchors.fill: parent
                    MouseArea{
                        anchors.fill: parent
                        onEntered: udo.color="#808080"
                        onExited: udo.color="#d3d3d3"
                        onClicked: {
                            paint.undo();
                        }
                    }
                }
            }

        }
    }

    //右边显示的图像
    ScrollView {
        id: scrollview
        x: leftside.x + leftside.width + 20
        width: content2.width - leftside.width -20
        height: content2.height
        focus: true

       contentItem: Rectangle {
            id: rec
            width: img.width
            height: img.height
            Image {
                id: img
                cache: false
                fillMode: Image.PreserveAspectFit

                TextEdit{
                    id:textedit
                    x:paint.printPoint.x
                    y:paint.printPoint.y
                    text: paint.textEdit
                    font.pixelSize: paint.textFont
                    color: textpaintColor
                    onTextChanged: {
                        if(paint.flag==1){
                            textedit.focus=true
                            console.log("setTextEdit")
                            console.log(textedit.text)
                            paint.settextEdit(textedit.text)
                            textedit.visible=true;
                        }
                    }
                    //当字体颜色改变时
                    onColorChanged: {
                        if(paint.flag==1){
                            paint.setTextColor(color)
                        }
                    }
                    //当字体的大小改变时
                    onFontChanged: {
                        if(paint.flag==1){
                            paint.setTextFont(textedit.font.pixelSize)
                        }
                    }

                    visible:false
                    focus: true
                }

                //涂鸦类
                APaintedItem{
                    id:paint
                    anchors.fill: img
                    enabled: false
                    penColor: painterColor
                    penWidth: paintSpinBox.value
                    textColor:textpaintColor
                    textFont: fontSpinBox.value
                    onClearSignal: {
                        console.log("clearsignal")
                        textedit.text="";
//                        paint.settextEdit(textedit.text)
                    }
                    onUndoSignal: {
                        textedit.text="";
                    }

                }
            }

            Connections {
                target: fullCut
                onCallImgChanged: {
                    img.source = ""
                    img.source = "image://screen"
                    console.log(img.source)
                }
            }
        }
    }
}

