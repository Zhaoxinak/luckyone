//
//  NetworkHelper.m
//  InterfaceHelper
//
//  Created by Wu Hengmin on 16/3/23.
//  Copyright © 2016年 Wu Hengmin. All rights reserved.
//

#import "NetworkHelper.h"

typedef enum : NSUInteger {
    GETMethod, //GET请求方法
    POSTMethod //POST请求方法
} HTTPMethod; //请求方法

typedef enum : NSUInteger {
    NormalHTTPHeader, //正常请求头方法
    SpecialHTTPHeader //特殊请求头方法
} HTTPHeaderMethod; //请求方法


@implementation NetworkHelper

#pragma mark发现界面数据
+(void)dataWithDiscover:(BOOL)progress completion:(void (^ _Nonnull)(BOOL finish, id  _Nullable responseObject))completion {
    if ([ZXTools getCurrentWindow] == nil) {
        progress = NO;
    }
    //    NSString *params = [NSString stringWithFormat:@"userName=%@", @""];
    NSString *str = [NSString stringWithFormat:@"%@%@", BASEURL, URL_DISCOVER];
    NSLog(@"%@", str);
    [self data:progress url:str params:@"" type:NormalHTTPHeader Method:GETMethod completion:^(id  _Nullable responseObject){
        if (responseObject) {
            
            
            completion(YES, responseObject);
        } else {
            completion(NO, nil);
        }
    }];
}

#pragma mark图片上传
+(void)dataWithImgupload:(BOOL)progress viewpointId:(NSString *_Nonnull)viewpointId imageDatas:(NSMutableArray *_Nonnull)imageDatas completion:(void (^ _Nonnull)(BOOL finish))completion {
    if ([ZXTools getCurrentWindow] == nil) {
        progress = NO;
    }
    
    NSString *params = [NSString stringWithFormat:@"viewpointId=%@", viewpointId];
    NSString *str = [NSString stringWithFormat:@"%@%@%@", BASEURL, URL_DISCOVER, params];
    
    [self imgData:progress url:str imageDatas:imageDatas imageName:@"files" parameters:nil completion:^(BOOL finish) {
       
        if (finish) {
            completion(YES);
        }else{
            completion(NO);
        }
        
    }];
    
}


#pragma mark工具类
//工具类
/*************************************************************/

#pragma mark二进制转字典
+(NSDictionary *)nsdata2dic:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
}

#pragma mark隐藏当前hud
+(void)hideMBProgressHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[ZXTools getCurrentWindow] animated:YES];
    });
}

#pragma mark通用数据请求
+(void)data:(BOOL)progress url:(NSString *)url params:(NSString *)params type:(HTTPHeaderMethod)type Method:(HTTPMethod)Method completion:(void (^ _Nonnull)(id  _Nullable responseObject))completion {
    if (progress) {
        [MBProgressHUD showHUDAddedTo:[ZXTools getCurrentWindow]animated:YES];
        
        //模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[ZXTools getCurrentWindow] animated:YES];
        });
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //特殊请求
    if (type == SpecialHTTPHeader) {
         [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    }

    if (Method == POSTMethod) {
        WEAK_SELF;
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF;
            if (progress) {
                [self hideMBProgressHUD];
            }
            NSLog(@"data:%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completion(responseObject);
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF;
            if (progress) {
                [self hideMBProgressHUD];
            }
            
            NSLog(@"error:%@", error);
            [ZXTools makeTask:[error localizedDescription]];
            completion(nil);
            
            
        }];
        
        
    }else{
        WEAK_SELF;
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF;
            if (progress) {
                [self hideMBProgressHUD];
            }
            NSLog(@"data:%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completion(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF;
            if (progress) {
                [self hideMBProgressHUD];
            }
            
            NSLog(@"error:%@", error);
            [ZXTools makeTask:[error localizedDescription]];
            completion(nil);
            
            
        }];
        
    }
    
}

#pragma mark通用图片请求
+(void)imgData:(BOOL)progress url:(NSString *)url imageDatas:(NSMutableArray *_Nonnull)imageDatas imageName:(NSString *_Nonnull)imageName parameters:(NSDictionary *)parameters completion:(void (^ _Nonnull)(BOOL finish))completion{
    if (progress) {
        [MBProgressHUD showHUDAddedTo:[ZXTools getCurrentWindow]animated:YES];
        
        //模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[ZXTools getCurrentWindow] animated:YES];
        });
        
    }
    
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        NSInteger imgCount = 0;
        for (NSData *imageData in imageDatas) {
            
            NSString *fileName = [NSString stringWithFormat:@"files%ld.png",(long)imgCount];
            
            [formData appendPartWithFileData:imageData name:imageName fileName:fileName mimeType:@"image/png"];
            
            imgCount++;
            
        }
        
    } error:nil];
    
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    AFHTTPResponseSerializer * s = [AFHTTPResponseSerializer serializer];
    
    s.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"multipart/form-data",nil];
    
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    manager.responseSerializer = s;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSLog(@"上传完成！！！");
        
        NSLog(@"responseObject====%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if (responseObject) {
            
            if (progress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:[ZXTools getCurrentWindow] animated:YES];
                });
            }
            
            NSError *error;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            NSLog(@"responseDictionary===%@",responseDictionary);
            
            if ([responseDictionary[@"isValid"]integerValue]) {
                
            }else{
                
            }
            
            completion(YES);
            
        }
        if (error) {
            
            completion(NO);
            NSLog(@"%@",error);
            [ZXTools makeTask:[error localizedDescription]];
        }
    }];
    
    
    [uploadTask resume];
    
    
}

#pragma mark通用错误数据处理
+(void)showServerMsg:(NSString *)msg{
    
    [ZXTools makeTask:[NSString stringWithFormat:@"%@", msg]];
    if ([msg isEqualToString:@"未登录或登录超时，请重新登录后再操作"]) {
        
    }

}


@end
