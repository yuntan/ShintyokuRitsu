#ifndef PIECHART_H
#define PIECHART_H

#include <QQuickPaintedItem>
#include <QColor>

class PieBorder : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY borderChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY borderChanged)

public:
    PieBorder(QObject *parent = 0);
    QColor color() const;
    void setColor(const QColor&);
    int width() const;
    void setWidth(int);

signals:
    void borderChanged();

private:
    QColor m_color;
    int m_width;
};

class PieChart : public QQuickPaintedItem
{
    Q_OBJECT
    Q_DISABLE_COPY(PieChart)

    Q_PROPERTY(PieBorder *border READ border)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(qreal arcStart READ arcStart WRITE setArcStart NOTIFY arcStartChanged)
    Q_PROPERTY(qreal arcEnd READ arcEnd WRITE setArcEnd NOTIFY arcEndChanged)
    Q_PROPERTY(bool fill READ fill WRITE setFill NOTIFY fillChanged)

public:
    explicit PieChart(QQuickPaintedItem *parent = 0);
    PieBorder *border() const;
    QColor color() const;
    void setColor(const QColor&);
    qreal arcStart() const;
    void setArcStart(qreal);
    qreal arcEnd() const;
    void setArcEnd(qreal);
    bool fill() const;
    void setFill(bool);

signals:
    void colorChanged();
    void arcStartChanged();
    void arcEndChanged();
    void fillChanged();

private:
    void paint(QPainter *painter);
    PieBorder *m_border;
    QColor m_color;
    qreal m_arcStart;
    qreal m_arcEnd;
    bool m_fill;
};

#endif // PIECHART_H
