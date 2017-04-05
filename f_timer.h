#ifndef F_TIMER_H
#define F_TIMER_H

#include <QObject>
#include <QTimer>
class F_Timer : public QObject
{
    Q_PROPERTY(bool done READ done WRITE setDone NOTIFY doneChanged)
    Q_PROPERTY(bool  running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(int second READ second WRITE setSecond NOTIFY secondChanged)
    Q_PROPERTY(int qmlSec READ qmlSec WRITE setQmlSec NOTIFY qmlSecChanged)
    Q_PROPERTY(QString showTime READ showTime WRITE setShowTime NOTIFY showTimeChanged)


    Q_OBJECT
public:
    explicit F_Timer(QObject *parent = 0);


    //start function for starting timer
private:
    bool timerDone=false;
    bool Running;
    int seconds=0;
    int qmlSeconds=0;

    QString ShowTime;
    QTimer *timer;
signals:
    void doneChanged();
    void runningChanged();
    void secondChanged();
    void qmlSecChanged();
    void showTimeChanged();
public slots:
    bool done();
    void setDone(bool value);

    //for time string entry
  void setRunning(bool value);
  bool running();

    //timer slot
    void TimerSlot();
    void start(int hour,int min,int sec);
    void stop();

//qml timer var
    int second();
void setSecond(int value);

//qml intialize var
void setQmlSec(int value);
int qmlSec();


//qml show time string
void setShowTime(QString value);
QString showTime();
};

#endif // F_TIMER_H
