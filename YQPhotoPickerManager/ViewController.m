//
//  ViewController.m
//  YQPhotoPickerManager
//
//  Created by 俞琦 on 2017/7/25.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "ViewController.h"
#import "YQPhotoPickerManager.h"

@interface ViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片展示";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addImage)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}


- (void)addImage
{
    __weak typeof(self) ws = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择一个方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[YQPhotoPickerManager shareManager] requestAlbumWithViewController:self success:^(UIImage *image) {
            ws.imageView.image = image;
        } unauthorized:^{
            
        } willAlert:YES];
        
    }];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[YQPhotoPickerManager shareManager] requestCameraWithViewController:self Success:^(UIImage *image) {
            ws.imageView.image = image;
        } unauthorized:^{
            
        } willAlert:YES];
        
    }];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:nil];
}

@end
