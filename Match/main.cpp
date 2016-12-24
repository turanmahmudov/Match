#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QLibrary>
#include <QtQml>
#include <QtQml/QQmlContext>

#include <src/tinder.h>

int main(int argc, char *argv[])
{
    setlocale(LC_ALL, "");

    QGuiApplication app(argc, argv);

    qmlRegisterType<Tinder>("Tinder",1,0,"Tinder");

    QQuickView view;

    view.setSource(QUrl(QStringLiteral("qrc:///Main.qml")));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
    return app.exec();
}
