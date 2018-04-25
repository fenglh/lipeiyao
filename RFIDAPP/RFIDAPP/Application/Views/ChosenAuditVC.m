//
//  ChosenAuditVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/3/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "ChosenAuditVC.h"
#import "FeSet.h"
#import "FeSetCell.h"

@interface ChosenAuditVC () {
    NSMutableArray *feSets;
}

@end

@implementation ChosenAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 处理可重新创建的任何资源.
}

- (void)initUI {
    [commonUtils setFontSizeButton:self.addNoteButton];
    
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    
//    TableView
    self.feSetTable.delegate = self;
    self.feSetTable.dataSource = self;
    
    feSets = [[NSMutableArray alloc]init];
    
    FeSet *feset = [[FeSet alloc] initWithFeSet:@"aaa" andFeSet:@"bbb" andItemDescription:@"ccc"];
    
    for (int i = 0; i < 15; i++) {
        [feSets addObject:feset];
    }
}

- (IBAction)pushToManualAuditVC:(id)sender {
    ManualAuditVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ManualAuditVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (IBAction)completeUpload:(id)sender {
    [self popViewController];
}

- (IBAction)complete:(id)sender {
    [self popViewController];
}

- (IBAction)cancel:(id)sender {
    [self popViewController];    
}

- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

//    UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feSets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *feSetCellIdentifier = @"FeSetCell";
    
    FeSetCell *cell = (FeSetCell *)[tableView dequeueReusableCellWithIdentifier:feSetCellIdentifier];
    
    FeSet *feSet = [feSets objectAtIndex:indexPath.row];
    
    [cell.rfidNumberLabel setText:[NSString stringWithString:feSet.rfidNumber]];
    [cell.feSetLabel setText:[NSString stringWithString:feSet.feSet]];
    [cell.descriptionLabel setText:[NSString stringWithString:feSet.itemDescription]];
    
    return cell;
}

@end
