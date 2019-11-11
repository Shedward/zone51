#[derive(Debug)]
struct Point<PositionUnit> {
    x: PositionUnit,
    y: PositionUnit
}

trait GraphicsContext<PositionUnit, AngleUnit> {
    fn moveTo(&self, point: &Point<PositionUnit>);
    fn lineTo(&self, point: &Point<PositionUnit>);
    fn arc(
        &self, 
        center: &Point<PositionUnit>,
        radius: &PositionUnit,
        startAngle: &AngleUnit,
        endAngle: &AngleUnit,
        clockwise: bool
    );
    fn close(&self);
}

trait GraphicsElement<PositionUnit, AngleUnit> {
    fn draw(&self, context: impl GraphicsContext<PositionUnit, AngleUnit>);
}

#[derive(Debug)]
struct Line<PositionUnit> {
    start: Point<PositionUnit>,
    end: Point<PositionUnit>
}

impl<PositionUnit, AngleUnit> GraphicsElement<PositionUnit, AngleUnit> for Line<PositionUnit> {
    fn draw(&self, context: impl GraphicsContext<PositionUnit, AngleUnit>) {
        context.moveTo(&self.start);
        context.lineTo(&self.end);
        context.close();
    }
}

#[derive(Debug)]
struct Circle<PositionUnit> {
    center: Point<PositionUnit>,
    radius: PositionUnit
}

impl<PositionUnit, AngleUnit> GraphicsElement<PositionUnit, AngleUnit> for Circle<PositionUnit> {
    fn draw(&self, context: impl GraphicsContext<PositionUnit, AngleUnit>) {
        context.moveTo(&self.center);
    }
}

fn main() {
}