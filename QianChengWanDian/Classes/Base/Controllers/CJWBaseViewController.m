//
//  CJWBaseViewController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWBaseViewController.h"

@interface CJWBaseViewController ()

@end

@implementation CJWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
