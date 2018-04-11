//
//  HLInferenceViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLInferenceViewController.h"
#import <PureLayout/PureLayout.h>
#import "MainViewController.h"

@interface HLInferenceViewController ()

@property (nonatomic, strong) UIButton *onlineBtn;

@property (nonatomic, strong) UIButton *offlineBtn;

@end

@implementation HLInferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self loadSubViews];
    [self layoutUI];
}

- (void)loadSubViews {
    _onlineBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"在线体验" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(main:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    _offlineBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"离线体验" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(main:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    [@[_onlineBtn, _offlineBtn] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
    }];
}

- (void)layoutUI {
    [_onlineBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:300];
    [_onlineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_onlineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_onlineBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_offlineBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_onlineBtn withOffset:50];
    [_offlineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_offlineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_offlineBtn autoSetDimension:ALDimensionHeight toSize:50];
}

- (void)main:(UIButton *)sender{
    MainViewController *vc = [MainViewController new];
    [vc online:[sender.titleLabel.text isEqualToString:@"在线体验"]];
    [self.navigationController pushViewController:vc animated:YES];
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
