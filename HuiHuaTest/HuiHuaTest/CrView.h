//
//  CrView.h
//  HuiHuaTest
//
//  Created by CSaT_SunTony on 15/10/21.
//  Copyright © 2015年 李新波. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
@interface CrView : UIView
@property (nonatomic) NSInteger cyclenum;
@property (nonatomic) CGContextRef contextline;
@property (nonatomic) CGContextRef context;
@property (nonatomic) NSInteger gostoke;
@property (nonatomic) CAShapeLayer *cashapelayer;
@property (nonatomic,strong) UIView *cirview;
@property (nonatomic) CGFloat interval; //转速
@property (nonatomic) NSTimer *time;
- (void)start:(CGFloat)stoke;
- (void)stop;
@end
