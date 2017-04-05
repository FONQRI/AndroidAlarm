#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <realtime.h>
#include <QDebug>
#include "f_timer.h"



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;
    RealTime time;
    F_Timer timer;
    QQmlContext *ctx=engine.rootContext ();
    ctx->setContextProperty ("myTimer" , &timer);

    ctx->setContextProperty ("myTime" , &time);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}

