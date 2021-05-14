#include "language.h"
#include <QLocale>
#include <QDebug>
#include <QDir>

#include <unicode/locid.h>
#include <unicode/unistr.h>

static const QStringList supportList = {"cs_CZ", "de_DE", "el_GR", "en_US", "es_MX", "hi_IN", "hu_HU", "id_ID",
                                        "it_IT", "lt_LT", "ml_IN", "nb_NO", "pl_PL", "pt_BR", "ro_RO", "ru_RU", 
                                        "si_LK", "th_TH", "tr_TR", "uk_UA", "yue_HK", "zh_CN", "zh_TW",
                                        // RTL languages
                                        "ar_AA", "fa_IR", "he_IL" };

Language::Language(QObject *parent)
    : QObject(parent)
    , m_interface("org.cyber.Settings",
                  "/Language",
                  "org.cyber.Language",
                  QDBusConnection::sessionBus())
    , m_currentLanguage(-1)
{
    QString systemLanguage = m_interface.property("languageCode").toString();

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
    m_currentLanguage = m_languageCodes.indexOf(systemLanguage);

    emit loadLanguageFinished();
    emit currentLanguageChanged();
}

int Language::currentLanguage() const
{
    return m_currentLanguage;
}

void Language::setCurrentLanguage(int index)
{
    if (index >= 0 && index < m_languageCodes.length()) {
        m_interface.call("setLanguage", m_languageCodes[index]);
        qDebug() << "set language: " << m_languageCodes[index];
        m_currentLanguage = index;
        emit currentLanguageChanged();
    }
}

QStringList Language::languages() const
{
    return m_languageNames;
}
