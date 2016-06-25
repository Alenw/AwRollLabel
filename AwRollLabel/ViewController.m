//
//  ViewController.m
//  AwRollLabel
//
//  Created by yelin on 16/6/25.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "ViewController.h"
#import "AwRollLabel.h"

@interface ViewController ()
@property (nonatomic, weak) AwRollLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AwRollLabel *label=[[AwRollLabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    label.textArray=@[@"我是label1",@"我是label2",@"我是label3",@"我是label4"];
    [self.view addSubview:label];
    label.backgroundColor=[UIColor orangeColor];
    label.tapBlock=^(NSInteger index){
        NSLog(@"index==%ld",index);
    };
    
    //Timer Control & Property Changed
    NSArray *array = @[@"Timer Start",@"Timer Pause",@"Timer Stop"/*,@"openAPPStore"*/];
    for (int i = 0; i < array.count ; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:
                         CGRectMake(50,CGRectGetMaxY(label.frame) + i * 50 + 100, self.view.frame.size.width - 100, 40)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blueColor]];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
    }
    self.label=label;
    
    
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner2"]];
    imageV.frame=CGRectMake(0, self.view.frame.size.height-150, self.view.frame.size.width, 150);
    [self.view addSubview:imageV];
}
-(void)buttonAction:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [_label beginTimer];
            break;
        case 1:
            [_label pauseTimer];
            break;
        case 2:
            [_label stopTimer];
            break;
        case 3:{
            
        
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
