#include "carry.h"
#include "fileio.h"
#include "clock.h"
#include <QDebug>
Carry::Carry(QObject *parent) :
    QObject(parent),
    lec(false)
{
    f = new FileIO(this);
    c = new Clock(this);
}

bool Carry::lecture() const
{
    return lec;
}

void Carry::setLecture(const bool &lecture)
{    
    if(lec == true && lecture == false) {
        if(c->isOkeyToSave()) {
            f->writeData(startTime + " - " + c->getCurrentTime() + " "
                         + c->getCurrentDate());
            this->getList();
        }

    } else {
        startTime = c->getCurrentTime();
        c->startCounting();
    }
    lec = lecture;
}

QStringList Carry::getList()
{
    return f->readData();
}
