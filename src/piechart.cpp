#include "piechart.h"
#include <QPainter>

/*!
 * \brief PieBorder::PieBorder
 * \param parent
 * \qml
 *   border.color: "blue"
 *   border.widht: 3
 * \endqml
 */
PieBorder::PieBorder(QObject *parent) :
    QObject(parent),
    m_color(Qt::white),
    m_width(0)
{
}

QColor PieBorder::color() const {
    return m_color;
}

void PieBorder::setColor(const QColor &c) {
    if(m_color == c) { return; }
    m_color = c;
    emit borderChanged();
}

int PieBorder::width() const {
    return m_width;
}

void PieBorder::setWidth(int w) {
    if(m_width == w) { return; }
    m_width = w;
    emit borderChanged();
}

/*!
 * \brief PieChart::PieChart
 * \param parent
 * \qml
 *   PieChart {
 *     arcStart: 90; arcEnd: 0
 *     fill: true
 *     color: "green"
 *   }
 * \endqml
 */
PieChart::PieChart(QQuickPaintedItem *parent) :
    QQuickPaintedItem(parent),
    m_border(new PieBorder(this)),
    m_color(Qt::white),
    m_arcStart(0),
    m_arcEnd(360),
    m_fill(true)
{
    setFlag(ItemHasContents);
}

PieBorder* PieChart::border() const {
    return m_border;
}

QColor PieChart::color() const {
    return m_color;
}

void PieChart::setColor(const QColor &c) {
    if(m_color == c) { return; }
    m_color = c;
    update();
    emit colorChanged();
}

qreal PieChart::arcStart() const {
    return m_arcStart;
}

void PieChart::setArcStart(qreal value) {
    if(m_arcStart == value) { return; }
    m_arcStart = value;
    update();
    emit arcStartChanged();
}

qreal PieChart::arcEnd() const {
    return m_arcEnd;
}

void PieChart::setArcEnd(qreal value) {
    if(m_arcEnd == value) { return; }
    m_arcEnd = value;
    update();
    emit arcEndChanged();
}

bool PieChart::fill() const {
    return m_fill;
}

void PieChart::setFill(bool b) {
    if(m_fill == b) { return; }
    m_fill = b;
    update();
    emit fillChanged();
}

void PieChart::paint(QPainter *painter) {
    QPen pen(m_border->color(), m_border->width());
    painter->setPen(pen);
    if(m_fill) {
        QBrush brush(m_color);
        painter->setBrush(brush);
    }
    painter->setRenderHints(QPainter::Antialiasing, true);

    // make the pie (including border) settle into designated rectangle
    QRectF drawRect(boundingRect());
    if(m_border->width() != 0) {
        qreal margin = m_border->width() / 2;
        drawRect.setTop(drawRect.top() + margin);
        drawRect.setBottom(drawRect.bottom() - margin);
        drawRect.setLeft(drawRect.left() + margin);
        drawRect.setRight(drawRect.right() - margin);
    }

    painter->drawPie(drawRect, m_arcStart * 16, (m_arcEnd - m_arcStart) * 16);
}
