//
//  ViewController.m
//  Demo_sendMessageAndMakingACell
//
//  Created by goulela on 16/11/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton * phoneButton;
@property (nonatomic, strong) UIButton * messageButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

#pragma mark - MFMessageComposeViewController
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
    
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

#pragma mark - 点击事件
- (void)phoneButtonClikced {

    NSString * moble = @"400671855";
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",moble];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.view addSubview:callWebview];
}

- (void)messageButtonClikced {
    
    [self showMessageView:[NSArray arrayWithObjects:@"13888888888",@"13999999999", nil] title:@"test" body:@"你是土豪么，么么哒"];
}

#pragma mark - 实现方法
- (void)initUI {
    [self.view addSubview:self.phoneButton];

    [self.view addSubview:self.messageButton];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}




#pragma mark - setter & getter
- (UIButton *)phoneButton {
    if (_phoneButton == nil) {
        self.phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.phoneButton.frame = CGRectMake(50, 100, kScreenSize.width - 100, 60);
        self.phoneButton.backgroundColor = [UIColor orangeColor];
        [self.phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.phoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.phoneButton addTarget:self action:@selector(phoneButtonClikced) forControlEvents:UIControlEventTouchUpInside];
    } return _phoneButton;
}

- (UIButton *)messageButton {
    if (_messageButton == nil) {
        self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.messageButton.backgroundColor = [UIColor orangeColor];
        self.messageButton.frame = CGRectMake(50, 200, kScreenSize.width - 100, 60);

        [self.messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.messageButton setTitle:@"发送短信" forState:UIControlStateNormal];
        [self.messageButton addTarget:self action:@selector(messageButtonClikced) forControlEvents:UIControlEventTouchUpInside];
    } return _messageButton;
}

@end
