#include "myapplicationwindow.h"
#include <QStandardPaths>
#include <QDir>
#include <QSettings>
#include <QVariant>
#include <QQuickView>
#include <QDebug>

//#define DISPLAY_DURATION    10 * 1000
//#define TRANSITION_DURATION 4 * 1000
//#define BLUR_VALUE          99

myApplicationWindow::myApplicationWindow(QObject *parent) : QObject(parent)
{

}

myApplicationWindow::~myApplicationWindow()
{
    QSettings settings;
    settings.setValue("pictureDirectory", QVariant(pictureDirectory));
}

void myApplicationWindow::Init()
{
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    appWindow = engine.rootObjects().first();

    QSettings settings;
    QString pictureHomeDir = QStandardPaths::standardLocations(
                QStandardPaths::PicturesLocation).first();

    pictureDirectory = settings.value("pictureDirectory", pictureHomeDir).toString();

    QDir d(pictureDirectory);
    qDebug() << "Picture Directory is:" << d.absolutePath();

    m_Images = new imageFiles(this);
    m_Images->setupImageProvider(&engine);
    m_Images->readImageURLsFromDisk(d);

    m_ImageListModel = new ImageListModel(this);
    m_ImageListModel->setMyImageFiles(m_Images);

    engine.rootContext()->setContextProperty("myImages", m_Images);
    engine.rootContext()->setContextProperty("imageListModel", m_ImageListModel);
    appWindow->setProperty("pictureHome", pictureHomeDir);


//    QVariant returnedValue;
//    QVariant msg = "Initialize";
//    QMetaObject::invokeMethod(appWindow, "setImageState",
//            Q_RETURN_ARG(QVariant, returnedValue),
//            Q_ARG(QVariant, msg));
}

