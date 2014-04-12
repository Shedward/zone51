@interface Circle : NSObject
{
@private
 ShapeColor fillColor;
 ShapeRect  bounds; 
}

- (void) setFillColor: (ShapeColor) fillColor;
- (void) setBounds: (ShapeRect) bounds;
@end