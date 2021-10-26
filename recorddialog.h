#ifndef RECORDDIALOG_H
#define RECORDDIALOG_H

#include <QDialog>
#include <QProcess>

namespace Ui {
class RecordDialog;
}

class RecordDialog : public QDialog
{
    Q_OBJECT

public:
    explicit RecordDialog(QWidget *parent = nullptr);
    ~RecordDialog();

private:
    //exec对命令行参数进行解析
    void exec(const char* cmd);
    void sleep(unsigned int msec);

public slots:
    void start();
    void stop();

private:
    QProcess *p;
    Ui::RecordDialog *ui;
};

#endif // RECORDDIALOG_H
