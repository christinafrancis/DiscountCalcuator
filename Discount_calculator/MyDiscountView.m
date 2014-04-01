//
//  MyDiscountView.m
//  Discount_calculator
//
//  Created by Christina Francis on 10/2/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//


// Drawing code taken from the Apple QuartzDemo
// <http://developer.apple.com/library/ios/#samplecode/QuartzDemo/Introduction/Intro.html>

#import "MyDiscountView.h"
#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi

@implementation MyDiscountView



- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    
        self.backgroundColor = [UIColor lightGrayColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

            // Drawing with a white stroke color
            CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
            // And drawing with a blue fill color
            CGContextSetRGBFillColor(context, 0.4, 0.6, 0.5, 1.0);
            // Draw them with a 2.0 stroke width so they are a bit more visible.
            CGContextSetLineWidth(context, 2.0);
    
    float save_perc_deg = [[self.lb_save_perc text ] floatValue] / 100 * 360;
    NSLog(@"%f",save_perc_deg);
    
   
            // Add Rect to the current path, then stroke it
            CGContextAddRect(context, CGRectMake( 150.0, 340.0, 30.0,30.0));
            CGContextFillPath(context);
            CGContextStrokePath(context);
            
           
    
            CGContextSaveGState(context);
            CGContextSetRGBFillColor(context, 1.0, 0.6, 0.5, 1.0);
           
      
            CGContextFillRect(context, CGRectMake(150.0, 380.0, 30.0, 30.0));
            CGContextRestoreGState(context);
            

         
    
    
    // Drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    // Draw a bezier curve with end points s,e and control points cp1,cp2
  
   CGContextBeginPath(context);
    CGContextMoveToPoint (context, 160.0, 160);
     
    CGContextAddArc(context, 160.0, 160.0, 160, 0.0, DEG2RAD(save_perc_deg), false);
   
     CGContextMoveToPoint (context, 160.0, 160);
    CGContextClosePath(context);
   
      CGRect frame = CGContextGetPathBoundingBox(context);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
    NSDictionary* rectDic = (__bridge NSDictionary *)(CGRectCreateDictionaryRepresentation(frame));
    NSLog(@"%@", CGRectCreateDictionaryRepresentation(frame));
    
    CGRect box = CGRectMake([[rectDic objectForKey:@"X"] floatValue], [[rectDic objectForKey:@"Y"] floatValue], 150.0,60.0);
    

    self.lb_save_price.frame = box;

    
    CGContextSetRGBFillColor(context, 1.0, 0.6, 0.5, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint (context, 160.0, 160);

    CGContextAddArc(context, 160.0, 160.0, 160, 0.0, DEG2RAD(save_perc_deg), true);
   
    CGContextMoveToPoint (context, 160.0, 160);
    CGContextClosePath(context);
    frame = CGContextGetPathBoundingBox(context);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
    rectDic = (__bridge NSDictionary *)(CGRectCreateDictionaryRepresentation(frame));
    NSLog(@"%@", CGRectCreateDictionaryRepresentation(frame));
    
    box = CGRectMake([[rectDic objectForKey:@"X"] floatValue], [[rectDic objectForKey:@"Y"] floatValue], 150.0,60.0);
    
    
    self.lb_disc_price.frame = box;
    

    
}


@end
