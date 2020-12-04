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
    Q_PROPERTY(int fontPointSize READ fontPointSize WRITE setFontPointSize NOTIFY fontPointSizeChanged)

public:
    explicit Appearance(QObject *parent = nullptr);

    Q_INVOKABLE void switchDarkMode(bool darkMode);

    int dockIconSize() const;
    Q_INVOKABLE void setDockIconSize(int dockIconSize);

    int dockDirection() const;
    Q_INVOKABLE void setDockDirection(int dockDirection);

    Q_INVOKABLE void setGenericFontFamily(const QString &name);
    Q_INVOKABLE void setFixedFontFamily(const QString &name);

    int fontPointSize() const;
    Q_INVOKABLE void setFontPointSize(int fontPointSize);

signals:
    void dockIconSizeChanged();
    void dockDirectionChanged();
    void fontPointSizeChanged();

private:
    QSettings *m_dockSettings;
    QFileSystemWatcher *m_dockConfigWacher;

    int m_dockIconSize;
    int m_dockDirection;
    int m_fontPointSize;
};

#endif // APPEARANCE_H
