#include "cprinter.h"

CPrinter::CPrinter() :m_pPrinter(NULL)
{
    if(m_pPrinter == NULL)
        m_pPrinter = new QPrinter;
}

CPrinter::~CPrinter()
{
    if (m_pPrinter != nullptr)
        delete m_pPrinter;
    m_pPrinter = NULL;
}

void CPrinter::startPrinter()
{
    QPrinter printer(QPrinter::ScreenResolution);
    QPrintDialog printDialog(&printer);
    if (printDialog.exec() == QDialog::Accepted) {
        QPainter painterPixmap;
        painterPixmap.begin(&printer);
//        painterPixmap.drawPixmap(0, 0, pixmap);
        painterPixmap.end();
    }
}


