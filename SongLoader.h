#ifndef SONGLOADER_H
#define SONGLOADER_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

class SongLoader : public QObject {
    Q_OBJECT
public:
    explicit SongLoader(QObject* parent = nullptr);

    Q_INVOKABLE QVariantList loadSongs(); // 供 QML 调用
};

#endif // SONGLOADER_H
