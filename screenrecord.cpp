#include "screenrecord.h"
#include <QApplication>
#include <QProcess>
#include <QTimer>
#include <QDebug>
#include <QDateTime>
#include <QFile>
//#include <QVBoxLayout>
//#include <QLayout>

ScreenRecord::ScreenRecord(QWidget *parent)
    : QWidget(parent)
{
//    startButton = new QPushButton(tr("&start"));
//    startButton->setDefault(true);
//    startButton->setEnabled(true);

//    stopButton = new QPushButton(tr("&stop"));
//    stopButton->setDefault(true);
//    stopButton->setEnabled(true);

//    QVBoxLayout *rightLayout = new QVBoxLayout;
//    rightLayout->addWidget(startButton);
//    rightLayout->addWidget(stopButton);
//    rightLayout->addStretch();

//    QHBoxLayout *mainLayout = new QHBoxLayout;
//    mainLayout->addLayout(rightLayout);
//    setLayout(mainLayout);
//    setFixedHeight(sizeHint().height());

//    connect(startButton,SIGNAL(clicked()),
//            this,SLOT(start()));
//    connect(stopButton,SIGNAL(clicked()),
//            this,SLOT(stop()));
}

ScreenRecord::~ScreenRecord()
{
        delete p;
}

void ScreenRecord::start()
{
    QString program = "ffmpeg";
    QString filename= "/tmp/"+QDateTime::currentDateTime().toString("yyyy-MM-dd-hh:mm:ss") + ".mkv";

    QStringList arguments;
    arguments<<"-video_size"<<"1920x1080"<<"-framerate"<<"30"<<"-f"<<"x11grab"
            <<"-i"<<":0.0"<<"-f"<<"pulse"<<"-ac"<<"2"<<"-i"<<"default"<<filename;

    p->startDetached(program,arguments);

}

void ScreenRecord::exec(const char *cmd)
{
    FILE* pipe = popen(cmd, "r");
    //if (!pipe) return "ERROR";
    char buffer[128];
    std::string result = "";
    while(!feof(pipe)) {
        if(fgets(buffer, 128, pipe) != NULL)
            result += buffer;
    }
    pclose(pipe);
    //    return result;
}

void ScreenRecord::sleep(unsigned int msec)
{
    QTime dieTime = QTime::currentTime().addMSecs(msec);
    while( QTime::currentTime() < dieTime )
        QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
}

void ScreenRecord::stop()
{

    sleep(8000);
    //关闭录制
    qDebug()<<"关闭录制";
//    this->close();
    exec("kill -9 $(ps -ef|grep ffmpeg|grep -v grep|awk '{print $2}')");

//    exec("ps aux | grep ffmpeg | grep -v grep | awk '{print $2}' | sudo xargs kill -9");
}
