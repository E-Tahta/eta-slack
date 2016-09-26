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

        QFile file(fullpath);
        if (!file.open(QIODevice::ReadOnly)) {
            qDebug() << "Could not open data file";
        } else {
            QTextStream in(&file);
            while (!in.atEnd()) {
                QString line = in.readLine();
                l.append(line);
            }
        }

    } else {        
        d->mkpath(filepath);
        QFile file(fullpath);        
    }
}

QStringList FileIO::readData()
{
    l.clear();
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
                l.append(line);
            }

        }

    } else {
        qDebug() << "Data file does not exist or corrupted";
    }
    return l;
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
