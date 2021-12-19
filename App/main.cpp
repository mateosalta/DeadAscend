#include "src/fileio.h"
#include "src/fpstext.h"
#include "src/languageswitcher.h"

#include <QtQml>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    qmlRegisterType<FPSText, 1>("FPSText", 1, 0, "FPSText");
    qmlRegisterType<LanguageSwitcher, 1>("LanguageSwitcher", 1, 0, "LanguageSwitcher");

    QGuiApplication app(argc, argv);
    //app.setOrganizationName("Black Grain");
    //app.setOrganizationDomain("blackgrain.dk");
    app.setApplicationName("deadascend.mateo-salta");

    #ifdef VERSION
    //app.setApplicationVersion(QString(VERSION));
    #endif

    QQmlApplicationEngine engine;


    #ifdef VERSION
    engine.rootContext()->setContextProperty("version", QString(VERSION));
    #endif

    #ifdef GIT_VERSION
    engine.rootContext()->setContextProperty("gitVersion", QString(GIT_VERSION));
    #endif

    #ifdef QAK_VERSION
    engine.rootContext()->setContextProperty("qakVersion", QString(QAK_VERSION));
    #endif

    #ifdef QAK_GIT_VERSION
    engine.rootContext()->setContextProperty("qakGitVersion", QString(QAK_GIT_VERSION));
    #endif

    #ifdef QTFIREBASE_VERSION
    engine.rootContext()->setContextProperty("qtFirebaseVersion", QString(QTFIREBASE_VERSION));
    #endif

    #ifdef QTFIREBASE_GIT_VERSION
    engine.rootContext()->setContextProperty("qtFirebaseGitVersion", QString(QTFIREBASE_GIT_VERSION));
    #endif


    #ifdef QT_DEBUG
    engine.rootContext()->setContextProperty("debugBuild", QVariant(true));
    #else
    engine.rootContext()->setContextProperty("debugBuild", QVariant(false));
    #endif

    #if defined(QTFIREBASE_BUILD_ADMOB) && (defined(Q_OS_IOS) || defined(Q_OS_ANDROID))
    engine.rootContext()->setContextProperty("adBuild", QVariant(true));
    #else
    engine.rootContext()->setContextProperty("adBuild", QVariant(false));
    #endif

    engine.rootContext()->setContextProperty("qtVersion", QString(QT_VERSION_STR));

    QString assetPath;
    #if defined(Q_OS_ANDROID)
    assetPath = "assets:/assets.rcc";
    #else
        #if defined(ASSETS_DIR)
        assetPath = QString(ASSETS_DIR)+"/assets.rcc";
        #endif
        if(assetPath.isEmpty() || assetPath.isNull())
            assetPath = QCoreApplication::applicationDirPath()+"/assets.rcc";
    #endif

    qDebug() << "Registering" << assetPath;
    if(QResource::registerResource(assetPath))
        qDebug() << "Registered assets from" << assetPath;
    else
        qDebug() << "FAILED registering assets from" << assetPath;


    engine.addImportPath("qrc:///");

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
