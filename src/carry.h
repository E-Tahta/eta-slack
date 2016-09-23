#ifndef CARRY_H
#define CARRY_H

#include <QObject>

class FileIO;

class Carry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool lecture READ lecture WRITE setLecture)
public:
    explicit Carry(QObject *parent = 0);
    bool lecture() const;
    void setLecture(const bool &lecture);

signals:

private:
    bool lec;
    FileIO *f;

public slots:

};

#endif // CARRY_H
