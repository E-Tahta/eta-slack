#include "carry.h"
#include "fileio.h"

Carry::Carry(QObject *parent) :
    QObject(parent),
    lec(true)
{
    f = new FileIO(this);
}

bool Carry::lecture() const
{
    return lec;
}

void Carry::setLecture(const bool &lecture)
{
    if(lec == true && lecture == false) {
        f->writeData("start_time:endtime");
    }
    lec = lecture;
}
