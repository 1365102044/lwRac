//
//  WYIDScanViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYIDScanViewController.h"
#import "WYIDCardScaningView.h"
#import "HYFillLongButton.h"
#import "YBIDScanResultAlearView.h"
#import "HYCertifiterRealNameUploadIdCardImageViewController.h"

@interface WYIDScanViewController ()

@property (nonatomic, strong) WYIDCardScaningView *overlayView;

// 摄像头设备
@property (nonatomic,strong) AVCaptureDevice *device;

// 是否打开手电筒
@property (nonatomic,assign,getter = isTorchOn) BOOL torchOn;

/** 证件扫描类型 */
@property (nonatomic, assign) CardType cardInfo;

/**
 下一步
 */
@property (nonatomic, strong) HYFillLongButton *nextBtn ;
/**
 重拍
 */
@property (nonatomic, strong) HYDefaultButton * againScanBtn;
/**
 关闭
 */
@property (nonatomic, strong) HYDefaultButton * colseBtn;
/**
 扫描结果提示
 */
@property (nonatomic, strong) YBIDScanResultAlearView * scanResultView;

/**
 识别到的时间
 */
@property (nonatomic, strong) WYScanResultModel * scanResultModel;

/**
 会掉的block
 */
@property (nonatomic, copy) ScanCarInfo carInfoblock;
@end

@implementation WYIDScanViewController


/** 初始化方法 */
- (instancetype)initWithCarInfo:(CardType)carInfo
{
    self = [super init];
    if (self) {
        self.title = carInfo == CardIDBank ? @"扫描银行卡" : @"扫描身份证";
        self.cardInfo = carInfo;
        [self startOpenCameraInitializationWithType:carInfo];
    }
    return self;
}

/**
 重置 拍摄界面
 */
- (void)updateScanViewController
{
    //    [self.overlayView removeFromSuperview];
    self.title =  @"扫描身份证";
    self.cardInfo = CardIDFront;
    [self startOpenCameraInitializationWithType:CardIDFront];
}

/** 摄像头的初始化*/
- (void)startOpenCameraInitializationWithType:(CardType)cardType
{
    self.cameraManager.sessionPreset = AVCaptureSessionPresetHigh;
    
    //  身份证识别
    if (cardType == CardIDFront || cardType == CardIDDown) {
        
        if ([self.cameraManager configIDScanManager]) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            [self.view insertSubview:view atIndex:0];
            AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
            preLayer.frame = [UIScreen mainScreen].bounds;
            
            preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [view.layer addSublayer:preLayer];
            
            //  加载扫描试图
            WYIDCardScaningView *overlayView = [[WYIDCardScaningView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _overlayView = overlayView;
            if (cardType == CardIDFront) {
                [overlayView scaningCardIDWithType:ScaningCardIDWithFront];
            }
            else if (cardType == CardIDDown)
            {
                [overlayView scaningCardIDWithType:ScaningCardIDWithDown];
            }
            [self.view addSubview:overlayView];
            [self.view bringSubviewToFront:overlayView];
            
        }
        else {
            NSLog(@"无法打开相机");
        }
    }
    
    //  银行卡识别
    else if (cardType == CardIDBank)
    {
        if ([self.cameraManager configBankScanManager]) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            [self.view insertSubview:view atIndex:0];
            AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
            preLayer.frame = [UIScreen mainScreen].bounds;
            
            preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [view.layer addSublayer:preLayer];
            
            
            //  加载扫描试图
            WYIDCardScaningView *overlayView = [[WYIDCardScaningView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [overlayView scaningCardIDWithType:ScaningCardIDWithBank];
            [self.view addSubview:overlayView];
            [self.view bringSubviewToFront:overlayView];
        }
        else {
            NSLog(@"打开相机失败");
        }
    }
    
    [self addFunctionBtn];
    
}

/**
 添加按钮
 */
- (void)addFunctionBtn
{
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(74), ADJUST_PERCENT_FLOAT(36)));
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(35));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(16));
    }];
    self.nextBtn.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    [self.view addSubview:self.againScanBtn];
    [self.againScanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(74), ADJUST_PERCENT_FLOAT(36)));
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(19));
        make.centerY.mas_equalTo(self.nextBtn.mas_centerY);
    }];
    self.againScanBtn.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    [self.view addSubview:self.colseBtn];
    [self.colseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(28), ADJUST_PERCENT_FLOAT(28)));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(23));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(56));
    }];
    
    self.nextBtn.hidden = YES;
    self.againScanBtn.hidden = YES;
}

