#include "language.h"
#include <QLocale>
#include <QDebug>
#include <QDir>

#include <unicode/locid.h>
#include <unicode/unistr.h>

static const QStringList supportList = {"en_US", "en_NZ", "en_CA", "en_AU", "en_GB",
                                        "zh_CN", "zh_HK", "zh_TW", "ja", "ko", "ru", "de", "it"
                                       };

Language::Language(QObject *parent)
    : QObject(parent)
    , m_currentLanguage(-1)
{
    for (const QString &code : supportList) {
        std::string string;
        icu::Locale locale = qPrintable(code);
        icu::UnicodeString unicodeString;
        locale.getDisplayName(locale, unicodeString);
        unicodeString.toUTF8String(string);

        QString displayName = string.c_str();

        if (displayName.isEmpty() || displayName == "C")
            continue;

        m_languageNames.append(displayName);
        m_languageCodes.append(code);
    }

    // Update current language
    m_currentLanguage = m_languageCodes.indexOf(QLocale::system().name());

    emit loadLanguageFinished();
    emit currentLanguageChanged();
}

int Language::currentLanguage() const
{
    return m_currentLanguage;
}

void Language::setCurrentLanguage(int index)
{
    if (index > 0 && index < m_languageCodes.length()) {
        m_currentLanguage = index;
        emit currentLanguageChanged();
    }
}

QStringList Language::languages() const
{
    return m_languageNames;
}
