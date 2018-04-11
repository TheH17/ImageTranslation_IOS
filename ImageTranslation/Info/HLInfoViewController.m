//
//  HLInfoViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLInfoViewController.h"
#import <PureLayout/PureLayout.h>
#import "hitViewController.h"
#import "HLInfoCellData.h"
#import "downViewController.h"

@interface HLInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<HLInfoCellData *> *dataArray;

@end

@implementation HLInfoViewController

- (NSArray<HLInfoCellData *> *)dataArray {
    if (!_dataArray) {
        [self loadData];
    }
    return _dataArray;
}

- (void)loadData {
    HLInfoCellData *d1 = ({
        HLInfoCellData *d = [HLInfoCellData cellDataWithTitle:@"昵称" image:@"" actionBlock:nil];
        d;
    });
    HLInfoCellData *d2 = ({
        HLInfoCellData *d = [HLInfoCellData cellDataWithTitle:@"电话" image:@"" actionBlock:nil];
        d;
    });
    HLInfoCellData *d3 = ({
        HLInfoCellData *d = [HLInfoCellData cellDataWithTitle:@"浏览历史" image:@"" actionBlock:nil];
        d;
    });
    HLInfoCellData *d4 = ({
        HLInfoCellData *d = [HLInfoCellData cellDataWithTitle:@"清空下载" image:@"" actionBlock:nil];
        d;
    });
    _dataArray = @[d1,d2,d3,d4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(changeInfo)];
//    [self loadSubviews];
    
}
- (IBAction)t1:(id)sender {
    
    
    [self.navigationController pushViewController:[hitViewController new] animated:YES];
}
- (IBAction)t2:(id)sender {
    [self.navigationController pushViewController:[downViewController new] animated:YES];
}

- (void)loadSubviews {
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdges];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)changeInfo {
    
}

#pragma mark - datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoViewCell"];
    }
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row].ImageName];
    cell.textLabel.text = _dataArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray[indexPath.row].actionBlock) {
        _dataArray[indexPath.row].actionBlock();
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
