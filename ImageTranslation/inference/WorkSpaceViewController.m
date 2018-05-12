//
//  WorkSpaceViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 08/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "WorkSpaceViewController.h"
#import <PureLayout/PureLayout.h>
#import <Photos/Photos.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HLInferenceTool.h"
#import "HLResultViewController.h"

@interface WorkSpaceViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *imgV;

@property (nonatomic, strong) UIImageView *imgV1;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) NSString *modelName;

@property(nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation WorkSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
    [self layoutUI];
}

- (void)loadSubViews {
    
    _label = ({
        UILabel *label = [UILabel new];
        label.text = @"点击图片选择您需要转换的图片";
        label.font = [UIFont systemFontOfSize:20];
        label.numberOfLines = 2;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label;
    });
    [self.view addSubview:_label];
    _imgV = ({
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default"]];
        img.layer.borderWidth = 2;
        img.layer.borderColor = [UIColor grayColor].CGColor;
        img.layer.cornerRadius = 5;
        img.clipsToBounds = YES;
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        [img addGestureRecognizer:tapGesture];
        img.contentMode = UIViewContentModeScaleToFill;
        img;
    });
    
    _imgV1 = ({
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"putputPlace"]];
        img.layer.borderWidth = 2;
        img.layer.borderColor = [UIColor grayColor].CGColor;
        img.layer.cornerRadius = 5;
        img.clipsToBounds = YES;
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRe)];
        [img addGestureRecognizer:tapGesture];
        img.contentMode = UIViewContentModeScaleToFill;
        img;
    });
    _btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"开始转换" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    [self.view addSubview:_btn];
    [self.view addSubview:_imgV];[self.view addSubview:_imgV1];
}

- (void)setModelName:(NSString *)name {
    _modelName = name;
}

- (void)layoutUI {
    [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    
    [_imgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_label withOffset:5];;
    [_imgV autoSetDimensionsToSize:CGSizeMake(256, 256)];
    
    [_imgV1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_imgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:10];;
    [_imgV1 autoSetDimensionsToSize:CGSizeMake(256, 256)];
    
    [_btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV1 withOffset:10];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_btn autoSetDimension:ALDimensionHeight toSize:50];
}

- (void)clickImage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择您希望获取图像的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImage:0];
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"拍照获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImage:1];
    }];
    UIAlertAction *c = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:a1];
    [alert addAction:a2];
    [alert addAction:c];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clickRe {
    HLResultViewController *vc = [HLResultViewController new];
    [vc setImage:_imgV1.image];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)pickImage:(NSInteger)type {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                NSLog(@"PHAuthorizationStatusAuthorized");
                break;
            case PHAuthorizationStatusDenied:
                NSLog(@"PHAuthorizationStatusDenied");
                break;
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"PHAuthorizationStatusNotDetermined");
                break;
            case PHAuthorizationStatusRestricted:
                NSLog(@"PHAuthorizationStatusRestricted");
                break;
        }
    }];
    NSUInteger sourceType = 0;
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        if (type == 0) {
            //相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }else if (type == 1) {
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }else {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    _imgV.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)start {
    if (!_imgV.image || [_imgV.image isEqual:[UIImage imageNamed:@"default"]]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没选择图片，请先选择图片" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        [HLInferenceTool inferenceOnline:_modelName pic:_imgV.image success:^(NSString *status, NSString *message, NSString *imageUrl) {
            if ([status isEqualToString:@"ok"]) {
                [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            }else {
                UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"转换失败" message:message preferredStyle:UIAlertControllerStyleAlert];
                [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:vc animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"网络错误，请重试" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
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
