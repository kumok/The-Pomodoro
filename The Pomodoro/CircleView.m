//
//  CircleView.m
//  Autocorrect
//
//  Created by Chase Wasden on 1/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Display our percentage as a string
//    NSString* textContent = [NSString stringWithFormat:@"%d", self.percent];
    
    CGFloat startAngle = M_PI * 1.5;
    CGFloat endAngle = startAngle + (M_PI * 2);
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:110
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * self.percent + startAngle
                       clockwise:YES];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 2;
    [[UIColor blackColor] setStroke];
    [bezierPath stroke];
    

}

@end
