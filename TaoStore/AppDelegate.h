//
//  AppDelegate.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AFNetworking.h"//网络请求三方

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UITabBarController* tabBarViewController;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 *  网络请求单例
 */
@property (strong, nonatomic) AFHTTPSessionManager *httpManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

