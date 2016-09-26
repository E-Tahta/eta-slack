#ifndef CLOCK_H
#define CLOCK_H

#include <QObject>
class QTimer;
class Clock : public QObject
{
    Q_OBJECT
public:
    explicit Clock(QObject *parent = 0);
    QString getCurrentTime() const;
    QString getCurrentDate() const;
    void startCounting();
    bool isOkeyToSave() const;

private:
    unsigned int count;
    bool isOk;
    QTimer *timer;
private slots:
    void timeOutSlot();

public slots:

};

#endif // CLOCK_H
