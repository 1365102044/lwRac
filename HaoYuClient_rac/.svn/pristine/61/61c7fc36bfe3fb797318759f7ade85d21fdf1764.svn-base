//
//  HYMineInformationViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineInformationViewController.h"
#import "HYMineInformationView.h"
#import "HYBaseTableView.h"
#import "HYMineInformationView.h"
#import "HYBaseBarButtonItem.h"
#import "LWImagePicker.h"
#import "HYAboutUsViewController.h"
#import "HYWraingAlert.h"
#import "HYBaseBarButtonItem.h"
#import "LWHud.h"
#import "LWUpdatePassWordViewController.h"
#import "LWValidatePhoneViewController.h"
#import "LWInputNewPhoneViewController.h"
@interface HYMineInformationViewController ()<MineInforDelegate>
@property (nonatomic, strong)  HYMineInformationView * inforMainView;
@property (nonatomic, strong) HYFillLongButton * loginOutBtn;
@property (nonatomic, strong) NSString * currenIcon_URL;
@property (nonatomic, strong) UIImage * currentIcon;

@end

@implementation HYMineInformationViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
/**
 返回时，如果有修改再上传服务器
 */
- (void)uploadInfor:(NSMutableDictionary *)info
{
    [info setValue:[USERDEFAULTS_GET(USER_INFOR_USERID) isNullToString] forKey:@"userId"];
    [info setValue:[USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString] forKey:@"phone"];
    [[HYServiceManager share] postRequestWithurl:UPLOAD_USERINFOR_URL
                                       paramters:info
                                    successBlock:^(id objc, id requestInfo) {
                                        if (info[@"petName"]) {
                                            USERDEFAULTS_SET(info[@"petName"], USER_INFOR_NAME);
                                        }
                                        if (info[@"sign"]) {
                                            USERDEFAULTS_SET([HYStringTool checkString:[info[@"sign"] ex_base64Decode]], USER_INFOR_QIANMING);
                                        }
                                        if (info[@"phone"]) {
                                            USERDEFAULTS_SET(info[@"phone"], USER_INFOR_PHONE);
                                        }
                                        if (info[@"email"]) {
                                            USERDEFAULTS_SET(info[@"email"], USER_INFOR_MAIL);
                                        }
                                        if (_currenIcon_URL) {
                                            USERDEFAULTS_SET(_currenIcon_URL, USER_INFOR_HEADERICON_URL);
                                            [[HYUserInfor_LocalData share] saveUser_Headericon_Local:_currentIcon];
                                            [SYSTEM_USERDEFAULTS synchronize];
                                            if (self.callBackBlock) {
                                                self.callBackBlock(_currentIcon);
                                            }
                                        }
//                                        NSString *decode = [info[@"sign"] ex_base64Decode];
//                                        [info setObject:decode forKey:@"sign"];
                                        POST_NOTI(@"CHANGEINFOR_NOTI", info);
                                        [SYSTEM_USERDEFAULTS synchronize];
                                        _currenIcon_URL = nil;
                                        ALERT(@"信息修改成功！");
                                        [self.navigationController popViewControllerAnimated:YES];
                                    } failureBlock:^(id error, id requestInfo) {
                                        ALERT(@"修改信息失败！");
                                    }];
}

/**
 查看本地内容是否被修改过 之后上传服务器
 */
- (NSMutableDictionary *)checkInfor
{
    [LWHud dismiss];
    [self.view endEditing:YES];
    
    PARA_CREART;
    if (![self.inforMainView.userNameView.rightTextField.text isEqualToString:USERDEFAULTS_GET(USER_INFOR_NAME)]) {
        PARA_SET(self.inforMainView.userNameView.rightTextField.text, @"petName");
    }
    if (![self.inforMainView.qianMingView.rightTextField.text isEqualToString:USERDEFAULTS_GET(USER_INFOR_QIANMING)]) {
        NSString *encode = [self.inforMainView.qianMingView.rightTextField.text ex_base64Encode];
        PARA_SET(encode, @"sign");
    }
//    if (![self.inforMainView.phoneView.rightLable.text isEqualToString:USERDEFAULTS_GET(USER_INFOR_PHONE)]) {
//        PARA_SET(self.inforMainView.phoneView.rightLable.text, @"phone");
//    }
    if (![self.inforMainView.mailView.rightTextField.text isEqualToString:USERDEFAULTS_GET(USER_INFOR_MAIL)]) {
        PARA_SET(self.inforMainView.mailView.rightTextField.text, @"email");
    }
    if (_currenIcon_URL) {
        PARA_SET(_currenIcon_URL, @"avatar");
    }
    if (para.allKeys.count != 0) {
        
        return para;
    }else{
//        ALERT(@"保存成功");
        return nil;
    }
    
}

/**
 退出登录
 */
- (void)clickLoginOut
{
    [HYWraingAlert showAlert:self
                       title:@"确定退出登录？"
                     message:@""
          defaultButtonTitle:@"取消"
           cancelButtonTitle:@"确定"
  defaultButtonCallBackBlock:^(id sender) {
  } cancelButtonCallBackBlock:^(id sender) {
      [[HYUserInfor_LocalData share] LoginOut];
      [self.navigationController popToRootViewControllerAnimated:YES];
  }];
}

