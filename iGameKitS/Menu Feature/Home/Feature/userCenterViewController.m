//
//  userCenterViewController.m
//  iHealthS
//
//  Created by Apple on 2019/4/2.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "userCenterViewController.h"
#import "userCenterTableViewCell.h"
#import "MoneyViewController.h"
#import "IPViewController.h"
#import "phoneViewController.h"
#import "IDsViewController.h"

@interface userCenterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userL;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *ipBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *idBtn;

@end
NSString *uName, *uP1, *uP2, *username, *isLogin;

@implementation userCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginBtn addTarget:self
                   action:@selector(handleButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside
     ];
    [self.moneyBtn addTarget:self
                      action:@selector(moneyBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside
     ];
    [self.ipBtn addTarget:self
                      action:@selector(ipBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside
     ];
    [self.phoneBtn addTarget:self
                      action:@selector(phoneBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside
     ];
    [self.idBtn addTarget:self
                      action:@selector(idBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside
     ];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.userImage.layer.masksToBounds =YES;
    self.userImage.layer.cornerRadius = self.userImage.image.size.height/2;
}

- (void) moneyBtnClicked:(id)sender {
    if([isLogin isEqual:@"true"]){
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"userCenter" bundle:[NSBundle mainBundle]];
    MoneyViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"MoneyView"];
    [self.navigationController pushViewController:controllerD animated:YES];
    } else {
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                 message:@"請先登入"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) ipBtnClicked:(id)sender {
    if([isLogin isEqual:@"true"]){
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"userCenter" bundle:[NSBundle mainBundle]];
    IPViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"IPView"];
    [self.navigationController pushViewController:controllerD animated:YES];
    } else {
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                 message:@"請先登入"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) phoneBtnClicked:(id)sender {
    if([isLogin isEqual:@"true"]){
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"userCenter" bundle:[NSBundle mainBundle]];
    phoneViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"phoneView"];
    [self.navigationController pushViewController:controllerD animated:YES];
    } else{
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                 message:@"請先登入"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) idBtnClicked:(id)sender {
    if([isLogin isEqual:@"true"]){
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"userCenter" bundle:[NSBundle mainBundle]];
    IDsViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"IDsView"];
    [self.navigationController pushViewController:controllerD animated:YES];
    } else{
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                 message:@"請先登入"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) handleButtonClicked:(id)sender {
    NSLog(@"button have been clicked.");
    if([isLogin isEqual:@"true"]){
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登出？"
                                                                                 message:@"是否登出呢？"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        //添加确定到UIAlertController中
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [self showAlert];
    }
}

-(void)showAlert{
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"個人中心"
                                                                             message:@"登入？"
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    //添加取消到UIAlertController中
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"登入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self loginAlert];
    }];
    [alertController addAction:loginAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *sinupAction = [UIAlertAction actionWithTitle:@"註冊" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self sinupAlert];
    }];
    [alertController addAction:sinupAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)loginAlert{
    NSLog(@"LOGIN");
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *loginAlertController = [UIAlertController alertControllerWithTitle:@"登入"
                                                                             message:@"請輸入帳號密碼"
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    [loginAlertController addTextFieldWithConfigurationHandler:^(UITextField *txtField){
        txtField.placeholder =@"用户名";
    }];
    
    [loginAlertController addTextFieldWithConfigurationHandler:^(UITextField *txtField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(txtChange:)
                                                     name:UITextFieldTextDidChangeNotification object:txtField];
        txtField.placeholder =@"密码";
        txtField.secureTextEntry = YES;
    }];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [loginAlertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"登入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        uName = loginAlertController.textFields[0].text;
        uP1 = loginAlertController.textFields[1].text;
        
        if(![uName isEqual:@""] && ![uP1 isEqual:@""]){
            
            [self startLogin];
        } else {
            //UIAlertController风格：UIAlertControllerStyleAlert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                     message:@"請正確填寫資料"
                                                                              preferredStyle:UIAlertControllerStyleAlert ];
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
    [loginAlertController addAction:OKAction];
    
    [self presentViewController:loginAlertController animated:YES completion:nil];
    
}

-(void)sinupAlert{
    NSLog(@"註冊");
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *sinupAlertController = [UIAlertController alertControllerWithTitle:@"註冊"
                                                                                  message:@"請輸入帳號密碼"
                                                                           preferredStyle:UIAlertControllerStyleAlert ];
    
    [sinupAlertController addTextFieldWithConfigurationHandler:^(UITextField *txtField){
        txtField.placeholder =@"用户名";
    }];
    
    [sinupAlertController addTextFieldWithConfigurationHandler:^(UITextField *txtField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(txtChange:)
                                                     name:UITextFieldTextDidChangeNotification object:txtField];
        txtField.placeholder =@"密码";
        txtField.secureTextEntry = YES;
    }];
    
    [sinupAlertController addTextFieldWithConfigurationHandler:^(UITextField *txtField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(txtChange:)
                                                     name:UITextFieldTextDidChangeNotification object:txtField];
        txtField.placeholder =@"再次輸入密码";
        txtField.secureTextEntry = YES;
    }];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [sinupAlertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"註冊" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
        uName = sinupAlertController.textFields[0].text;
        uP1 = sinupAlertController.textFields[1].text;
        uP2 = sinupAlertController.textFields[2].text;

        if(![uName isEqual: @""] && ![uP1 isEqual:@""] && ![uP2 isEqual:@""]){
            
            if([uP1 isEqual:uP2]){
                [self startSingup];
            } else {
                //UIAlertController风格：UIAlertControllerStyleAlert
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                         message:@"密碼不一致"
                                                                                  preferredStyle:UIAlertControllerStyleAlert ];
                //添加确定到UIAlertController中
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } else {
            //UIAlertController风格：UIAlertControllerStyleAlert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                     message:@"請正確填寫資料"
                                                                              preferredStyle:UIAlertControllerStyleAlert ];
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
    
    [sinupAlertController addAction:OKAction];
    [self presentViewController:sinupAlertController animated:YES completion:nil];
}

