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
