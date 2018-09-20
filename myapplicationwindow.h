#ifndef MYAPPLICATIONWINDOW_H
#define MYAPPLICATIONWINDOW_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>
#include <QString>
#include <QVariant>

#include "imagefiles.h"
#include "imagelistmodel.h"

class myApplicationWindow : public QObject
{
    Q_OBJECT
public:
    explicit myApplicationWindow(QObject *parent = nullptr);
    ~myApplicationWindow(void);

    void Init(void);

signals:

public slots:
    void LoadImageListModel(void);

private:
//    QQmlApplicationEngine engine;
//    QObject* appWindow;
    QQmlEngine *engine;
    QQuickView *appWindow;

    QString pictureDirectory;
//    int blurValue;
//    int displayDuration;
//    int transitionDuration;

    imageFiles *m_Images;
    ImageListModel *m_ImageListModel;
};

#endif // MYAPPLICATIONWINDOW_H
