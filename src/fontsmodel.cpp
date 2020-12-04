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

#include "fontsmodel.h"
#include <QFontDatabase>
#include <QFontInfo>
#include <QTimer>

FontsModel::FontsModel(QObject *parent)
    : QObject(parent)
    , m_generalFontIndex(0)
    , m_fixedFontIndex(0)
{
    QTimer::singleShot(500, this, &FontsModel::initFonts);
}

QStringList FontsModel::generalFonts() const
{
    return m_generalFonts;
}

void FontsModel::setGeneralFonts(const QStringList &generalFonts)
{
    m_generalFonts = generalFonts;
}

QStringList FontsModel::fixedFonts() const
{
    return m_fixedFonts;
}

void FontsModel::setFixedFonts(const QStringList &fixedFonts)
{
    m_fixedFonts = fixedFonts;
}

int FontsModel::generalFontIndex() const
{
    return m_generalFontIndex;
}

int FontsModel::fixedFontIndex() const
{
    return m_fixedFontIndex;
}

void FontsModel::initFonts()
{
    QFontDatabase fontDatabase;
    for (const QString &family : fontDatabase.families()) {
        QFont font(family);
        QFontInfo info(font);
        if (info.fixedPitch())
            m_fixedFonts << family;
        else
            m_generalFonts << family;
    }

    QFont generilFont = fontDatabase.systemFont(QFontDatabase::GeneralFont);
    QFont fixedFont = fontDatabase.systemFont(QFontDatabase::FixedFont);
    m_generalFontIndex = m_generalFonts.indexOf(generilFont.family());
    m_fixedFontIndex = m_fixedFonts.indexOf(fixedFont.family());

    emit fontsChanged();
}
