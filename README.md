# YQPhotoPickerManager
一行代码搞定相机相册的权限以及照片获取


## 逻辑

![逻辑.png](http://upload-images.jianshu.io/upload_images/2312304-53240dc2a2c6fcf8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


（第一次画这种逻辑图，表示很难画啊>_<）


## 使用
```
[[YQPhotoPickerManager shareManager] requestAlbumWithViewController:self success:^(UIImage *image) {
            ws.imageView.image = image;
        } unauthorized:^{
            
        } willAlert:YES];
```
简单讲一下使用，在控制器中调用管理器实例方法，方法的参数为一个控制器，两个回调以及一个BOOL类型的提醒。
```
/**
 访问相册功能
 
 @param viewController    当前的视图控制器
 
 @param successBlock      获得照片回调函数
 
 @param unauthorizedBlock 未认证回调函数
 
 @param alert             是否需要提醒（跳转设置的alert） 如果成功则不会提醒
 */
```
需要注意的是，如果alert设置了YES，那么当没有权限时，程序会弹出一个跳转设置的alert，此时unauthorizedBlock就不需要再写alert了。


## 效果

![效果.gif](http://upload-images.jianshu.io/upload_images/2312304-be9b28b761683a3a.gif?imageMogr2/auto-orient/strip)

由于模拟机，就只放了相册的效果。


## 最后
[简书地址:一行代码搞定相机相册的权限以及照片获取](http://www.jianshu.com/p/a962729bce0e)
