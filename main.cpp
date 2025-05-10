#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "SongLoader.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SongLoader loader;
    engine.rootContext()->setContextProperty("songLoader", &loader);

    const QUrl url(u"qrc:/qt/qml/PhiOpedit/Main.qml"_s);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
