#include "tinderrequest.h"

#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QUrl>

TinderRequest::TinderRequest(QObject *parent) : QObject(parent)
{
    this->m_manager = new QNetworkAccessManager();
}

void TinderRequest::request(QString endpoint, QJsonObject post)
{
    QJsonDocument data_doc(post);
    QString data_string(data_doc.toJson(QJsonDocument::Compact));

    QUrl url("https://api.gotinder.com/"+endpoint);
    QNetworkRequest request(url);

    request.setRawHeader("X-Auth-Token", this->token);
    request.setRawHeader("os-version", "21");
    request.setRawHeader("app-version", "767");
    request.setRawHeader("platform", "android");
    request.setRawHeader("User-Agent", "Tinder Android Version 4.0.3");
    request.setRawHeader("Accept","*/*");
    request.setRawHeader("Content-type","application/json; charset=utf-8");

    this->m_reply = this->m_manager->post(request, data_string.toUtf8());

    QObject::connect(this->m_reply, SIGNAL(finished()), this, SLOT(finishGetUrl()));
    //QObject::connect(this->m_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(saveCookie()));
}

void TinderRequest::finishGetUrl()
{
    this->m_reply->deleteLater();
    QVariant answer = QString::fromUtf8(this->m_reply->readAll());
    if(answer.toString().length() > 1)
    {
        //qDebug() << answer;
        emit replySrtingReady(answer);
    }
}
