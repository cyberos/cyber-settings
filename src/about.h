#ifndef ABOUT_H
#define ABOUT_H

#include <QObject>
#include <QString>
#include <QSysInfo>
#include <qqml.h>
#include <version.h>

class About : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString osName READ osName NOTIFY stub)
    Q_PROPERTY(QString osVersion READ osVersion NOTIFY stub)
    Q_PROPERTY(QString hostname READ hostname NOTIFY stub)
    Q_PROPERTY(QString settingsVersion READ settingsVersion NOTIFY stub)
    QML_ELEMENT

public:
    explicit About(QObject *parent = nullptr);

    QString osName();
    QString osVersion();
    QString hostname();
    QString settingsVersion();

// Only here so that QML doesn't whine about non-NOTIFYable properties.
signals:
    void stub();
};

#endif // ABOUT_H
