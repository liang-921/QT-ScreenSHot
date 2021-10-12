#include "fullcapture.h"
#include <QGuiApplication>
#include <QImage>
#include <QWindow>
#include <QApplication>
#include <QScreen>
#include <QDebug>

FullCapture::FullCapture(QMainWindow *parent)
    :QMainWindow(parent)
{
    imgProvider=new ImageProvider();
}

void FullCapture::startFullScreen()
{
    QPixmap pixmap;
    QScreen *screen=QApplication::primaryScreen();

    this->setCursor(Qt::ArrowCursor);  //显示正常鼠标

    pixmap=screen->grabWindow(0);

    imgProvider->img=pixmap.toImage();

    QImage img=pixmap.toImage();

    emit callImgChanged();

    img.save("/root/1.jpg");
}

void FullCapture::cutRecScreen(QPixmap pixmap)
{

    imgProvider->img=pixmap.toImage();

    QImage img=pixmap.toImage();

    img.save("/root/1.jpg");

    //发送信号 将矩形截取的图片在姐妹显示
    emit callImgChanged();
    //发送信号 告知qml矩形截屏结束
    emit finishCapture();
}

void FullCapture::cutContinueScreen()
{

    //发送信号 告知qml连续截屏结束
    emit finishCapture();
}

void FullCapture::startCaptureImage()
{
    m_recCapture = new RecCapture();
    connect(m_recCapture,SIGNAL(signalCompleteCapture(QPixmap)),
            this,SLOT(cutRecScreen(QPixmap)));
    m_recCapture->show();
}

//进行连续截图
void FullCapture::startContinueCapture()
{
    m_recCapture=new RecCapture;
    connect(m_recCapture,SIGNAL(signalCompleteContinue()),
            this,SLOT(cutContinueScreen()));
    m_recCapture->show();

}

