//
//  ViewController.m
//  Location
//
//  Created by David on 16/9/2.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([CLLocationManager locationServicesEnabled]) { // 判断是否打开了位置服务
        [self.locationManager startUpdatingLocation]; // 开始更新位置
        // iOS9 以后不仅仅要打开后台定位,还要添加此代码
        if ([_locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
}


#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"------------");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate2D = location.coordinate;
    
    NSLog(@"%f%f", coordinate2D.latitude, coordinate2D.longitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"------------");
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
 
    if (status == kCLAuthorizationStatusDenied) {
        if ([CLLocationManager locationServicesEnabled]) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}




#pragma mark getter setter
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestAlwaysAuthorization];
        _locationManager.delegate = self;
    }
    return _locationManager;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
