#include <QGuiApplication>
//#include <QQmlApplicationEngine>
#include "myapplicationwindow.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setOrganizationName("GeorgeGalt");
    QCoreApplication::setOrganizationDomain("georgegalt.com");
    QCoreApplication::setApplicationName("qtImageDupeFinder");

    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty())
//        return -1;

    myApplicationWindow win;
    win.Init();

    return app.exec();
}
