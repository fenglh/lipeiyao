//
//  MySQLManager.h
//  RFIDAPP
//
//  Created by fenglh on 2018/4/24.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabelModel.h"
typedef void(^Callback)(BOOL success);




//数据库管理类
@interface MySQLManager : NSObject

@property (nonatomic,readonly, assign) BOOL connected; ///< 是否已经连接到数据库



//单例
+ (instancetype)shareInstance;

//连接数据库
- (void)connetctMySQL;//同步连接方法
- (void)connetctMySQL:(Callback)callback;//异步连接方法

//插入数据,注：param的key必须和表中的key一致,否则会插入失败。
/*
    NSDictionary *param =@{@"real_name":@"李菲菲",
    @"mobile":@"13800138000",
    @"user_name":@"lifeifei",
    @"user_pwd":@"123456",
    @"user_school_id":@"52018812",
    @"label_code":@"a123"
    }
 */


//检查登录
- (void)checkLoginWithUserName:(NSString *)userName pwd:(NSString *)pwd callback:(void(^)(BOOL success, NSString *errMsg))callback;
//检查用户名对应的手机号码是否存在
- (BOOL )checkMobileExist:(NSString *)mobile userName:(NSString *)userName;
//检查用户名是否存在
- (BOOL )checkUserNameExist:(NSString *)userName;
//获取短信验证码
- (NSString *)getVerificationCode:(NSString *)mobile;
//重置密码
- (BOOL)resetPassword:(NSString *)userName pwd:(NSString *)pwd;
//添加标签
- (BOOL)addLabel:(NSString *)labelId userName:(NSString *)userName desc:(NSString *)desc;
//检查标签是否已经存在
- (BOOL)checkLabelExist:(NSString *)labelId userName:(NSString *)userName;
//查询所有的标签
- (void)getAllLabels:(void(^)(NSArray <LabelModel *> *list, NSString *errMsg))callback;
//搜索标签
- (NSArray <LabelModel *> *)searchLabel:(NSString *)searchContent ;
//删除标签
- (BOOL)deleteLabel:(NSString *)labelId userName:(NSString *)userName ;

@end
