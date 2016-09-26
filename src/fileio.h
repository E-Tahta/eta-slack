#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QStringList>

class QDir;
class FileIO : public QObject
{
    Q_OBJECT
public:
    explicit FileIO(QObject *parent = 0);

    QStringList readData();
    void writeData(const QString &data);

signals:

private:
    QString filepath;
    QString filename;
    QString fullpath;
    QStringList l;
    QDir *d;

public slots:

};

#endif // FILEIO_H
