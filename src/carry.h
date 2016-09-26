#ifndef CARRY_H
#define CARRY_H

#include <QObject>
#include <QStringList>

class FileIO;
class Clock;

class Carry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool lecture READ lecture WRITE setLecture)
public:
    explicit Carry(QObject *parent = 0);
    bool lecture() const;
    void setLecture(const bool &lecture);
    Q_INVOKABLE QStringList getList();

signals:

private:
    bool lec;
    FileIO *f;    
    Clock *c;
    QString startTime;
public slots:

};

#endif // CARRY_H
