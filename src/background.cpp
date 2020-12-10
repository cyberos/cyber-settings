#include "background.h"

Background::Background(QObject *parent)
    : QObject(parent)
{
}

QList<QVariant> Background::backgrounds() {
    QList<QVariant> list;
    list.append(QVariant(QString("stub")));
    return list; // stub
}

QString Background::currentBackgroundPath() {
    return QObject::tr("stub"); // stub
}

void Background::setBackground(QString path) {
    return; // stub
}