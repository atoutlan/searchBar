//
//  ViewController.m
//  搜索
//
//  Created by 咖啡邦-2 on 15/12/2.
//  Copyright © 2015年 Kafeibang. All rights reserved.
//

#import "ViewController.h"
#import "pinyin.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

/** 搜索框 */
@property (strong, nonatomic) IBOutlet UISearchBar *mealSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;
@property(nonatomic, strong) NSMutableArray *searchArray;
@property(nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mealSearchBar.delegate = self;
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.mealSearchBar contentsController:self];
//    self.searchDisplayController.active = NO;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchArray = [@[@"黑椒牛排",@"琉璃金樽",@"金枪鱼三明治",@"苹果沙拉",@"咖喱鸡丁",@"红烧狮子头",@"奥尔良鸡翅",@"锡兰红茶",@"皇家火焰咖啡",@"苹果IOS",@"谷歌android",@"豪门伯爵红茶",@"微软WP",@"卡丁车",@"汤姆克林(Tom  collins)",@"美式咖啡",@"蓝山咖啡",@"coffee",@"orange juice",@"意大利面",@"咖啡邦",@"莫吉托 Mojito"] mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.resultArray.count;
    }
    else {
        return self.searchArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = self.resultArray[indexPath.row];
    }
    else {
        cell.textLabel.text = self.searchArray[indexPath.row];
    }
    return cell;
}



#pragma UISearchDisplayDelegate



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.resultArray = [[NSMutableArray alloc] init];
    if (self.mealSearchBar.text.length > 0) {
        for (int i=0; i<self.searchArray.count; i++) {
            
            NSRange titleResult = [self.searchArray[i] rangeOfString:self.mealSearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length > 0) {
                [self.resultArray addObject:self.searchArray[i]];
            }
            
            NSString *searchString = self.searchArray[i];
            char resultChar = '\0';
            NSString *resultString = nil;
            NSString *resultString2 = nil;
            for (int i = 0; i < [searchString length]; i++) {
                resultChar = pinyinFirstLetter([searchString characterAtIndex:i]);
                resultString2 = [NSString stringWithFormat:@"%c", resultChar];
                resultString = [NSString stringWithFormat:@"%@%@", resultString, resultString2];
            }
            
            NSRange titleResult2 = [resultString rangeOfString:self.mealSearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult2.length > 0) {
                [self.resultArray addObject:self.searchArray[i]];
            }

        }
    } 
}


@end
