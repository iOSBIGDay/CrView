//
//  CrView.m
//  HuiHuaTest
//
//  Created by CSaT_SunTony on 15/10/21.
//  Copyright © 2015年 李新波. All rights reserved.
//

#import "CrView.h"
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0)
#define PartNumber      240
@implementation CrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    //    self = [super initWithFrame:CGRectMake(frame.origin.x - 1, frame.origin.y - 1, frame.size.width - 2, frame.size.height - 2)];
    self = [super initWithFrame:frame];
    if (self) {
        [self setback];
    }
    return self;
}

- (void)setback
{
    //    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    //    self.layer.cornerRadius = self.frame.size.width / 2;
}
- (void)drawRect:(CGRect)rect
{
    [self setCircle];
    _cyclenum = 1;

    float width = (float) 1 / PartNumber;
    [self setLineAlphaStartStorke:0 EndStroke:width Color:RGB(78, 96, 66)];
    for (int i = 1; i <= PartNumber; i ++) {
        if (i % 2 ==0) {
            [self setLineAlphaStartStorke:i * width EndStroke:width + i * width Color:[UIColor colorWithRed:223/255.f green:223/255.f blue:223/255.f alpha:1.0]];
        }
    }
}

- (void)start:(CGFloat)stoke{

    
    if (!_interval) {
        _interval = 0.01;
    }
    _gostoke =  stoke * PartNumber;
    _time = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(animationofwheel:) userInfo:nil repeats:YES];
}

-(void)animationofwheel:(NSTimer *)time{

    _cyclenum++;

    float width = (float) 1 / PartNumber;
    if (_cyclenum % 2 == 0) {
        [self setLineAlphaStartStorke:_cyclenum * width EndStroke:_cyclenum * width + width Color:RGB(86, 103, 69)];
        _cirview.center = [self pointFromAngle:(float)_cyclenum/PartNumber*360];
    }
    if (_cyclenum > _gostoke) {
        [_time invalidate];
        
    }



}
-(CGPoint)pointFromAngle:(float)angleInt{
    
    //    NSLog(@"%f",ToRad(angleInt));
    //Circle center
    CGFloat radius = self.bounds.size.width / 2 - 3;
    
    CGPoint centerPoint = CGPointMake(radius + 3, radius + 3);
    
    //The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(angleInt) - ToRad(89)));
    result.x = round(centerPoint.x + radius * cos(ToRad(angleInt) - ToRad(89)));
    //    NSLog(@"%f,%f",result.x,result.y);
    return result;
}


//停止
- (void)stop
{
    [_time invalidate];
}


//画圆
- (void)setCircle
{
    _context = UIGraphicsGetCurrentContext();
    CGFloat radius = self.bounds.size.width / 2 - 3;
    //    CGRect Rect = self.bounds;
    CGRect Rect = CGRectMake(3, 3, self.bounds.size.width - 6, self.bounds.size.height - 6);

    CGContextRef contextcircle = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextcircle);
    CGContextSetLineWidth(contextcircle, 2);
    CGContextSetRGBStrokeColor(contextcircle, 107/255.0, 185/255.0, 52/255.0, 1);
    CGContextMoveToPoint(contextcircle, CGRectGetMinX(Rect), CGRectGetMinY(Rect) + radius);
    CGContextAddArc(contextcircle, CGRectGetMaxX(Rect) - radius, CGRectGetMaxX(Rect) - radius, radius, M_PI, 3 * M_PI_2, 0);
    CGContextAddArc(contextcircle, CGRectGetMaxX(Rect) - radius, CGRectGetMaxX(Rect) - radius, radius, 3 * M_PI_2, 0, 0);
    CGContextAddArc(contextcircle, CGRectGetMaxX(Rect) - radius, CGRectGetMaxX(Rect) - radius, radius, 0, M_PI_2, 0);
    CGContextAddArc(contextcircle, CGRectGetMaxX(Rect) - radius, CGRectGetMaxX(Rect) - radius, radius, M_PI_2, M_PI, 0);
    CGContextStrokePath(contextcircle);
    
    _cirview = [[UIView alloc] initWithFrame:CGRectMake(radius, 0, 6, 6)];
    _cirview.layer.cornerRadius = 3;
    _cirview.backgroundColor = RGB(135, 202, 74);
    [self addSubview:_cirview];
}
- (void)setLineAlphaStartStorke:(CGFloat)start EndStroke:(CGFloat)end Color:(UIColor *)color
{
    CGFloat radius = self.bounds.size.width / 2;
    _cashapelayer = [self createRingLayerWithCenter:CGPointMake(radius, radius) radius:radius * 7 / 8 - 2 lineWidth:radius / 8 color:color];
    _cashapelayer.strokeStart = start;
    _cashapelayer.strokeEnd = end;
    [self.layer addSublayer:_cashapelayer];
}
- (CAShapeLayer *)createRingLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    UIBezierPath *smoothedPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:- M_PI_2 endAngle:(M_PI + M_PI_2) clockwise:YES];
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.contentsScale = [[UIScreen mainScreen] scale];
    slice.frame = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    slice.fillColor = [UIColor clearColor].CGColor;
    slice.strokeColor = color.CGColor;
    slice.lineWidth = lineWidth;
    slice.lineCap = kCALineJoinBevel;
    slice.lineJoin = kCALineJoinBevel;
    slice.path = smoothedPath.CGPath;
    return slice;
}

@end
