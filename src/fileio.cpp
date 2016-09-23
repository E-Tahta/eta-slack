#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QTextStream>
#include <QString>
#include "fileio.h"

#include <QDebug>

FileIO::FileIO(QObject *parent) :
    QObject(parent)
{

    filepath = QDir::homePath() + "/.config/eta/slack";
    filename = "data.eta";
    fullpath = filepath + "/" + filename;
    QFileInfo checkFile(fullpath);

    d = new QDir(QDir::home());

    if(checkFile.exists() && checkFile.isFile()) {
        qDebug() << fullpath;
        QFile file(fullpath);
        if (!file.open(QIODevice::ReadOnly)) {
            qDebug() << "Could not open data file";
        } else {
            QTextStream in(&file);
            while (!in.atEnd()) {
                QString line = in.readLine();
                qDebug() << line;
            }
        }

    } else {
        qDebug() << fullpath;
        d->mkpath(filepath);
        QFile file(fullpath);
        /*
        if (!file.open(QIODevice::WriteOnly)) {
            qDebug() << "Could not create data file";
        } else {
            QTextStream out(&file);
            out << "start" <<":"<<"end"<< "\n";
        }
        */
    }
}

QStringList FileIO::readData() const
{
    QStringList out;
    QFileInfo checkFile(fullpath);
    if(checkFile.exists() && checkFile.isFile()) {
        d->mkpath(filepath);
        QFile file(fullpath);
        if (!file.open(QIODevice::ReadOnly)) {
            qDebug() << "Could not open data file while trying to read";
        } else {
            QTextStream in(&file);
            while (!in.atEnd()) {
                QString line = in.readLine();
                out.append(line);
                qDebug() << line;
            }

        }

    } else {

        qDebug() << "Data file does not exit or corrupted";
    }
    return out;
}

void FileIO::writeData(const QString &data)
{
    if(!QDir::isAbsolutePath(filepath)) {
      d->mkpath(filepath);
    }
    QFile file(fullpath);
    if (!file.open(QIODevice::Append)) {
        qDebug() << "Could not open data file while trying to write";
    } else {
        QTextStream out(&file);
        out << data << "\n";
    }

}
