#ifndef SENSOR_MOTOR_TRIM_HPP
#define SENSOR_MOTOR_TRIM_HPP

//QT
#include <QObject>
#include <QQmlEngine>
#include <QJSEngine>
#include <QQmlExtensionPlugin>

#include <ros/ros.h>

class Sensor_Motor_Trim : public QObject {
    Q_OBJECT
    Q_DISABLE_COPY(Sensor_Motor_Trim)
    Q_PROPERTY(int index READ getIndex WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(bool press READ getPress WRITE setPress NOTIFY Pressed)
    Q_PROPERTY(double value READ getValue WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int init READ getInit WRITE setInit NOTIFY initChanged)

    public:
        Sensor_Motor_Trim(QObject *parent = 0);
        void setup(ros::NodeHandle * nh);

        int getIndex() const;
        void setIndex(const int &new_index);

        bool getPress() const;
        void setPress(const bool &new_value);

        int getInit() const;
        void setInit(const int &new_value);

        double getValue() const;
        void setValue(const double &new_value);

        // make it a singelton
        static QObject * qml_instance(QQmlEngine * engine, QJSEngine * scriptEngine);
        static Sensor_Motor_Trim * instance;
    signals:
        void indexChanged();
        void valueChanged();
        void Pressed();
        void initChanged();

    public slots:

    private:
        ros::NodeHandle * nh;
        int index;
        double value;
        bool press;
        int init;

};

#endif // SENSOR_MOTOR_TRIM_HPP
