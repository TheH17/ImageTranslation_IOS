//
//  HLLoginViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLLoginViewController.h"
#import <PureLayout/PureLayout.h>
#import <AFNetworking/AFNetworking.h>
#import "HLRegisterViewController.h"
#import "HLLoginTool.h"
#import "HLUser.h"
#import "HLUserTool.h"

@interface HLLoginViewController ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITextField *name;

@property (nonatomic, strong) UITextField *pass;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *rBtn;

@property (nonatomic, strong) UIImageView *seV;

@property (nonatomic, strong) UIButton *fBtn;

@end

@implementation HLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
    [self layoutUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)loadSubViews {
    _label = ({
        UILabel *label = [UILabel new];
        label.text = @"欢迎使用图像翻译";
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label;
    });
    
    _name = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.layer.cornerRadius = 3;
        textField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
        imgv.frame = CGRectMake(10, 10, 30, 30);
        textField.leftView = imgv;
        textField.placeholder = @"请输入昵称或手机号";
        textField;
    });
    
    _pass = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.layer.cornerRadius = 3;
        textField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pass"]];
        imgv.frame = CGRectMake(10, 10, 30, 30);
        textField.leftView = imgv;
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        textField;
    });
    
    _btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    _rBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"注册账号" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0;
        btn;
    });
    _seV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
//    _seV.layer.borderWidth = 1;
    _fBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0;
        btn;
    });
    
    [@[_label, _name, _pass, _btn, _rBtn,_seV,_fBtn] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
    }];
}

- (void)layoutUI {
    [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_label autoSetDimension:ALDimensionHeight toSize:80];
    
    [_name autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_label withOffset:50];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_name autoSetDimension:ALDimensionHeight toSize:50];
    
    [_pass autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_name withOffset:30];
    [_pass autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_pass autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_pass autoSetDimension:ALDimensionHeight toSize:50];
    
    [_btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pass withOffset:80];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_btn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_seV autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_seV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:100];
    [_seV autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    [_rBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seV];
    [_rBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_seV withOffset:-30];
    [_rBtn autoSetDimensionsToSize:CGSizeMake(80, 25)];
    
    [_fBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seV];
    [_fBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_seV withOffset:30];
    [_fBtn autoSetDimensionsToSize:CGSizeMake(80, 25)];
}

- (void)tap {
    [_name resignFirstResponder];
    [_pass resignFirstResponder];
}

- (void)keyboardShow:(NSNotification *)noti {
    CGRect rect = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGPoint point = [_btn convertPoint:CGPointZero toView:self.view];
    if ([UIScreen mainScreen].bounds.size.height - rect.size.height < point.y + 55) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect r = self.view.bounds;
            r.origin.y = -[UIScreen mainScreen].bounds.size.height+ rect.size.height + point.y + 55;
            self.view.bounds = r;
        }];
    }
}

- (void)keyboardHide:(NSNotification *)noti {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)login {
    if ([_name.text isEqualToString:@""] || !_name.text) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }
    if ([_pass.text isEqualToString:@""] || !_pass.text) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = _name.text;
    dict[@"password"] = _pass.text;
    
    NSString *url = @"http://47.106.89.134:8080/login";
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            HLUser *u = [HLUser userWithName:_name.text phont:@"135****5093" info:@""];
            [HLUserTool saveUser:u];
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"登录成功" message:responseObject[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [HLLoginTool enterAppWithWindow:[UIApplication sharedApplication].delegate.window];
            }]];
            [self presentViewController:vc animated:YES completion:nil];
        }else {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"登录失败" message:responseObject[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"网络错误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)toRegister {
    HLRegisterViewController *vc = [HLRegisterViewController new];
    [self presentViewController:vc animated:YES completion:nil];
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
