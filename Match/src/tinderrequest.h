#ifndef TINDERREQUEST_H
#define TINDERREQUEST_H

#include <QObject>
#include <QNetworkAccessManager>

class TinderRequest : public QObject
{
    Q_OBJECT
public:
    explicit TinderRequest(QObject *parent = 0);

    QByteArray token;

    void request(QString endpoint, QJsonObject post);

private:
    QNetworkAccessManager *m_manager;
    QNetworkReply *m_reply;

signals:
    void replySrtingReady(QVariant ans);

public slots:


private slots:
    void finishGetUrl();

};

#endif // TINDERREQUEST_H
