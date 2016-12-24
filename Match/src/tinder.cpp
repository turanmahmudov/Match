#include <src/tinder.h>
#include <src/tinderrequest.h>

#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QUrl>

#include <QDebug>

Tinder::Tinder(QObject *parent)
    : QObject(parent)
{

}

void Tinder::auth(QString fbToken)
{
    TinderRequest *authRequest = new TinderRequest();
    QJsonObject data;
    data.insert("facebook_token", fbToken);

    authRequest->token = this->token;
    authRequest->request("auth", data);
    QObject::connect(authRequest,SIGNAL(replySrtingReady(QVariant)),this,SLOT(authFinish(QVariant)));
}

void Tinder::authFinish(QVariant auth)
{
    QJsonDocument auth_doc = QJsonDocument::fromJson(auth.toString().toUtf8());
    QJsonObject auth_obj = auth_doc.object();

    //qDebug() << "Reply: " << auth_obj;

    if(auth_obj["code"].toString().toUtf8() == "401")
    {
        emit authNotFinished(auth);
    }
    else
    {
        qDebug() << "token: " << auth_obj["token"].toString().toUtf8();

        emit authFinished(auth);
    }
}
