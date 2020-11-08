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
