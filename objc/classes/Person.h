#include <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;

- (void) sayHelloTo: (NSString*) name;

@end


@implementation Person

- (void) sayHelloTo: (NSString*)name {
	NSLog(@"Hello, %@. From %@", name, [self firstName]);
}

@end