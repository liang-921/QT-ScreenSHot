#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>

#include "capture.h"
#include "painteditem.h"
#include "share.h"
//#include "recorddialog.h"
#include "area_record.h"

int main(int argc, char *argv[]){

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Capture *capture=new Capture();
    engine.rootContext()->setContextProperty("capture",capture);
    engine.addImageProvider(QLatin1String("screen"),capture->imgProvider);

    Share *share = new Share();
    engine.rootContext()->setContextProperty("share",share);

//    RecordDialog *record = new RecordDialog();
//    engine.rootContext()->setContextProperty("record",record);

    Area_Record *area_record = new Area_Record();
    engine.rootContext()->setContextProperty("area_record",area_record);

    //将涂鸦这个类注册到qml中
    qmlRegisterType<PaintedItem>("qml.Controls", 1, 0, "APaintedItem");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
