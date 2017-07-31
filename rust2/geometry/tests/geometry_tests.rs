extern crate geometry;

#[cfg(test)]
mod tests {

    use geometry::geometry::*;

    #[test]
    fn geometry_corner_point() {
        let rect = Rect::new(1, 2, 3, 4);
        assert_eq!(rect.corner_point(), Point { x: 4, y: 6 })
    }

    #[test]
    fn geometry_intersections() {
        let rect0 = Rect::new(10, 15, 20, 20);

        // bottom left
        let rect1 = Rect::new(20, 25, 20, 20);
        assert!(rect0.intersects(&rect1));
        assert!(rect1.intersects(&rect0));

        let expected_intersection1 = Some(Rect::new(20, 25, 10, 10));
        assert_eq!(rect0.intersection(&rect1), expected_intersection1);
        assert_eq!(rect1.intersection(&rect0), expected_intersection1);

        // top left
        let rect2 = Rect::new(20, 5, 20, 20);
        assert!(rect0.intersects(&rect2));
        assert!(rect2.intersects(&rect0));

        let expected_intersection2 = Some(Rect::new(20, 15, 10, 10));
        assert_eq!(rect0.intersection(&rect2), expected_intersection2);
        assert_eq!(rect2.intersection(&rect0), expected_intersection2);

        // non intersecting
        let rect3 = Rect::new(0, 0, 5, 5);
        assert!(!rect0.intersects(&rect3));
        assert!(!rect3.intersects(&rect0));
        assert_eq!(rect0.intersection(&rect3), None);
        assert_eq!(rect3.intersection(&rect0), None);

        // same
        assert!(rect0.intersects(&rect0));
        assert_eq!(rect0.intersection(&rect0), Some(rect0));
    }

    #[test]
    fn geometry_contains() {
        let rect = Rect::new(5, 5, 10, 10);

        assert!(rect.contains(&Rect::new(10, 10, 5, 5)));
        assert!(!rect.contains(&Rect::new(10, 10, 10, 10)));
    }

    #[test]
    fn geometry_i64() {
        let rect64 = Rect::new(5i64, 5i64, 10i64, 10i64);
        assert!(rect64.contains(&Rect::new(10i64, 10i64, 5i64, 5i64)));
    }
}