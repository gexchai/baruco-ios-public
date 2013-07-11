//
//  Created by adamlipka on 2/7/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIView+MoveWithVector.h"


@implementation UIView (MoveWithVector)

- (void)move:(CGPoint)vector {
    CGRect newFrame = CGRectMake(self.frame.origin.x + vector.x, self.frame.origin.y + vector.y, self.frame.size.width, self.frame.size.height);
    [self setFrame:newFrame];
}

- (void)resize:(CGSize)size {
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + size.width, self.frame.size.height + size.height);
    [self setFrame:newFrame];
}
@end