-(void)dealloc
{
    NSLog(@"%s dealloc",object_getClassName(self));
}

/** 扫描完成 */
- (void)scanDidFinishCarInfo:(ScanCarInfo)carInfo
{
    //  正面
    if (self.cardInfo == CardIDFront) {
        [self.cameraManager.idCardScanSuccess subscribeNext:^(id result)
         {
             WYScanResultModel *model = (WYScanResultModel *)result;
             if (model.name)
             {
                 self.scanResultModel  = model;
                 //把正面的图片保存在frontimage内，避免被覆盖
                 self.scanResultModel.frontImage = model.idImage;
                 self.scanResultModel.idImage = nil;
                 carInfo(CardIDFront, _scanResultModel);
                 
//                 carInfo(CardIDDown, _scanResultModel);
                 [self showAlearView];
                 self.nextBtn.hidden = NO;
                 self.againScanBtn.hidden = NO;
//                 [self postNotiModel];
             }else{
                 [self showAlearView];
                 self.againScanBtn.hidden = NO;
                 self.scanResultView.titlelable.text = @"识别信息失败";
             }
         }];
    }
    //  反面
    else if (self.cardInfo == CardIDDown) {
        [self.cameraManager.idCardScanSuccess subscribeNext:^(id result)
         {
             WYScanResultModel *model = (WYScanResultModel *)result;
             if (model.valid || model.issue)
             {
                 [self handldscanmodelToSelfmodel:model];
//                 carInfo(CardIDDown, _scanResultModel);
                 [self clickColseBtn];
                 [self postNotiModel];
             }else{
                 //未能识别到背面信息
                 [self showAlearView];
                 self.againScanBtn.hidden = NO;
                 self.scanResultView.titlelable.text = @"识别信息失败";
             }
         }];
    }
    
    //  银行卡
    else if (self.cardInfo == CardIDBank)
    {
        [self.cameraManager.bankScanSuccess subscribeNext:^(id result)
         {
             
             WYScanResultModel *model = (WYScanResultModel *)result;
             carInfo(CardIDBank, model);
         }];
    }
    [self.cameraManager.scanError subscribeNext:^(id x) {
        // 扫描失败的提醒
    }];
}

- (void)showAlearView
{
    [self.view addSubview:self.scanResultView];
    self.scanResultView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    [self.scanResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(130), ADJUST_PERCENT_FLOAT(130)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

- (void)dismiassAlearView
{
    [self.scanResultView removeAllSubviews];
    [self.scanResultView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //  开灯按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开灯" style:UIBarButtonItemStylePlain target:self action:@selector(openLights)];
}

/** 开关灯 */
- (void)openLights
{
    [self turnOnOrOffTorch];
}
#pragma mark - 打开／关闭手电筒
-(void)turnOnOrOffTorch
{
    self.torchOn = !self.isTorchOn;
    
    if ([self.device hasTorch]){ // 判断是否有闪光灯
        [self.device lockForConfiguration:nil];// 请求独占访问硬件设备
        
        if (self.isTorchOn) {
            self.navigationItem.rightBarButtonItem.title = @"关灯";
            [self.device setTorchMode:AVCaptureTorchModeOn];
        } else {
            self.navigationItem.rightBarButtonItem.title = @"开灯";
            [self.device setTorchMode:AVCaptureTorchModeOff];
        }
        [self.device unlockForConfiguration];// 请求解除独占访问硬件设备
    }
    else {
        //初始化AlertView
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的设备没有闪光设备，不能提供手电筒功能!"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}


- (void)postNotiModel
{
    NSMutableDictionary *param  = [[NSMutableDictionary alloc]init];
    param[@"name"] = _scanResultModel.name ? _scanResultModel.name : @"";
    param[@"type"] = @(_scanResultModel.type) ? @(_scanResultModel.type) : @"";
    param[@"code"] = _scanResultModel.code ? _scanResultModel.code : @"";
    param[@"gender"] = _scanResultModel.gender ? _scanResultModel.gender : @"";
    param[@"nation"] = _scanResultModel.nation ? _scanResultModel.nation : @"";
    param[@"address"] = _scanResultModel.address ? _scanResultModel.address : @"";
    param[@"issue"] = _scanResultModel.issue ? _scanResultModel.issue : @"";
    param[@"valid"] = _scanResultModel.valid ? _scanResultModel.valid : @"";
    param[@"idImage"] = _scanResultModel.idImage ? _scanResultModel.idImage : @"";
    param[@"frontImage"] = _scanResultModel.frontImage ? _scanResultModel.frontImage : @"";
    
    [SYSTEM_NOTIFICATIONCENTER postNotificationName:@"POSTSCANRESLUTDATAMODEL" object:nil userInfo:param];
}



/**
 下一步 跳到拍摄背面界面
 */
- (void)clickNextBtn
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDDown];
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        if (scanModel.type == 2) {
            [self handldscanmodelToSelfmodel:scanModel];
        }
        [self clickColseBtn];
        [self postNotiModel];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 重拍
 */
- (void)clickAgainScanBtn
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:_cardInfo];
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        if (scanModel.type == 2) {
            [self handldscanmodelToSelfmodel:scanModel];
        }else{
            self.scanResultModel = scanModel;
        }
        
        [self postNotiModel];
    }];
    [self.navigationController pushViewController:VC animated:NO];
}

