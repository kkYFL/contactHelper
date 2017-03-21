//
//  ViewController.m
//  ContactHelper
//
//  Created by 杨丰林 on 17/3/21.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "ViewController.h"
#import "SJABHelper.h"

@interface ViewController ()<UIActionSheetDelegate>
@property(nonatomic, copy)NSString *linkMobile;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _contact = [[JHAddContacts alloc] init];
    _linkMobile = @"17682318236";
}

- (IBAction)addAction:(UIButton *)sender {
    //[SJABHelper addContactName:@"买好车官网" phoneNum:@"18305140051" withLabel:@"XXiojeoijfoijfoij"]
    if ([SJABHelper existPhone:@"17682318236"]==ABHelperNotExistSpecificContact) {
        [SJABHelper addContactName:@"卖好车官网" phoneNum:@"17682318236" withLabel:@"杭州一骑轻尘信息技术有限公司"];
    }
    
    
    //    NSString *title = [NSString stringWithFormat:@"%@可能是电话号码",_linkMobile];
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"呼叫",@"添加到联系人", nil];
    //    actionSheet.tag=2000;
    //    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate弹出添加手机alert
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==2000) {
        if(buttonIndex==0){
            NSURL *tmpUrl=[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_linkMobile]];
            [[UIApplication sharedApplication]openURL:tmpUrl];
        }
        else if(buttonIndex==1){
            NSString *title = [NSString stringWithFormat:@"%@%@",_linkMobile, @"可能是电话号码"];
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"创建新的联系人",@"添加到现有联系人", nil];
            actionSheet.tag=3000;
            [actionSheet showInView:self.view];
        }
    } else if (actionSheet.tag==3000){
        if (buttonIndex==0) {
            /* 添加新建联系人 */
            [_contact addNewContactMobileNum:_linkMobile controller:self];
        } else if (buttonIndex==1) {
            /* 添加到已有联系人 */
            [_contact addIsHaveContactMobileNum:_linkMobile controller:self];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
