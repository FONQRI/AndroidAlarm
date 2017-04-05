#ifndef F_CONVERTER_H
#define F_CONVERTER_H

#include <QObject>

class F_converter : public QObject
{
    Q_OBJECT
public:
    explicit F_converter(QObject *parent = 0);
    static QString SecToTimeFormat(int second);
    static int TimeToSecFormat(int hour,int min , int sec);
};

#endif // F_CONVERTER_H
