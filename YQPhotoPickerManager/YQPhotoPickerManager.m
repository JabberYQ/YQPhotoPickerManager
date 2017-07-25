//
//  YQPhotoPickerManager.m
//  YQPhotoPickerManager
//
//  Created by 俞琦 on 2017/7/25.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQPhotoPickerManager.h"

@interface YQPhotoPickerManager() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, copy) successBlock successBlock;
@end

@implementation YQPhotoPickerManager
+ (instancetype)shareManager
{
    static YQPhotoPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YQPhotoPickerManager alloc] init];
    });
    return manager;
}

// 相机
- (void)requestCameraWithViewController:(UIViewController *)viewController Success:(successBlock)successBlock unauthorized:(unauthorizedBlock)unauthorizedBlock willAlert:(BOOL)alert
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) { // 没有认证，提醒去认证
        if (alert)
            [self alertStr:@"请您设置允许APP访问您的相机\n设置>隐私>相机" withViewController:viewController];
        unauthorizedBlock();
    } else { // 认证成功或者还没有认证
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *takePhotoController = [[UIImagePickerController alloc] init];
            takePhotoController.delegate = self;
            takePhotoController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [viewController presentViewController:takePhotoController animated:YES completion:nil];
            self.successBlock = successBlock;
        }
    }
    
}

// 相册
- (void)requestAlbumWithViewController:(UIViewController *)viewController success:(successBlock)successBlock unauthorized:(unauthorizedBlock)unauthorizedBlock willAlert:(BOOL)alert
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) { // 没有认证，提醒去认证
        if (alert)
            [self alertStr:@"请您设置允许APP访问您的相机\n设置>隐私>相册" withViewController:viewController];
        unauthorizedBlock();
    } else {
        UIImagePickerController *photoPickerController = [[UIImagePickerController alloc] init];
        photoPickerController.delegate = self;
        photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [viewController presentViewController:photoPickerController animated:YES completion:nil];
        self.successBlock = successBlock;
    }
}


#pragma mark - private
- (void)alertStr:(NSString *)str withViewController:(UIViewController *)viewController
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 跳转到设置界面
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [viewController presentViewController:alertC animated:YES completion:nil];
}


#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.successBlock(selectImage);
}
@end
