#ifndef TINDER_H
#define TINDER_H

#include <QObject>
#include <QVariant>

class Tinder : public QObject
{
    Q_OBJECT

public:
    explicit Tinder(QObject *parent = 0);

public slots:
    void setToken(QByteArray token){this->token = token;}

    void auth(QString fbToken);

    void recs();
    void updateProfile(QString age_filter_min, QString age_filter_max, QString distance_filter, QString gender);
    void updates();
    void reportUser(QString user_id, QString cause_id);
    void updateLocation(QString lat, QString lon);
    void sendMessage(QString match_id, QString message);
    void like(QString user_id);
    void dislike(QString user_id);
    void superlike(QString user_id);

private:
    QByteArray token;

signals:
    void authFinished(QVariant answer);
    void authNotFinished(QVariant answer);

    void recsFinished(QVariant answer);
    void updateProfileFinished(QVariant answer);
    void updatesFinished(QVariant answer);
    void reportUserFinished(QVariant answer);
    void updateLocationFinished(QVariant answer);
    void sendMessageFinished(QVariant answer);
    void likeFinished(QVariant answer);
    void dislikeFinished(QVariant answer);
    void superlikeFinished(QVariant answer);

private slots:
    void authFinish(QVariant auth);

};

#endif // TINDER_H