/**
 得到的是背面信息时 赋值给全局变量
 */
- (void)handldscanmodelToSelfmodel:(WYScanResultModel *)scanModel
{
    self.scanResultModel.issue = scanModel.issue;
    self.scanResultModel.valid = scanModel.valid;
    self.scanResultModel.idImage = scanModel.idImage;
    self.scanResultModel.type = scanModel.type;

}

/**
 关闭界面
 */
- (void)clickColseBtn
{
//    NSArray *navVCs = self.navigationController.viewControllers;
//    NSInteger index = 0;
//    for (UIViewController *sub in navVCs) {
//        if ([sub isKindOfClass:[HYCertifiterRealNameUploadIdCardImageViewController class]]) {
//            index = [navVCs indexOfObject:sub];
//        }
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy

- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        if ([_device lockForConfiguration:&error]) {
            if ([_device isSmoothAutoFocusSupported]) {// 平滑对焦
                _device.smoothAutoFocusEnabled = YES;
            }
            
            if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {// 自动持续对焦
                _device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            }
            
            if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure ]) {// 自动持续曝光
                _device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
            }
            
            if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {// 自动持续白平衡
                _device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
            }
            
            [_device unlockForConfiguration];
        }
    }
    return _device;
}
- (HYFillLongButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [HYFillLongButton buttonWithTitleStringKey:@"下一步" target:self selector:@selector(clickNextBtn)];
    }
    return _nextBtn;
}

- (HYDefaultButton *)againScanBtn
{
    if (!_againScanBtn) {
        _againScanBtn = [HYDefaultButton buttonWithTitleStringKey:@"重拍" titleColor:HYCOLOR.color_c0 titleFont:SYSTEM_REGULARFONT(16) target:self selector:@selector(clickAgainScanBtn)];
        _againScanBtn.backgroundColor = HYCOLOR.color_c2;
    }
    return _againScanBtn;
}

- (HYDefaultButton *)colseBtn
{
    if (!_colseBtn) {
        _colseBtn = [[HYDefaultButton alloc]init];
        [_colseBtn setImage:[UIImage imageNamed:@"public_offwhite_n"] forState:UIControlStateNormal];
        [_colseBtn setImage:[UIImage imageNamed:@"public_offwhite_h"] forState:UIControlStateHighlighted];
        [_colseBtn addTarget:self action:@selector(clickColseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colseBtn;
}

- (YBIDScanResultAlearView *)scanResultView
{
    if (!_scanResultView) {
        _scanResultView = [[YBIDScanResultAlearView alloc]init];
    }
    return _scanResultView;
}

- (WYScanResultModel *)scanResultModel
{
    if (!_scanResultModel) {
        _scanResultModel = [[WYScanResultModel alloc]init];
    }
    return _scanResultModel;
}
@end
