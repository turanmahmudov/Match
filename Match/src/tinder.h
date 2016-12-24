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

private:
    QByteArray token;

signals:
    void authFinished(QVariant answer);
    void authNotFinished(QVariant answer);


private slots:
    void authFinish(QVariant auth);

};

#endif // TINDER_H
