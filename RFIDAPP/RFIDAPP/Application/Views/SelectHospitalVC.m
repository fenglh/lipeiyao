//
//  SelectHospitalVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "SelectHospitalVC.h"
#import "HospitalCell.h"

@interface SelectHospitalVC () {
    NSMutableArray *hospitalNames;
}

@end

@implementation SelectHospitalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    hospitalNames = [[NSMutableArray alloc]init];

    [hospitalNames addObject:@"Steven Press DDS"];
    [hospitalNames addObject:@"Kaiser Santa Rosa"];
    [hospitalNames addObject:@"Palm Drive Hospital"];
    [hospitalNames addObject:@"David M Malin DDS"];
    [hospitalNames addObject:@"Cookeville Surgery Center"];

    
    self.hospitalTable.delegate = self;
    self.hospitalTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) initUI {
    //    Gradient Background
    [commonUtils setGradient:self.mainContainerView startColor:RGBA(99, 99, 99, 1) endColor:RGBA(35, 71, 95, 1)];

    //    Change Font Size
    [commonUtils setFontSizeLabel:self.titleLabel];
    
}

//    UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return hospitalNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *hospitalTableIdentifier = @"HospitalCell";
    
    HospitalCell *cell = (HospitalCell *)[tableView dequeueReusableCellWithIdentifier:hospitalTableIdentifier];
    
    NSString *hospitalName = [hospitalNames objectAtIndex:indexPath.row];
    
    [cell.hospitalNameLabel setText:[NSString stringWithFormat:@"   %@", hospitalName]];
    [cell.hospitalNameLabel setBackgroundColor:RGBA(180, 199, 231, 1)];
    [cell.hospitalNameLabel.layer setBorderColor:RGBA(170, 170, 170, 1).CGColor];
    [cell.hospitalNameLabel.layer setBorderWidth:1.0];
    [commonUtils setRoundedRectBorderLabel:cell.hospitalNameLabel withBorderRadius:cell.hospitalNameLabel.frame.size.height/5];
   
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HospitalCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.hospitalNameLabel.layer setBorderColor:RGBA(0, 0, 0, 1).CGColor];
    [cell.hospitalNameLabel setBackgroundColor:RGBA(90, 155, 213, 1)];
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.hospitalNameLabel setBackgroundColor:RGBA(180, 199, 231, 1)];
    [cell.hospitalNameLabel.layer setBorderColor:RGBA(170, 170, 170, 1).CGColor];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AuditTypeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AuditTypeVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];

}

@end
