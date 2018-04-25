//
//  HomeVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "HomeVC.h"
#import "Audit.h"
#import "OpenAuditCell.h"

@interface HomeVC () {
    NSMutableArray *openAudits;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    openAudits = [[NSMutableArray alloc]init];
    
    Audit *audit = [[Audit alloc] initWithAudit:@"Stanford med" andStartedDate:@"3/15/2016"];
    
    for (int i = 0; i < 10; i++) {
        [openAudits addObject:audit];
    }

    self.openAuditTable.delegate = self;
    self.openAuditTable.dataSource = self;

    [self initUI];
    
    
}

- (void)initUI {
    [commonUtils setRoundedRectBorderButton:self.createNewAuditButton withBorderRadius:self.createNewAuditButton.frame.size.height/2];
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeButton:self.createNewAuditButton];
}

//    UITableView Delegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return openAudits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *openAuditTableIdentifier = @"OpenAuditCell";
    
    OpenAuditCell *cell = (OpenAuditCell *)[tableView dequeueReusableCellWithIdentifier:openAuditTableIdentifier];
    
    Audit *audit = [openAudits objectAtIndex:indexPath.row];
    
    [cell.hospitalNameLabel setText:[NSString stringWithString:audit.hospitalName]];
    [cell.startedDateLabel setText:[NSString stringWithString:audit.startedDate]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AuditTypeVC *auditTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AuditTypeVC"];
    [self.navigationController pushViewController:auditTypeVC animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}
- (IBAction)pushBlindVC:(id)sender {
    BlindCountVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BlindCountVC"];
    [self.navigationController pushViewController:vc animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}
@end
