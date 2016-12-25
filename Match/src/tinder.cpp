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

    if(auth_obj["code"].toDouble() == 401)
    {
        emit authNotFinished(auth);
    }
    else
    {
        qDebug() << "token: " << auth_obj["token"].toString().toUtf8();

        emit authFinished(auth);
    }
}

void Tinder::recs()
{
    TinderRequest *recsRequest = new TinderRequest();
    QJsonObject data;

    recsRequest->token = this->token;
    recsRequest->request("user/recs", data);
    QObject::connect(recsRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(recsFinished(QVariant)));
}

void Tinder::updateProfile(QString age_filter_min, QString age_filter_max, QString distance_filter, QString gender)
{
    TinderRequest *updateProfileRequest = new TinderRequest();
    QJsonObject data;
    data.insert("age_filter_min", age_filter_min);
    data.insert("age_filter_max", age_filter_max);
    data.insert("distance_filter", distance_filter);
    data.insert("gender", gender);

    updateProfileRequest->token = this->token;
    updateProfileRequest->request("profile", data);
    QObject::connect(updateProfileRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(updateProfileFinished(QVariant)));
}

void Tinder::updates()
{
    TinderRequest *updatesRequest = new TinderRequest();
    QJsonObject data;

    updatesRequest->token = this->token;
    updatesRequest->request("updates", data);
    QObject::connect(updatesRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(updatesFinished(QVariant)));
}

void Tinder::reportUser(QString user_id, QString cause_id)
{
    TinderRequest *reportUserRequest = new TinderRequest();
    QJsonObject data;
    data.insert("cause", cause_id);

    reportUserRequest->token = this->token;
    reportUserRequest->request("report/"+user_id, data);
    QObject::connect(reportUserRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(reportUserFinished(QVariant)));
}

void Tinder::updateLocation(QString lat, QString lon)
{
    TinderRequest *updateLocationRequest = new TinderRequest();
    QJsonObject data;
    data.insert("lat", lat);
    data.insert("lon", lon);

    updateLocationRequest->token = this->token;
    updateLocationRequest->request("user/ping", data);
    QObject::connect(updateLocationRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(updateLocationFinished(QVariant)));
}

void Tinder::sendMessage(QString match_id, QString message)
{
    TinderRequest *sendMessageRequest = new TinderRequest();
    QJsonObject data;
    data.insert("message", message);

    sendMessageRequest->token = this->token;
    sendMessageRequest->request("user/matches/"+match_id, data);
    QObject::connect(sendMessageRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(sendMessageFinished(QVariant)));
}

void Tinder::like(QString user_id)
{
    TinderRequest *likeRequest = new TinderRequest();
    QJsonObject data;
    likeRequest->token = this->token;
    likeRequest->request("like/"+user_id, data);
    QObject::connect(likeRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(likeFinished(QVariant)));
}

void Tinder::dislike(QString user_id)
{
    TinderRequest *likeRequest = new TinderRequest();
    QJsonObject data;
    likeRequest->token = this->token;
    likeRequest->request("pass/"+user_id, data);
    QObject::connect(likeRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(dislikeFinished(QVariant)));
}

void Tinder::superlike(QString user_id)
{
    TinderRequest *likeRequest = new TinderRequest();
    QJsonObject data;
    likeRequest->token = this->token;
    likeRequest->request("like/"+user_id+"/super", data);
    QObject::connect(likeRequest,SIGNAL(replySrtingReady(QVariant)),this,SIGNAL(superlikeFinished(QVariant)));
}
