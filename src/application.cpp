#include "application.h"
#include <QCommandLineParser>

#include "settingsuiadaptor.h"
#include "fontsmodel.h"
#include "appearance.h"
#include "battery.h"
#include "brightness.h"
#include "about.h"
#include "background.h"
#include "language.h"

#include "networkmanager/appletproxymodel.h"
#include "networkmanager/networkmodel.h"
#include "networkmanager/networkmodelitem.h"
#include "networkmanager/networking.h"
#include "networkmanager/technologyproxymodel.h"
#include "networkmanager/wirelessitemsettings.h"

Application::Application(int &argc, char **argv)
    : QGuiApplication(argc, argv)
{
    setOrganizationName("cyberos");

    QCommandLineParser parser;
    parser.setApplicationDescription(QStringLiteral("Cyber Settings"));
    parser.addHelpOption();

    QCommandLineOption moduleOption("m", "Switch to module", "module");
    parser.addOption(moduleOption);
    parser.process(*this);

    const QString module = parser.value(moduleOption);

    if (!QDBusConnection::sessionBus().registerService("org.cyber.SettingsUI")) {
        QDBusInterface iface("org.cyber.SettingsUI", "/SettingsUI", "org.cyber.SettingsUI", QDBusConnection::sessionBus());
        if (iface.isValid())
            iface.call("switchToPage", module);
        return;
    }

    new SettingsUIAdaptor(this);
    QDBusConnection::sessionBus().registerObject(QStringLiteral("/SettingsUI"), this);

    // QML
    const char *uri = "Cyber.Settings";
    qmlRegisterType<Appearance>(uri, 1, 0, "Appearance");
    qmlRegisterType<FontsModel>(uri, 1, 0, "FontsModel");
    qmlRegisterType<Brightness>(uri, 1, 0, "Brightness");
    qmlRegisterType<Battery>(uri, 1, 0, "Battery");
    qmlRegisterType<About>(uri, 1, 0, "About");
    qmlRegisterType<Background>(uri, 1, 0, "Background");
    qmlRegisterType<Language>(uri, 1, 0, "Language");

    const char *network_uri = "Cyber.NetworkManager";

    qmlRegisterUncreatableType<NetworkModelItem>(network_uri, 1, 0, "NetworkModelItem",
                                                 QLatin1String("Cannot instantiate NetworkModelItem"));
    qmlRegisterType<AppletProxyModel>(network_uri, 1, 0, "AppletProxyModel");
    qmlRegisterType<NetworkModel>(network_uri, 1, 0, "NetworkModel");
    qmlRegisterType<Networking>(network_uri, 1, 0, "Networking");
    qmlRegisterType<TechnologyProxyModel>(network_uri, 1, 0, "TechnologyProxyModel");
    qmlRegisterType<WirelessItemSettings>(network_uri, 1, 0, "WirelessItemSettings");

    m_engine.addImportPath(QStringLiteral("qrc:/"));
    m_engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (!module.isEmpty()) {
        switchToPage(module);
    }

    QGuiApplication::exec();
}

void Application::switchToPage(const QString &name)
{
    QObject *mainObject = m_engine.rootObjects().first();

    if (mainObject) {
        QMetaObject::invokeMethod(mainObject, "switchPageFromName", Q_ARG(QVariant, name));
    }
}
