use std::fmt::Display;

#[derive(Debug, Clone, Copy)]
struct Point<PositionUnit> {
    x: PositionUnit,
    y: PositionUnit
}

trait GraphicsContext<PositionUnit, AngleUnit> {
    fn move_to(&mut self, point: &Point<PositionUnit>);
    fn line_to(&mut self, point: &Point<PositionUnit>);
    fn arc(
        &mut self, 
        center: &Point<PositionUnit>,
        radius: &PositionUnit,
        start_angle: &AngleUnit,
        end_angle: &AngleUnit,
        clockwise: bool
    );
    fn close(&mut self);
}

trait GraphicsElement<PositionUnit, AngleUnit> {
    fn draw(&self, context: &mut impl GraphicsContext<PositionUnit, AngleUnit>);
}

#[derive(Debug)]
struct Line<PositionUnit, AngleUnit> {
    start: Point<PositionUnit>,
    end: Point<PositionUnit>,
    origin_angle: AngleUnit
}

impl<PositionUnit, AngleUnit> GraphicsElement<PositionUnit, AngleUnit> for Line<PositionUnit, AngleUnit> {
    fn draw(&self, context: &mut impl GraphicsContext<PositionUnit, AngleUnit>) {
        context.move_to(&self.start);
        context.line_to(&self.end);
        context.close();
    }
}

#[derive(Debug)]
struct Circle<PositionUnit, AngleUnit> {
    center: Point<PositionUnit>,
    radius: PositionUnit,
    start_angle: AngleUnit,
    end_angle: AngleUnit
}

impl<PositionUnit, AngleUnit> GraphicsElement<PositionUnit, AngleUnit> for Circle<PositionUnit, AngleUnit> {
    fn draw(&self, context: &mut impl GraphicsContext<PositionUnit, AngleUnit>) {
        context.move_to(&self.center);
        context.arc(
            &self.center, 
            &self.radius, 
            &self.start_angle,
            &self.end_angle,
            true
        )
    }
}

struct TXTGraphicsContext {
    commands: Vec<String>
}

impl TXTGraphicsContext {
    fn new() -> TXTGraphicsContext {
        TXTGraphicsContext { commands: Vec::new() }
    }

    fn description(&self) -> String {
        self.commands.join("\n")
    }
}

impl<PositionUnit, AngleUnit> GraphicsContext<PositionUnit, AngleUnit> for TXTGraphicsContext 
        where PositionUnit: Display, AngleUnit: Display {
    fn move_to(&mut self, point: &Point<PositionUnit>) {
        self.commands.push(format!("MoveTo({},{})", point.x, point.y));
    }

    fn line_to(&mut self, point: &Point<PositionUnit>) {
        self.commands.push(format!("LineTo({},{})", point.x, point.y));
    }
    fn arc(
        &mut self, 
        center: &Point<PositionUnit>,
        radius: &PositionUnit,
        start_angle: &AngleUnit,
        end_angle: &AngleUnit,
        clockwise: bool
    ) {
        self.commands.push(format!("Arc(({},{}), {}, {} -> {})", center.x, center.y, radius, start_angle, end_angle));
    }
    fn close(&mut self) {
        self.commands.push(String::from("Close"));
    }
}

fn main() {
    let mut context = TXTGraphicsContext::new();
    println!("{}", context.description());

    let point1 = Point { x: 1, y: 1 };
    let point2 = Point { x: 2, y: 2 };
    let point3 = Point { x: 5, y: 4 };
    let abstract_point = Point { x: "x", y: "y" };

    let line1 = Line { start: point1, end: point2, origin_angle: 0 };
    let line2 = Line { start: point2, end: point3, origin_angle: 0 };
    let abstract_circle = Circle {
        center: abstract_point,
        radius: "R",
        start_angle: 0,
        end_angle: 180
    };

    abstract_circle.draw(&mut context);
    line1.draw(&mut context);
    line2.draw(&mut context);

    println!("{}", context.description());
}