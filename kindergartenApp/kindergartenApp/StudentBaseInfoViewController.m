//
//  StudentBaseInfoViewController.m
//  kindergartenApp
//
//  Created by You on 15/7/23.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "StudentBaseInfoViewController.h"
#import "KGTextField.h"
#import "Masonry.h"
#import "KGPopupViewController.h"
#import "KGNSStringUtil.h"

@interface StudentBaseInfoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, KGPopupVCDelegate> {
    
    IBOutlet UIImageView * headImageView;
    IBOutlet KGTextField * nameTextField;
    IBOutlet KGTextField * nickTextField;
    IBOutlet KGTextField * birthdayTextField;
    IBOutlet UIImageView * boyImageView;
    IBOutlet UIImageView * girlImageView;
    NSString * filePath;
    
    KGPopupViewController * popupVC;
    UIDatePicker * datePicker;
}

@end

@implementation StudentBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细信息";
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveStudentBaseInfo)];
    [rightBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [headImageView.layer setCornerRadius:headImageView.width / Number_Two];
    [headImageView.layer setMasksToBounds:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  添加输入框到array统一管理验证
 */
- (void)addTextFieldToMArray
{
    [nameTextField setTextFielType:KGTextFielType_Empty];
    [nameTextField setMessageStr:@"姓名不能为空"];
    [textFieldMArray addObject:nameTextField];
}


//初始化页面值
- (void)initViewData {
    nameTextField.text = _studentInfo.name;
    birthdayTextField.text = _studentInfo.birthday;
}


//保存按钮点击
- (void)saveStudentBaseInfo {
    if([self validateInputInView]) {
        _studentInfo.name = [KGNSStringUtil trimString:nameTextField.text];
        _studentInfo.nickname = [KGNSStringUtil trimString:nickTextField.text];
        _studentInfo.birthday = [KGNSStringUtil trimString:birthdayTextField.text];
        
        //提交数据
    }
}



- (IBAction)changeHeadImgBtnClicked:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从相册选取", @"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.contentView];
}

#pragma actionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == Number_Zero) {
        //从相册
        [self localPhoto];
    } else {
        //拍照
        [self openCamera];
    }
}


//打开本地相册
- (void)localPhoto {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = true;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}


//开始拍照
- (void)openCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = true;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    } else {
        //没有相机
        
    }
}


//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData * data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
//        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
//                                    CGRectMake(50, 120, 40, 40)];
//        
//        smallimage.image = image;
//        //加在视图中
//        [self.view addSubview:smallimage];
        headImageView.image = image;
    } 
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sexBtnClicked:(UIButton *)sender {
    _studentInfo.sex = sender.tag-Number_Ten;
    
}


- (IBAction)birthdayBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(!popupVC) {
        popupVC = [[KGPopupViewController alloc] init];
        popupVC.delegate = self;
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        [popupVC setContentView:datePicker];
    }
    [self.navigationController presentViewController:popupVC animated:YES completion:nil];
}


- (void)popupCallback {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dateChanged:(id)sender{
    UIDatePicker * control = (UIDatePicker*)sender;
    NSString * timeStr = [NSString stringWithFormat:@"%@", control.date];
    NSArray * timeArray = [timeStr componentsSeparatedByString:@" "];
    if([timeArray count] > Number_Zero) {
        birthdayTextField.text = [timeArray objectAtIndex:Number_Zero];
    }
}


- (void)showDatePicker:(BOOL)isShow {
    [UIView animateWithDuration:Number_AnimationTime_Five animations:^{
        datePicker.alpha = isShow ? Number_One : Number_Zero;
    } completion:^(BOOL finished) {
        
    }];
}





@end
