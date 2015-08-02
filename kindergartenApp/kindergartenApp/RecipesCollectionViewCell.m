//
//  RecipesCollectionViewCell.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesCollectionViewCell.h"
#import "RecipesItemVO.h"
#import "StudentInfoHeaderView.h"
#import "UIColor+Extension.h"
#import "RecipesStudentInfoTableViewCell.h"
#import "CookbookDomain.h"

#define RecipesInfoCellIdentifier  @"RecipesInfoCellIdentifier"

@implementation RecipesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    recipesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    recipesTableView.separatorColor = [UIColor clearColor];
    recipesTableView.delegate   = self;
    recipesTableView.dataSource = self;
    
    self.backgroundColor = [UIColor grayColor];
}

- (NSMutableArray *)tableDataSource {
    if(!_tableDataSource) {
        _tableDataSource = [[NSMutableArray alloc] init];
    }
    return _tableDataSource;
}


//加载食谱数据
- (void)loadRecipesData:(RecipesDomain *)recipesDomain; {
    recipes = recipesDomain;
    
    [self packageTableData];
    [recipesTableView reloadData];
}

- (void)packageTableData {
    RecipesItemVO * itemVO1 = [[RecipesItemVO alloc] initItemVO:recipes.plandate cbArray:nil];
    [self.tableDataSource addObject:itemVO1];
    
    if(recipes.list_time_1 && [recipes.list_time_1 count]>Number_Zero) {
        RecipesItemVO * itemVO2 = [[RecipesItemVO alloc] initItemVO:@"早餐" cbArray:recipes.list_time_1];
        [self.tableDataSource addObject:itemVO2];
    }
    
    if(recipes.list_time_2 && [recipes.list_time_2 count]>Number_Zero) {
        RecipesItemVO * itemVO3 = [[RecipesItemVO alloc] initItemVO:@"早上加餐" cbArray:recipes.list_time_2];
        [self.tableDataSource addObject:itemVO3];
    }
    
    if(recipes.list_time_3 && [recipes.list_time_3 count]>Number_Zero) {
        RecipesItemVO * itemVO4 = [[RecipesItemVO alloc] initItemVO:@"午餐" cbArray:recipes.list_time_3];
        [self.tableDataSource addObject:itemVO4];
    }
    
    if(recipes.list_time_4 && [recipes.list_time_4 count]>Number_Zero) {
        RecipesItemVO * itemVO5 = [[RecipesItemVO alloc] initItemVO:@"下午加餐" cbArray:recipes.list_time_4];
        [self.tableDataSource addObject:itemVO5];
    }
    
    if(recipes.list_time_5 && [recipes.list_time_5 count]>Number_Zero) {
        RecipesItemVO * itemVO6 = [[RecipesItemVO alloc] initItemVO:@"晚餐" cbArray:recipes.list_time_5];
        [self.tableDataSource addObject:itemVO6];
    }
    
    RecipesItemVO * itemVO7 = [[RecipesItemVO alloc] initItemVO:@"营养分析" cbArray:nil];
    [self.tableDataSource addObject:itemVO7];
}


#pragma UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableDataSource count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==Number_Zero || section==[self.tableDataSource count]-Number_One) {
        
    }
    return Number_One;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == Number_Zero) {
        return 0;
    } else {
        return 30;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section!=Number_Zero) {
        RecipesItemVO * itemVO = [self.tableDataSource objectAtIndex:section];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentInfoHeaderView" owner:nil options:nil];
        StudentInfoHeaderView * view = (StudentInfoHeaderView *)[nib objectAtIndex:Number_Zero];
        view.titleLabel.text = itemVO.headStr;
        view.backgroundColor = KGColorFrom16(0xE7E7EE);
        return view;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == Number_Zero) {
        //学生基本信息
        return [self loadStudentInfoCell:tableView cellForRowAtIndexPath:indexPath];
    } else {
        return [self loadRecipesCell:tableView cellForRowAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)loadStudentInfoCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipesStudentInfoTableViewCell * cell = [RecipesStudentInfoTableViewCell cellWithTableView:tableView];
    [cell resetCellParam:recipes];
    return cell;
}


- (UITableViewCell *)loadRecipesCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RecipesInfoCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipesInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    RecipesItemVO * itemVO = [self.tableDataSource objectAtIndex:indexPath.section];
    [self loadRecipes:itemVO frame:CGRectMake(Number_Zero, Number_Zero, cell.width, cell.height)];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == Number_Zero) {
        return 59;
    } else if (indexPath.section == [self.tableDataSource count]-Number_One) {
        return 150;
    } else {
        return 70;
    }
}

- (void)loadRecipes:(RecipesItemVO *)recipesVO frame:(CGRect)frame {
    UIScrollView * recipesScrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    for(CookbookDomain * cookbook in recipesVO.cookbookArray) {
        
    }
}

@end