-(void)txtChange:(NSNotification *)notification{
    UIAlertController *alertTest = (UIAlertController *)self.presentedViewController;
    if(alertTest){
        UITextField *t  = alertTest.textFields.lastObject;
        UIAlertAction *action2 = alertTest.actions.lastObject;
        action2.enabled = t.text.length >=3;
    }
}

-(void)startSingup{
    NSLog(@"註冊連線");
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"https://leancloud.cn:443/1.1/users"];
    NSDictionary *jsonBodyDict = @{@"username":uName, @"password":uP1};
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //head
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"QH3I8AYn0gFPqVTlbbycBfwL-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request addValue:@"XXgXFAIlwoKyxxWDIvxbbYYv" forHTTPHeaderField:@"X-LC-Key"];
    
    //设置请求方式为POST，默认为GET
    [request setHTTPMethod:@"POST"];
    //设置参数
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:jsonBodyData];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    NSLog(@"LOGIN: %@", jsonString);
    //将字符串写到缓冲区。
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSDictionary* sessionTokenDic = [dic objectForKey:@"sessionToken"];
    if(![[NSString stringWithFormat:@"%@", sessionTokenDic] isEqual:@""]){
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功"
                                                                                 message:@"註冊成功"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        //UIAlertController风格：UIAlertControllerStyleAlert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                                 message:@"註冊失敗,請稍後再試"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            isLogin = @"false";
            [self updateView];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)startLogin{
    NSLog(@"登入連線");
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"https://leancloud.cn:443/1.1/login"];
    NSDictionary *jsonBodyDict = @{@"username":uName, @"password":uP1};
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //head
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"QH3I8AYn0gFPqVTlbbycBfwL-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request addValue:@"XXgXFAIlwoKyxxWDIvxbbYYv" forHTTPHeaderField:@"X-LC-Key"];
    
    //设置请求方式为POST，默认为GET
    [request setHTTPMethod:@"POST"];
    //设置参数
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:jsonBodyData];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    NSLog(@"LOGIN: %@", jsonString);
    //将字符串写到缓冲区。
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];

    NSDictionary* nameDic = [dic objectForKey:@"username"];
    
    username = [NSString stringWithFormat:@"%@", nameDic];
    isLogin = @"true";
    [self updateView];
}

-(void) updateView{
    if([isLogin isEqual:@"true"]){
        _userL.text = @"你好～\n\t";
//        _userL.text = [_userL.text stringByAppendingString:username];
        _userL.text = [_userL.text stringByAppendingString:@"\n\t\t"];
        _userL.text = [_userL.text stringByAppendingString:@"今天想使用什麼呢？"];
        
    } else {
        _userL.text = @"您尚未登入";
        
        isLogin = @"false";
    }
}

@end
