#include "f_timer.h"
#include "f_converter.h"
#include <QDebug>
F_Timer::F_Timer(QObject *parent) : QObject(parent)
{
    timer = new QTimer();
    connect(timer,SIGNAL(timeout()),this,SLOT(TimerSlot()));
    setQmlSec (1);
    setSecond(0);
}

void F_Timer::start(int hour, int min, int sec)
{
    setSecond(F_converter::TimeToSecFormat (hour,min,sec));
    setQmlSec (F_converter::TimeToSecFormat (hour,min,sec));
    setShowTime (F_converter::SecToTimeFormat (second()));
    setQmlSec (second());
    timer->start (2);
}

void F_Timer::stop()
{
    timer->stop ();
}

int F_Timer::second()
{
    return seconds;
}

void F_Timer::setSecond(int value)
{
    seconds=value;
    emit secondChanged ();
    setShowTime (F_converter::SecToTimeFormat (second()/1000));
}

void F_Timer::setQmlSec(int value)
{
    if(value == 0)
        qmlSeconds=1;
    else
    {
        qmlSeconds=value;
        emit qmlSecChanged ();
    }
}

int F_Timer::qmlSec()
{
    return qmlSeconds;
}

void F_Timer::setShowTime(QString value)
{
    ShowTime = value;
    emit showTimeChanged ();
}

QString F_Timer::showTime()
{
    return ShowTime;
}

bool F_Timer::done()
{
    return timerDone;
}

void F_Timer::setDone(bool value)
{
    timerDone =value;
    emit doneChanged ();
}

void F_Timer::setRunning(bool value)
{
    Running=value;
    emit runningChanged ();
}

bool F_Timer::running()
{
    return Running;
}

void F_Timer::TimerSlot()
{
    if(second()>0)
    {
        setSecond (second() - 2);
    }else
    {
        setRunning (false);
        setDone (true);
        timer->stop ();
        qDebug()<<"down";
    }
}
