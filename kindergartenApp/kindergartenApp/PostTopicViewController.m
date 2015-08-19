//
//  PostTopicViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/25.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "PostTopicViewController.h"
#import "UIButton+Extension.h"
#import "KGNSStringUtil.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "KGTextView.h"
#import "KGHttpService.h"
#import "ClassDomain.h"
#import "GroupDomain.h"

#define contentTextViewDefText   @"说点什么吧..."

@interface PostTopicViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextViewDelegate> {
    
    IBOutlet KGTextView * contentTextView;
    UIButton * selAddImgBtn;
    NSMutableArray * filePathMArray;
    NSMutableArray * imagesMArray;
    NSInteger  count;
    NSMutableString * replyContent;
    NSString * classuuid;//班级id
    NSMutableArray * dataMArray;//数据数组 用于构建班级信息
}

@end

@implementation PostTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weakTextView = contentTextView;
    self.keyboardTopType = OnlyEmojiMode;
    
    [self.contentView bringSubviewToFront:contentTextView];
    for (UIView * view in _btnArray) {
        [self.contentView bringSubviewToFront:view];
    }
    
    dataMArray = [[NSMutableArray alloc] init];
    for (GroupDomain * gmodel in [KGHttpService sharedService].loginRespDomain.group_list) {
        for (ClassDomain * cmodel in [KGHttpService sharedService].loginRespDomain.class_list) {
            if ([gmodel.uuid isEqualToString:cmodel.groupuuid]) {
                NSString * name = [NSString stringWithFormat:@"%@%@",gmodel.company_name,cmodel.name];
                [dataMArray addObject:@{@"name":name,@"id":cmodel.uuid}];
            }
        }
    }
    
    [_selectBtn setTitle:[dataMArray[0] objectForKey:@"name"] forState:UIControlStateNormal];
    classuuid = [dataMArray[0] objectForKey:@"id"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"发表互动";
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(pustTopicBtnClicked)];
    rightBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    filePathMArray = [[NSMutableArray alloc] init];
    imagesMArray   = [[NSMutableArray alloc] init];
    replyContent   = [[NSMutableString alloc] init];
    contentTextView.placeholder = contentTextViewDefText;
    [contentTextView setContentOffset:CGPointZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//下拉选择菜单
- (IBAction)selectBtnPressed:(UIButton *)sender {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] init];
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectTableView.backgroundColor = [UIColor whiteColor];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.rowHeight = 40;
        [_selectTableView registerNib:[UINib nibWithNibName:@"SelectClassCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SelectClassCell"];
        _selectTableView.size = CGSizeMake(APPWINDOWWIDTH, dataMArray.count<4?dataMArray.count*40:40*4);
    }
    if (_selectTableView.superview) {
        return;
    }
    _selectTableView.origin = CGPointMake(0, CGRectGetMaxY(_bgView.frame));
    [self.contentView addSubview:_selectTableView];
    [self showSelectTableViewAnimation];
}

//显示选择动画
- (void)showSelectTableViewAnimation{
    _selectTableView.height = 0;
    _arrowImageView.image = [UIImage imageNamed:@"shangjiantou"];
    [UIView animateWithDuration:0.3 animations:^{
        _selectTableView.height = dataMArray.count<4?dataMArray.count*40:40*4;
    } completion:^(BOOL finished) {
    }];
}

//隐藏选择动画
- (void)hiddenSelectTableViewAnimation{
    _arrowImageView.image = [UIImage imageNamed:@"xiajiantou-1"];
    [UIView animateWithDuration:0.3 animations:^{
        _selectTableView.height = 0;
    } completion:^(BOOL finished) {
        [_selectTableView removeFromSuperview];
        [_selectTableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataMArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectClassCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectClassCell"];
    cell.selectImageView.hidden = ![[dataMArray[indexPath.row] objectForKey:@"id"] isEqualToString:classuuid];
    cell.nameLabel.text = [dataMArray[indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int i = 0;
    for (; i < dataMArray.count; ++ i) {
        NSDictionary * dic = dataMArray[i];
        if ([[dic objectForKey:@"id"] isEqualToString:classuuid]) {
            break;
        }
    }
    SelectClassCell * cell = (SelectClassCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    cell.selectImageView.hidden = YES;
    classuuid = [dataMArray[indexPath.row] objectForKey:@"id"];
    [_selectBtn setTitle:[dataMArray[indexPath.row] objectForKey:@"name"] forState:UIControlStateNormal];
    [self hiddenSelectTableViewAnimation];
}

//发表动态
- (void)pustTopicBtnClicked {
    [self loadImg];
}


//上传图片
- (void)loadImg {
    if([imagesMArray count] > Number_Zero) {
        [[KGHUD sharedHud] show:self.contentView msg:@"上传图片中..."];
        [[KGHttpService sharedService] uploadImg:[imagesMArray objectAtIndex:count] withName:@"file" type:self.topicType success:^(NSString *msgStr) {
            
            if(![replyContent isEqualToString:String_DefValue_EmptyStr]) {
                [replyContent appendString:String_DefValue_SpliteStr];
            }
            [replyContent appendString:msgStr];
            
            [self uploadImgSuccessHandler];
        } faild:^(NSString *errorMsg) {
            [self uploadImgSuccessHandler];
        }];
    } else {
        [self sendReplyInfo];
    }
}

- (void)uploadImgSuccessHandler {
    count++;
    
    if(count < [imagesMArray count]) {
        [self loadImg];
    } else {
        [self sendReplyInfo];
    }
}

- (void)sendReplyInfo {
    [[KGHUD sharedHud] changeText:self.contentView text:@"发表中..."];
    
    TopicDomain * domain = [[TopicDomain alloc] init];
    domain.classuuid = classuuid;
    domain.content = [KGNSStringUtil trimString:contentTextView.text];
    domain.imgs = replyContent;
    
    [[KGHttpService sharedService] saveClassNews:domain success:^(NSString *msgStr) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
        
        if(_PostTopicBlock) {
            _PostTopicBlock(domain);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


- (IBAction)addImgBtnClicked:(UIButton *)sender {
    
    selAddImgBtn = sender;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从相册选取", @"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.contentView];
}

#pragma TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    contentTextView.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([[KGNSStringUtil trimString:textView.text] isEqualToString:@""]) {
        contentTextView.text = contentTextViewDefText;
    }
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//}


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
        NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        [filePathMArray addObject:filePath];
        
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
        
        [selAddImgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [selAddImgBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        [selAddImgBtn setBackgroundImage:image forState:UIControlStateSelected];
        
        [imagesMArray addObject:image];
        [self selImgAfterHandler];
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)selImgAfterHandler {
    if(selAddImgBtn.tag < 12) {
        [self.contentView viewWithTag:selAddImgBtn.tag + 1].hidden = NO;
    }
}



@end
