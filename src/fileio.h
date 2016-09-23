#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>

class QDir;
class FileIO : public QObject
{
    Q_OBJECT
public:
    explicit FileIO(QObject *parent = 0);

    QStringList readData() const;
    void writeData(const QString &data);

signals:

private:
    QString filepath;
    QString filename;
    QString fullpath;
    QDir *d;

public slots:

};

#endif // FILEIO_H
