#include <QGuiApplication>
//#include <QQmlApplicationEngine>
#include "myapplicationwindow.h"
#include "imagefiles.h"
#include "imageinfo.h"

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

    qmlRegisterType<imageFiles>("com.georgegalt.qtImageDueFinder",1,0,"imageFiles");
    myApplicationWindow win;
    win.Init();

    return app.exec();
}
