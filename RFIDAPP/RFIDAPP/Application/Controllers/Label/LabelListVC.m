//
//  LabelListVC.m
//  RFIDAPP
//
//  Created by fenglh on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "LabelListVC.h"
#import "LabelTableViewCell.h"
#import "LabelModel.h"
#import "LoginVC.h"
@interface LabelListVC ()<UITabBarDelegate , UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *list; ///< 标签列表
@end

@implementation LabelListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list = [[[MySQLManager shareInstance] getAllLabels] mutableCopy];
    //取出多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //每次界面出现都刷新数据
    self.list = [[[MySQLManager shareInstance] getAllLabels] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - 设置UI







#pragma mark - 私有方法

#pragma mark - 公有方法

#pragma mark - tableView 相关

//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    LabelModel *model = self.list[indexPath.row];
    
    cell.labelUser.text = model.labelUser;
    cell.labelId.text = model.labelId;
    cell.labelDesc.text = model.LabelDesc;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//允许侧滑删除
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//点击删除的实现。特别提醒：必须要先删除了数据，才能再执行删除的动画或者其他操作，不然会引起崩溃。
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelModel *model = self.list[indexPath.row];
    
    //删除远程数据
    BOOL success = [[MySQLManager shareInstance] deleteLabel:model.labelId userName:model.labelUser];
    if (success) {
        //删除本地数据
        [self.list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [BMShowHUD showError:@"删除失败"];
    }

}

//设置编辑的样式

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//设置文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
    
}

#pragma mark - delegate 相关
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"SearchButton");
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
}

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消");
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

//搜索内容发生变化
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *inputStr = searchText;
    [self.list removeAllObjects];
    self.list = [[[MySQLManager shareInstance] searchLabel:inputStr] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - 事件响应

- (IBAction)logoutBtnOnClick:(id)sender {
    
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取Main.storyboard中的第2个视图
    LoginVC *vc = [mainStory instantiateViewControllerWithIdentifier:@"LoginVC"];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [BMShowHUD showSuccess:@"登出成功"];
}


@end
