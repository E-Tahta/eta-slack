#include "clock.h"
#include <QDateTime>
#include <QTimer>

#define TIMER_INTERVAL 1000
#define MINIMUM_LECTURE_TIME_SECS 2

Clock::Clock(QObject *parent) :
    QObject(parent),
    count(0),
    isOk(false)
{
    timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(timeOutSlot()));
}

QString Clock::getCurrentTime() const
{
    return QDateTime::currentDateTime().toString("hh:mm:ss");
}

QString Clock::getCurrentDate() const
{
    return QDateTime::currentDateTime().toString("dd:MM:yyyy");
}
void Clock::startCounting()
{
    count = 0;
    isOk = false;
    timer->start(TIMER_INTERVAL);
}

bool Clock::isOkeyToSave() const
{
    return isOk;
}

void Clock::timeOutSlot()
{
    count ++;
    if ( count == MINIMUM_LECTURE_TIME_SECS ) {
        isOk = true;
        count = 0;
    } else {
        timer->start(TIMER_INTERVAL);
    }
}


