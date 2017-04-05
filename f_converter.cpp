#include "f_converter.h"
#include <QString>
F_converter::F_converter(QObject *parent) : QObject(parent)
{

}

QString F_converter::SecToTimeFormat(int second)
{
    if ( second > 30 * 86400)
        return QString("nvalid");
    int hour=0;//for saving hour(s)
    int min=0;//for saving minute(s)
    int day = 0;//for saving day number(s)

    //calculating day number(s)
    while(second >=86400 )
    {
        second -=86400;
        day++;
    }
    while (second>= 3600)
    {
        second -= 3600;
        hour++;
    }

    while(second >= 60)
    {
        second -=60;
        min++;
    }

   /* in here hour is our hour and min is our  minute numbers and second is our second number
    * here we mix thme in a QString rto return
    * if day in not null we should return a QString with day
    */
    return QString("%1:%2:%3").arg (QString::number (hour),QString::number (min),QString::number (second));
}

int F_converter::TimeToSecFormat(int hour, int min, int sec)
{
   return( hour*3600 + min*60 + sec)*1000;
}
