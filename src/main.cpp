#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "carry.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<Carry>("eta.recorder",1,0,"EtaRecorder");

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/ui/Test.qml")));

    return app.exec();
}
