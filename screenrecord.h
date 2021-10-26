#ifndef SCREENRECORD_H
#define SCREENRECORD_H

#include <QWidget>
#include <QDialog>
#include <QPushButton>
#include <QProcess>
class QFile;

class ScreenRecord : public QWidget
{
    Q_OBJECT
public:
    ScreenRecord(QWidget *parent = Q_NULLPTR);
    ~ScreenRecord();

private:
    //利用命令行参数获取顶层窗口的wid，exec对命令汗参数进行解析
    void exec(const char* cmd);
    void sleep(unsigned int msec);

public slots:
    void start();
    void stop();

private:

    QProcess *p;
//    QPushButton *startButton;
//    QPushButton *pauseButton;
//    QPushButton *stopButton;

};
#endif // SCREENRECORD_H
