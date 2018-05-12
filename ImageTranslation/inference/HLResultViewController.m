//
//  HLResultViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 2018/5/12.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLResultViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HLResultViewController ()

@property (nonatomic, strong) UIImageView *img;

@end

@implementation HLResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    _img = [[UIImageView alloc]init];
    _img.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    _img.center = self.view.center;
    [self.view addSubview:_img];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.view addGestureRecognizer:tap];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setImage:(UIImage *)img {
    [_img setImage:img];
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
