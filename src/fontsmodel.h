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
