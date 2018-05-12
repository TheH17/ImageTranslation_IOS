//
//  MainViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 08/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "MainViewController.h"
#import <PureLayout/PureLayout.h>
#import "HLInferenceTool.h"
#import "WorkSpaceViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MainViewController ()

@property (nonatomic, strong) UIButton *photo2picBtn;

@property (nonatomic, strong) UIButton *facadeBtn;

@property (nonatomic, strong) UIButton *cityscapeBtn;

@property (nonatomic, strong) UIButton *shoeBtn;

@property (nonatomic, assign) BOOL online;

//@property (nonatomic, strong) UIView *pV;
//@property (nonatomic, strong) UIProgressView *v;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"模型选择";
    [self loadSubViews];
    [self layoutUI];
}

- (void)online:(BOOL)flag {
    _online = flag;
}

- (void)loadSubViews {
    _photo2picBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"风景图转绘画" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(photo2pic) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    _facadeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"建筑表面转真实建筑" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(facade) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    _cityscapeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"城市绘画图转真实照片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cityscape) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    _shoeBtn =  ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"边缘生产鞋类照片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shoe) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
//    _pV = [UIView new];
//    _pV.layer.borderColor = [UIColor blackColor].CGColor;
//    _pV.layer.borderWidth = 1;
//    _pV.backgroundColor = [UIColor whiteColor];
//
//    UIProgressView *v = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    v.tintColor = [UIColor blueColor];
//    v.trackTintColor = [UIColor grayColor];
//
//    v.layer.masksToBounds = YES;
//    v.layer.cornerRadius = 1;
//    [_pV addSubview:v];
//    _v = v;
//
//    [v setProgress:0.3];
    
    [@[_photo2picBtn, _facadeBtn, _cityscapeBtn, _shoeBtn] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
    }];
}

- (void)layoutUI {
    [_photo2picBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:200];
    [_photo2picBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_photo2picBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_photo2picBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_facadeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_photo2picBtn withOffset:50];
    [_facadeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_facadeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_facadeBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_cityscapeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_facadeBtn withOffset:50];
    [_cityscapeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_cityscapeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_cityscapeBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_shoeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityscapeBtn withOffset:50];
    [_shoeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_shoeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_shoeBtn autoSetDimension:ALDimensionHeight toSize:50];
    
//    [_pV autoCenterInSuperview];
//    [_pV autoSetDimensionsToSize:CGSizeMake(300, 100)];
//
//
//
//    UILabel *label = ({
//        UILabel *label = [UILabel new];
//        label.text = @"正在下载，请稍候";
//        label.font = [UIFont systemFontOfSize:20];
//        label.numberOfLines = 2;
//        label.textColor = [UIColor blackColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [label sizeToFit];
//        label;
//    });
//    [_pV addSubview:label];
//
//    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
//
//    [_v autoAlignAxisToSuperviewAxis:ALAxisVertical];
//
//    [_v autoSetDimensionsToSize:CGSizeMake(250, 3)];
//    [_v autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label withOffset:30];
}

- (void)photo2pic {
    if (_online) {
        WorkSpaceViewController *vc = [WorkSpaceViewController new];
        [vc setModelName:@"photo2pic"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (![HLInferenceTool hasModeOffline:@"photo2pic"]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您本地没有下载预测模型，是否进行下载？" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self download:@"photo2pic"];
            }]];
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
    
}

- (void)cityscape {
    if (_online) {
        WorkSpaceViewController *vc = [WorkSpaceViewController new];
        [vc setModelName:@"cityscape"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (![HLInferenceTool hasModeOffline:@"cityscape"]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您本地没有下载预测模型，是否进行下载？" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self download:@"cityscape"];
            }]];
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void)facade {
    if (_online) {
        WorkSpaceViewController *vc = [WorkSpaceViewController new];
        [vc setModelName:@"facade"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (![HLInferenceTool hasModeOffline:@"facade"]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您本地没有下载预测模型，是否进行下载？" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self download:@"facade"];
            }]];
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void)shoe {
    if (_online) {
        WorkSpaceViewController *vc = [WorkSpaceViewController new];
        [vc setModelName:@"shoe"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (![HLInferenceTool hasModeOffline:@"shoe"]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您本地没有下载预测模型，是否进行下载？" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self download:@"shoe"];
            }]];
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void)download:(NSString *)name {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"正在下载，请稍后";
    hud.margin = 10;
    hud.offset = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/3);
    hud.removeFromSuperViewOnHide = YES;
    [HLInferenceTool downloadMode:name success:^(NSString *status, NSString *message) {
        [hud hideAnimated:YES afterDelay:0.5];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"下载完成" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
        _online = YES;
    } failure:^(NSError *error) {
        [hud hideAnimated:YES afterDelay:0.5];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"下载失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }];
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
