//
//  LooseItemsAuditVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "LooseItemsAuditVC.h"
#import "LooseItemObject.h"

@interface LooseItemsAuditVC () {
    NSMutableArray *looseItems;
}

@end

@implementation LooseItemsAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    
    looseItems = [[NSMutableArray alloc]init];
    
    LooseItemObject *looseItem = [[LooseItemObject alloc] initWithLooseItem:@"None" andDescription:@"Sterile Item 1" andQuantity:@"4"];
    
    for (int i = 0; i < 10; i++) {
        [looseItems addObject:looseItem];
    }
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 处理可重新创建的任何资源.
}

- (void)initUI {
    [commonUtils setFontSizeLabel:self.titleLabel];

    
    [commonUtils setFontSizeTextField:self.barcodeNumberText];
    [commonUtils setFontSizeTextField:self.itemDescriptionText];
    [commonUtils setFontSizeTextField:self.quantityText];
    
    [commonUtils setRoundedRectBorderButton:self.addButton withBorderRadius:self.addButton.frame.size.height/8];
    
}


- (IBAction)add:(id)sender {
}


- (IBAction)cancel:(id)sender {
    [self popViewController];
}

- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

//    UITableView 代表
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return looseItems.count;
}


@end
