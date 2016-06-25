//
//  AwRollLabel.m
//  YFRollingLabel
//
//  Created by yelin on 16/6/25.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AwRollLabel.h"

@interface UIView(AwRollLabel)
@property (nonatomic, assign) CGFloat y;
@end
@implementation UIView(AwRollLabel)
@dynamic y;
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
@end

@interface AwRollLabel ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation AwRollLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.clipsToBounds=YES;
    }
    return self;
}
-(void)creatUI{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*2, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label3];
    self.label1=label1;
    self.label2=label2;
    self.label3=label3;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}
-(void)tapAction{
    if (self.index==0) {
        NSLog(@"index=%ld,text:%@",self.textArray.count-1,[self.textArray lastObject]);
    }else{
        NSLog(@"index=%ld,text:%@",self.index-1,self.textArray[self.index-1]);
    }
    if (self.tapBlock) {
        if (self.index==0) {
            self.tapBlock(self.textArray.count-1);
        }else{
            self.tapBlock(self.index-1);
        }
    }
}
-(void)setTextArray:(NSArray *)textArray{
    _textArray=textArray;
    
    if (textArray.count>1) {
        self.label1.text=self.textArray[self.index];
        self.label2.text=self.textArray[self.index+1];
        self.index=1;
        [self addTimer];
    }
    if (textArray.count==1) {
        self.label1.text=self.textArray[self.index];
    }
}
-(void)reloadData{
    self.textArray=self.textArray;
}
-(void)beginTimer{
    if(self.timer == nil){
        [self addTimer];
        return;
    }
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate date]];
    }
}

-(void)pauseTimer{
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}
/**
 *  添加定时器
 */
-(void)addTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    
    self.timer=timer;
}

-(void)timerAction{
    
    [UIView animateWithDuration:1 animations:^{
        self.label1.y -= 40;
        self.label2.y -= 40;
    } completion:^(BOOL finished) {
        
        if (self.label1.y<=-40) {
            self.label1.y=40;
        }
        if (self.label2.y<=-40) {
            self.label2.y=40;
        }
        if (self.label3.y<=-40) {
            self.label3.y=80;
        }
        if (self.label1.y==0) {
            self.index++;
            if (self.index >=self.textArray.count) {
                self.index=0;
                self.label2.text=self.textArray[0];
                self.currentIndex=0;
            }else{
                self.label2.text=self.textArray[self.index];
                self.currentIndex=self.index;
            }
        }
        if (self.label2.y==0) {
            self.index++;
            if (self.index >=self.textArray.count) {
                self.index=0;
                self.label1.text=self.textArray[0];
                self.currentIndex=0;
            }else{
                self.label1.text=self.textArray[self.index];
                self.currentIndex=self.index;
            }
        }
    }];
}
-(void)dealloc{
    [self.timer invalidate];
}

@end
