//
//  AwRollLabel.h
//  YFRollingLabel
//
//  Created by yelin on 16/6/25.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AwRollTapBlock)(NSInteger index);
@interface AwRollLabel : UIView
/** 滚动的文字,NSString */
@property (nonatomic, copy) NSArray *textArray;
/** 文字点击事件 */
@property (nonatomic, copy) AwRollTapBlock tapBlock;

/** 开始滚动 */
-(void)beginTimer;
/** 暂停滚动 */
-(void)pauseTimer;
/** 停止滚动 */
-(void)stopTimer;
/** 重置 */
-(void)reloadData;
@end
