#ifndef APPSETTING_H
#define APPSETTING_H

#include <QObject>
#include <QSettings>
#include <QString>
#include <QVariant>
#include<QDebug>


class AppSetting : public QObject
{
    Q_OBJECT
public:
    explicit AppSetting(QObject *parent = nullptr);
    Q_INVOKABLE void setVal(QString key, QVariant value);
    Q_INVOKABLE QVariant getVal(QString key,QVariant fallback_value = -1);

signals:


private:
    QSettings settings {"useless","musiq"};

};

#endif // APPSETTING_H
