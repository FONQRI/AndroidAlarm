#include "realtime.h"
RealTime::RealTime(QObject *parent) : QObject(parent)
{
    timer=new QTimer();
    connect (timer,SIGNAL(timeout()),this,SLOT(timerSlot()));
    timer->start (1000);
}

int RealTime::hour()
{
    return Hour;
}

void RealTime::setHour(int value)
{
    Hour=value;
    emit hourChanged ();
}

int RealTime::min()
{
    return Min;
}

void RealTime::setMin(int value)
{
    Min=value;
    emit minChanged ();
}

int RealTime::sec()
{
    return Sec;
}

void RealTime::setSec(int value)
{
    Sec=value;
    emit secChanged ();
}

void RealTime::timerSlot()
{
    setHour (QTime::currentTime ().hour ());
    setMin (QTime::currentTime ().minute ());
    setSec (QTime::currentTime ().second ());
}
