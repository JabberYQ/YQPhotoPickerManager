//
//  YQPhotoPickerManager.h
//  YQPhotoPickerManager
//
//  Created by 俞琦 on 2017/7/25.
//  Copyright © 2017年 俞琦. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

typedef void (^successBlock)(UIImage *image);
typedef void (^unauthorizedBlock)();

@interface YQPhotoPickerManager : NSObject
+ (instancetype)shareManager;
/**
 访问相机功能
 
 @param viewController    当前的视图控制器
 
 @param successBlock      获得照片回调函数
 
 @param unauthorizedBlock 未认证回调函数
 
 @param alert             是否需要提醒（跳转设置的alert） 如果成功则不会提醒
 */
- (void)requestCameraWithViewController:(UIViewController *)viewController Success:(successBlock)successBlock unauthorized:(unauthorizedBlock)unauthorizedBlock willAlert:(BOOL)alert;

/**
 访问相册功能
 
 @param viewController    当前的视图控制器
 
 @param successBlock      获得照片回调函数
 
 @param unauthorizedBlock 未认证回调函数
 
 @param alert             是否需要提醒（跳转设置的alert） 如果成功则不会提醒
 */
- (void)requestAlbumWithViewController:(UIViewController *)viewController success:(successBlock)successBlock unauthorized:(unauthorizedBlock)unauthorizedBlock willAlert:(BOOL)alert;
@end
