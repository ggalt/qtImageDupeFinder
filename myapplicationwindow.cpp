#include "myapplicationwindow.h"
#include <QStandardPaths>
#include <QDir>
#include <QSettings>
#include <QVariant>
#include <QQuickView>
#include <QDebug>
#include <QQuickItem>

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
    QIcon::setThemeName("gallery");

    QSettings settings;
    QString style = QQuickStyle::name();
    if (!style.isEmpty())
        settings.setValue("style", style);
    else
        QQuickStyle::setStyle(settings.value("style").toString());

    engine = new QQmlApplicationEngine();
    engine->rootContext()->setContextProperty("availableStyles", QQuickStyle::availableStyles());




//    appWindow = new QQuickView();
//    engine = appWindow->engine();
//    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
//    appWindow = engine.rootObjects().first();

//    QSettings settings;
    QString pictureHomeDir = QStandardPaths::standardLocations(
                QStandardPaths::PicturesLocation).first();

    pictureDirectory = settings.value("pictureDirectory", pictureHomeDir).toString();

    QDir d(pictureDirectory);
    qDebug() << "Picture Directory is:" << d.absolutePath();

    m_Images = new imageFiles(this);
    m_Images->setupImageProvider(engine);
    m_Images->readImageURLsFromDisk(d);

    m_ImageListModel = new ImageListModel(this);
    m_ImageListModel->setMyImageFiles(m_Images);

    engine->rootContext()->setContextProperty("myImages", m_Images);
    engine->rootContext()->setContextProperty("imageListModel", m_ImageListModel);
//    appWindow->setSource(QUrl(QLatin1String("qrc:/main.qml")));

//    QObject *item = appWindow->rootObject();

//    connect(item, SIGNAL(loadImageListModel()),
//            this, SLOT(LoadImageListModel()));

//    qDebug() << "Signal connected";
//    appWindow->setProperty("pictureHome", pictureHomeDir);
//    appWindow->show();


//    LoadImageListModel();
//    QVariant returnedValue;
//    QVariant msg = "Initialize";
//    QMetaObject::invokeMethod(appWindow, "setImageState",
//            Q_RETURN_ARG(QVariant, returnedValue),
//            Q_ARG(QVariant, msg));

    engine->load(QUrl("qrc:/main.qml"));
    if (engine->rootObjects().isEmpty())
        return;

}

void myApplicationWindow::LoadImageListModel(void)
{
    qDebug() << "called";
    QObject *scrollWindow = engine->rootContext()->findChild<QObject*>("mainScrollWindow");
    qDebug() << "ENGINE CONTEXT:" << engine->contextForObject(scrollWindow);
    QQmlContext *scrollContext = new QQmlContext(engine->rootContext());
    engine->setContextForObject(scrollWindow,scrollContext);
//    qDebug() << "ENGINE CONTEXT:" << engine->contextForObject(scrollWindow);
    qDebug() << "value of imageListModel" << scrollContext->contextProperty("imageListModel");
    scrollContext->setContextProperty("imageListModel", m_ImageListModel);
//    scrollWindow->setProperty("imageListModel", QVariant(m_ImageListModel));
}
