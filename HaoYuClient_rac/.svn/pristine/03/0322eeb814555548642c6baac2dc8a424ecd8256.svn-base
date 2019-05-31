//
//  LWBlockDefine.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#ifndef LWBlockDefine_h
#define LWBlockDefine_h

//** =========================================================================================== */
//** ===========================================网络请求========================================== */
//** =========================================================================================== */

/**
 *  网络请求成功Block
 *
 *  @param objc             网络返回结果数据
 *  @param requestInfo      请求信息
 */
typedef void(^HYNetRequestSuccessBlock)(id objc, id requestInfo);

/**
 *  网络请求失败Block
 *
 *  @param error            错误码
 *  @param requestInfo      请求信息
 */
typedef void(^HYNetRequestFailureBlock)(id error, id requestInfo);

//** =========================================================================================== */
//** =========================================viewModel======================================== */
//** =========================================================================================== */

/**
 *  viewModel成功回调
 *
 *  @param model            数据模型
 */
typedef void(^HYViewModelCallBackSuccessBlock)(id model);

/**
 *  viewModel失败回调
 *
 *  @param error            错误信息
 */
typedef void(^HYViewModelCallBackFailureBlock)(id error);

//** =========================================================================================== */
//** ===========================================event========================================== */
//** =========================================================================================== */

/**
 *  事件回调Block
 */
typedef void(^HYEventCallBackBlock)(id sender);

/**
 *  事件回调Block 无参数
 */
typedef void(^HYEventCallBackNoParamBlock)(void);

/**
 输入框开始编辑回调Block
 
 @param textField           输入框
 */
typedef void(^HYTextFieldBeginEditingCallBackBlock)(UITextField *textField);

/**
 输入框结束编辑回调Block
 
 @param textField           输入框
 */
typedef void(^HYTextFieldEndEditingCallBackBlock)(UITextField *textField);

/**
 输入框输入回调block
 
 @param textField           输入框
 */
typedef void(^HYTextFieldDidChangeCallBackBlock)(UITextField *textField);

/**
 输入框开始编辑回调Block(多行)
 
 @param textView           输入框
 */
typedef void(^HYTextViewBeginEditingCallBackBlock)(UITextView *textView);

/**
 输入框结束编辑回调Block（多行）
 
 @param textView           输入框
 */
typedef void(^HYTextViewEndEditingCallBackBlock)(UITextView *textView);

//** =========================================================================================== */
//** ===========================================image========================================== */
//** =========================================================================================== */

/**
 图片选择器回调
 
 @param imageArray imageArray 选中图片
 @param assetArray assetArray asset
 @param BOOL BOOL
 */
typedef void(^HYImagePickerCallBackBlock)(NSArray *imageArray, NSArray *assetArray, BOOL sender);

/**
 图片选择器回调
 
 @param image       图片
 @param obj         原件
 */
typedef void(^HYImagePickerVideoCallBackBlock)(UIImage *image, id obj);


#endif /* LWBlockDefine_h */
