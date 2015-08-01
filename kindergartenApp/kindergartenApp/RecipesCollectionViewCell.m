//
//  RecipesCollectionViewCell.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesCollectionViewCell.h"

@implementation RecipesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    recipesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    recipesTableView.separatorColor = [UIColor clearColor];
    recipesTableView.delegate   = self;
    recipesTableView.dataSource = self;
    
    self.backgroundColor = [UIColor grayColor];
}


//加载食谱数据
- (void)loadRecipesData:(RecipesDomain *)recipesDomain; {
    testLabel.text = recipesDomain.analysis;
    
}





#pragma UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [recipesDataSourceMArray count];
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    StudentInfoItemVO * itemVO = [recipesDataSourceMArray objectAtIndex:section];
//    return [itemVO.contentMArray count];
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section!=Number_Zero && section!=Number_Seven) {
//        return Cell_Height2;
//    }
//    return Number_Zero;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if(section!=Number_Zero && section!=Number_Seven) {
//        StudentInfoItemVO * itemVO = [tableDataSource objectAtIndex:section];
//        
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentInfoHeaderView" owner:nil options:nil];
//        StudentInfoHeaderView * view = (StudentInfoHeaderView *)[nib objectAtIndex:Number_Zero];
//        view.titleLabel.text = itemVO.head;
//        view.backgroundColor = KGColorFrom16(0xE7E7EE);
//        view.funBtn.tag = section;
//        [view.funBtn addTarget:self action:@selector(sectionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        return view;
//    }
//    
//    return nil;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.section == Number_Zero) {
//        //学生基本信息
//        return [self loadStudentInfoCell:tableView cellForRowAtIndexPath:indexPath];
//    } else {
//        return [self loadFunCell:tableView cellForRowAtIndexPath:indexPath];
//    }
//}
//

//- (UITableViewCell *)loadStudentInfoCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:StudentInfoCellIdentifier];
//    if (cell == nil) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MeTableViewCell" owner:nil options:nil];
//        cell = [nib objectAtIndex:Number_Zero];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    [cell resetCellParam:_studentInfo];
//    return cell;
//}
//
//
//- (UITableViewCell *)loadFunCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:StudentOtherInfoCellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StudentOtherInfoCellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//    StudentInfoItemVO * itemVO = [tableDataSource objectAtIndex:indexPath.section];
//    cell.textLabel.text = [itemVO.contentMArray objectAtIndex:indexPath.row];
//    
//    return cell;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == Number_Zero) {
        return 60;
    }else{
        if(indexPath.section == Number_Eight) {
            return 70;
        } else {
            return 35;
        }
    }
}

@end
