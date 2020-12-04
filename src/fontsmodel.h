/*
 * Copyright (C) 2020 CyberOS Team.
 *
 * Author:     revenmartin <revenmartin@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef FONTSMODEL_H
#define FONTSMODEL_H

#include <QObject>

class FontsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList generalFonts READ generalFonts NOTIFY fontsChanged)
    Q_PROPERTY(QStringList fixedFonts READ fixedFonts NOTIFY fontsChanged)
    Q_PROPERTY(int generalFontIndex READ generalFontIndex NOTIFY fontsChanged)
    Q_PROPERTY(int fixedFontIndex READ fixedFontIndex NOTIFY fontsChanged)

public:
    explicit FontsModel(QObject *parent = nullptr);

    QStringList generalFonts() const;
    void setGeneralFonts(const QStringList &generalFonts);

    QStringList fixedFonts() const;
    void setFixedFonts(const QStringList &fixedFonts);

    QString generalFont() const;
    QString fixedFont() const;

    int generalFontIndex() const;
    int fixedFontIndex() const;

    void initFonts();

signals:
    void fontsChanged();

private:
    QStringList m_generalFonts;
    QStringList m_fixedFonts;

    int m_generalFontIndex;
    int m_fixedFontIndex;
};

#endif // FONTSMODEL_H
