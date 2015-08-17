//
//  CircleView.m
//  uistore
//
//  Created  on 9/2/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CircleView.h"

@interface CircleView() {
    UIColor* viewColour;
    CGFloat viewTransparency;
}

@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame colour:(UIColor*)colour alpha:(CGFloat)alpha {
    if (self = [super initWithFrame:frame]) {
        viewColour = colour;
        viewTransparency = alpha;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context= UIGraphicsGetCurrentContext();

    CGContextSetAlpha(context, viewTransparency);
    
    CGContextSetFillColorWithColor(context, viewColour.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(1,1,self.frame.size.width - 2,self.frame.size.height - 2));
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(1,1,self.frame.size.width - 2,self.frame.size.height - 2));
}


@end
