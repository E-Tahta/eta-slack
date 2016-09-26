/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/
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
