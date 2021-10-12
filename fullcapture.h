#ifndef FULLCAPTURE_H
#define FULLCAPTURE_H

#include <QObject>
#include <QQuickWindow>
#include <qqml.h>
#include <QMainWindow>
#include "imageprovider.h"
#include "reccapture.h"


class FullCapture:public QMainWindow
{
    Q_OBJECT
public:
    explicit FullCapture(QMainWindow *parent=0);
    ImageProvider *imgProvider;
signals:
    void callImgChanged();
    void finishCapture();
public slots:
    void cutRecScreen(QPixmap pixmap);
    void cutContinueScreen();
    void startFullScreen();
    void startCaptureImage();
    void startContinueCapture();
private:
    QImage m_img;
    RecCapture *m_recCapture;
};

#endif // FULLCAPTURE_H
