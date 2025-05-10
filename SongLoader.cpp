#include "SongLoader.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QTextStream>

SongLoader::SongLoader(QObject* parent) : QObject(parent) {}

QVariantList SongLoader::loadSongs() {
    QVariantList songs;

    QString docPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QDir rootDir(docPath + "/PhiTone Files");
    if (!rootDir.exists()) {
        rootDir.mkpath(".");
    }

    for (const QString& entry : rootDir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
        QDir songDir(rootDir.absoluteFilePath(entry));
        QFile infoFile(songDir.absoluteFilePath("info.txt"));

        if (infoFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
            QTextStream in(&infoFile);
            QVariantMap songInfo;

            while (!in.atEnd()) {
                QString line = in.readLine().trimmed();
                if (line.isEmpty() || line.startsWith("#"))
                    continue;

                const int sepIndex = line.indexOf(':');
                if (sepIndex > 0) {
                    QString key = line.left(sepIndex).trimmed();
                    QString value = line.mid(sepIndex + 1).trimmed();
                    songInfo.insert(key, value);
                }
            }

            if (!songInfo.isEmpty()) {
                songs.append(songInfo);
            }
        }
    }

    return songs;
}
