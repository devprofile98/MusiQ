#include "appsetting.h"

AppSetting::AppSetting(QObject *parent) : QObject(parent)
{

}

void AppSetting::setVal(QString key, QVariant value)
{
    qDebug()<<"set  value is "<<key<<" "<<value;
    settings.setValue(key,value);
    settings.sync();
}

QVariant AppSetting::getVal(QString key, QVariant fallback_value)
{
    qDebug()<<"get  value is "<<settings.value(key,fallback_value);
    return settings.value(key,fallback_value);
}
