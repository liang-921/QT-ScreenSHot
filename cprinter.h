#pragma once
#include <QtPrintSupport/QPrinter>
#include <QPixmap>
#include <QPainter>
#include <QtPrintSupport/QPrintPreviewDialog>
#include <QtPrintSupport/QPrintDialog>
#include <QtPrintSupport/QPageSetupDialog>

class CPrinter : public QObject
{
    Q_OBJECT
public:
    CPrinter();
    ~CPrinter();

public://打印窗口
    /*
     *  @brief:打印窗口
     */
   Q_INVOKABLE void startPrinter();



private slots:

//    void Slot_Preview(QPrinter* printer);

private:
    QPixmap m_Pixmap;		//界面控件内像素
    QPrinter *m_pPrinter;	//打印机
};


