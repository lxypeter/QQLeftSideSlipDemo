//
//  LeftSideViewController.m
//  QQLeftSideSlipDemo
//
//  Created by Peter Lee on 16/8/16.
//  Copyright © 2016年 CY.Lee. All rights reserved.
//

#import "LeftSideViewController.h"

@implementation LeftSideViewOption

@end

@interface LeftSideViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *optionArray;

@end

@implementation LeftSideViewController

#pragma mark - lazy load
- (NSArray *)optionArray{
    if (!_optionArray) {
        //伪数据
        _optionArray = @[@"开通会员",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件",@"我的名片夹"];
    }
    return _optionArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSubViews];
}

- (void)configureSubViews{
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headerImageView.layer.borderWidth = 2;
}

#pragma mark - delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.optionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"optionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.optionArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"qq"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //伪数据
    LeftSideViewOption *option = [[LeftSideViewOption alloc]init];
    option.title = self.optionArray[indexPath.row];
    option.className = @"UIViewController";
    if (self.leftSideOptionBlock) {
        self.leftSideOptionBlock(option);
    }
}

@end
