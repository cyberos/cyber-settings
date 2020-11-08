#ifndef APPEARANCE_H
#define APPEARANCE_H

#include <QObject>
#include <QSettings>
#include <QFileSystemWatcher>

class Appearance : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int dockIconSize READ dockIconSize WRITE setDockIconSize NOTIFY dockIconSizeChanged)
    Q_PROPERTY(int dockDirection READ dockDirection WRITE setDockDirection NOTIFY dockDirectionChanged)

public:
    explicit Appearance(QObject *parent = nullptr);

    Q_INVOKABLE void switchDarkMode(bool darkMode);

    int dockIconSize() const;
    Q_INVOKABLE void setDockIconSize(int dockIconSize);

    int dockDirection() const;
    Q_INVOKABLE void setDockDirection(int dockDirection);

signals:
    void dockIconSizeChanged();
    void dockDirectionChanged();

private:
    QSettings *m_dockSettings;
    QFileSystemWatcher *m_dockConfigWacher;

    int m_dockIconSize;
    int m_dockDirection;
};

#endif // APPEARANCE_H
