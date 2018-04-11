//
//  HLRelateViewController.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLRelateViewController.h"
#import <PureLayout/PureLayout.h>
#import "HLRelateData.h"
#import "HLRelateContentViewController.h"

@interface HLRelateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<HLRelateData *> *dataArray;

@end

@implementation HLRelateViewController

- (NSArray<HLRelateData *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [HLRelateData dataArray];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    self.title = @"探索";
    [self loadSubviews];
}

- (void)loadSubviews {
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _tableView];
    [_tableView autoPinEdgesToSuperviewEdges];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Relate"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Relate"];
    }
    cell.textLabel.text = _dataArray[indexPath.row].title;
    cell.detailTextLabel.text =_dataArray[indexPath.row].subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"hlrelate" bundle:[NSBundle mainBundle]];
    HLRelateContentViewController *mainViewController = (HLRelateContentViewController*)[storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
//    [self presentViewController:mainViewController animated:YES completion:nil];
//    HLRelateContentViewController *vc = [[HLRelateContentViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
//    [vc setUpWithData:_dataArray[indexPath.row]];
    [self.navigationController pushViewController:mainViewController animated:YES];
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
