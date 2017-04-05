#ifndef REALTIME_H
#define REALTIME_H

#include <QObject>
#include <QTimer>
#include <QTime>

class RealTime : public QObject
{
    Q_PROPERTY(int hour READ hour WRITE setHour NOTIFY hourChanged)
    Q_PROPERTY(int min READ min WRITE setMin NOTIFY minChanged)
    Q_PROPERTY(int sec READ sec WRITE setSec NOTIFY secChanged)
    Q_OBJECT
public:
    explicit RealTime(QObject *parent = 0);

private:
    QTimer *timer;


    int Hour = QTime::currentTime ().hour ();
    int Min = QTime::currentTime ().minute ();
    int Sec = QTime::currentTime ().second ();
signals:
    void hourChanged();
    void minChanged();
    void secChanged();
public slots:
    int hour();
    void setHour(int value);
    int min();
    void setMin(int value);
    int sec();
    void setSec(int value);

    //timer slot for updating time every 1 second
    void timerSlot();
};

#endif // REALTIME_H