/**
 切换头像
 */
- (void)changeHeaderPic
{
    WEAKSELF(self);
    [[LWImagePicker share] imagePickerWithSourceVc:self allowsEditing:YES callBlock:^(id sender) {
        weakself.inforMainView.headerIconView.rightImageView.image = (UIImage *)sender;
        NSArray *imagArr = @[(UIImage *)sender];
        [LWHud show];
        [[HYServiceManager share] uploadImageWithurl:UPLOAD_MINEWEIXIU_IMAGE_URL
                                            ImageArr:imagArr
                                            fileName:@[@"headPic"]
                                          parameters:nil
                                             Success:^(id objc, id requestInfo) {
                                                 [LWHud dismiss];
                                                 _currenIcon_URL = objc[@"url"];
                                                 _currentIcon = (UIImage *)sender;
                                             } fail:^(id error, id requestInfo) {
                                                 [LWHud dismiss];
                                             }];
    }];
}


#pragma mark - Fourth.代理方法
- (void)clearCache {
    //清理
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageCachesPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    //        NSString *NetImageCachesPath = [cachesPath stringByAppendingPathComponent:@"com.bjInborn/fsCachedData"];
    NSFileManager *mgr = [[NSFileManager alloc] init];
    [mgr removeItemAtPath:imageCachesPath error:nil];
    //        [mgr removeItemAtPath:NetImageCachesPath error:nil];
    
    [LWHud showWithStatus:@"缓存清除中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LWHud dismiss];
        self.inforMainView.clearCacheView.rightLable.text = @"0.00M";
    });
}

- (void)handleClickCellView:(NSString *)leftStr {
    [self.view endEditing:YES];
    if ([leftStr isEqualToString:@"头像"]){
        [self  changeHeaderPic];
    }else if ([leftStr isEqualToString:@"用户名"]){
        
    }else if ([leftStr isEqualToString:@"个性签名"]){
        
    }else if ([leftStr isEqualToString:@"手机号"]){
        [self.navigationController pushViewController:[LWInputNewPhoneViewController new] animated:YES];
    }else if ([leftStr isEqualToString:@"邮箱"]){
       
    }else if ([leftStr isEqualToString:@"清理缓存"]){
        [self clearCache];
        
    }else if ([leftStr isEqualToString:@"登录密码"]){
        
    }else if ([leftStr isEqualToString:@"关于我们"]){
        HYAboutUsViewController *aboutus =  [[HYAboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutus animated:YES];
    }else if ([leftStr isEqualToString:@"设置密码"]){
        [self.navigationController pushViewController:[LWUpdatePassWordViewController updatePassWordVCWithExtend:@"1"] animated:YES];
    }else if ([leftStr isEqualToString:@"修改密码"]){
         [self.navigationController pushViewController:[LWUpdatePassWordViewController updatePassWordVCWithExtend:@"2"] animated:YES];
    }
}

#pragma mark - Fifth.视图生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人设置";
    
    [self.MainScrollView addSubview:self.inforMainView];
    [self.view addSubview:self.MainScrollView];
    [self.view addSubview:self.loginOutBtn];
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    [self.inforMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.loginOutBtn.mas_top).mas_offset(-10);
    }];
    
    [self.loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(44));
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(5));
    }];
    
    WEAKSELF(self);
    HYBaseBarButtonItem *rightItem = [HYBaseBarButtonItem barButtonItemWithTitleStringKey:@"保存"
                                                                                 callBack:^(id sender) {
                                                                                     NSMutableDictionary *para = [weakself checkInfor];
                                                                                     if(para){
                                                                                       [weakself uploadInfor:para];
                                                                                   }
                                                                                 }];
    self.navigationItem.rightBarButtonItem = rightItem;
    HYBaseBarButtonItem *leftItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        NSMutableDictionary *para = [weakself checkInfor];
        if(!para){
            [weakself.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        [HYWraingAlert showAlert:self
                           title:@"提示"
                         message:@"有修改的信息尚未保存，是否需要保存？"
              defaultButtonTitle:@"放弃修改"
               cancelButtonTitle:@"保存"
      defaultButtonCallBackBlock:^(id sender) {
          [self.navigationController popViewControllerAnimated:YES];
      } cancelButtonCallBackBlock:^(id sender) {
          [self uploadInfor:para];
      }];
    }];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (HYMineInformationView *)inforMainView
{
    if (!_inforMainView) {
        _inforMainView = [[HYMineInformationView alloc] init];
        _inforMainView.viewController = self;
        _inforMainView.delegate = self;
        WEAKSELF(self);
        _inforMainView.againLogin = ^(id sender) {
            [weakself clickLoginOut];
        };
    }
    return _inforMainView;
}

- (HYFillLongButton*)loginOutBtn
{
    if (!_loginOutBtn) {
        _loginOutBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"退出登录" target:self selector:@selector(clickLoginOut)];
    }
    return _loginOutBtn;
}
#pragma mark - Eigth.Other


@end
