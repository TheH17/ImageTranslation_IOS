//
//  HLRegisterViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 09/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLRegisterViewController.h"
#import <PureLayout/PureLayout.h>
#import <AFNetworking/AFNetworking.h>

@interface HLRegisterViewController ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITextField *name;

@property (nonatomic, strong) UITextField *check;

@property (nonatomic, strong) UITextField *pass;

@property (nonatomic, strong) UITextField *pass1;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *cBtn;

@property (nonatomic, strong) UIButton *rBtn;

@property (nonatomic, strong) UIView *l1;

@property (nonatomic, strong) UIView *l2;

@property (nonatomic, strong) UIView *l3;

@end

@implementation HLRegisterViewController

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
        label.text = @"欢迎注册账号";
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
        textField.layer.borderWidth = 0;
        textField.placeholder = @"   请输入手机号";
        textField;
    });
    
    _l1 = [UIView new];
    _l1.backgroundColor = [UIColor grayColor];
    
    _check = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.layer.borderWidth = 0;
        textField.placeholder = @"   请输入验证码";
        textField.secureTextEntry = YES;
        textField;
    });
    _l2 = [UIView new];
    _l2.backgroundColor = [UIColor grayColor];
    
    _pass = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.layer.borderWidth = 0;
        textField.placeholder = @"   请输入密码";
        textField.secureTextEntry = YES;
        textField;
    });
    _l3 = [UIView new];
    _l3.backgroundColor = [UIColor grayColor];
    
    _pass1 = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.layer.borderWidth = 0;
        textField.placeholder = @"   请再次输入密码";
        textField.secureTextEntry = YES;
        textField;
    });
    
    _btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(re) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    _cBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitle:@"已发送" forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(getC) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn;
    });
    
    _rBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tologin) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0;
        btn;
    });
    
    
    [@[_label, _name, _pass, _pass1, _check, _btn, _rBtn, _l1,_l2,_l3,_cBtn] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
    }];
}

- (void)layoutUI {
    [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_label autoSetDimension:ALDimensionHeight toSize:80];
    
    [_name autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_label withOffset:50];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_name autoSetDimension:ALDimensionHeight toSize:50];
    
    [_l1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_l1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_l1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_name withOffset:2];
    [_l1 autoSetDimension:ALDimensionHeight toSize:1];
    
    [_check autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_l1 withOffset:2];
    [_check autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_check autoSetDimensionsToSize:CGSizeMake(250, 50)];
    
    [_cBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_check withOffset:5];
    [_cBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_check withOffset:-5];
    [_cBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_check withOffset:20];
    [_cBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    [_l2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_l2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_l2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_check withOffset:2];
    [_l2 autoSetDimension:ALDimensionHeight toSize:1];
    
    [_pass autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_l2 withOffset:2];
    [_pass autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_pass autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_pass autoSetDimension:ALDimensionHeight toSize:50];
    
    [_l3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_l3 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_l3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pass withOffset:2];
    [_l3 autoSetDimension:ALDimensionHeight toSize:1];
    
    [_pass1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_l3 withOffset:2];
    [_pass1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_pass1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_pass1 autoSetDimension:ALDimensionHeight toSize:50];
    
    [_btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pass1 withOffset:80];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [_btn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_btn autoSetDimension:ALDimensionHeight toSize:50];
    
    [_rBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_btn withOffset:20];
    [_rBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_btn];
    [_rBtn autoSetDimensionsToSize:CGSizeMake(160, 25)];
}

- (void)tap {
    [_name resignFirstResponder];
    [_check resignFirstResponder];
    [_pass resignFirstResponder];
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

- (void)re {
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
    if (![_pass1.text isEqualToString:_pass.text]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不一致" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = _name.text;
    dict[@"password"] = _pass.text;
    
    NSString *url = @"http://47.106.89.134:8080/registration";
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"注册成功，请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self tologin];
            }]];
            [self presentViewController:vc animated:YES completion:nil];
        }else {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"注册失败" message:responseObject[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"网络错误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)getC {
//    _cBtn.enabled = NO;
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您好，短信验证服务错误，请直接注册，该错误会在短期内修复" preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tologin {
    [self dismissViewControllerAnimated:YES completion:nil];
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
