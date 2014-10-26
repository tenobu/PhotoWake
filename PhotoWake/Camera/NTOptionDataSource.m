//
//  NTOptionTableView.m
//  test15
//
//  Created by 寺内 信夫 on 2013/04/17.
//  Copyright (c) 2013年 寺内 信夫. All rights reserved.
//

#import "NTOptionDataSource.h"

#import "NTAppDelegate.h"

@implementation NTOptionDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
	return nil;//[NSString stringWithFormat:@"Section0%d", section];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return 2;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	if (section == 0) {
		
		return 1;
		
	} else if (section == 1) {
		
		return 2;
		
	}
	
	return 0;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	static NSString *identifier = @"optionCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
    // キャッシュに無ければ、新しくUITableViewCellをつくる
	if (!cell) {
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	
    // Cellに表示する文字を指定する
	NSString *cellText = [NSString stringWithFormat:@"Cell0%d-0%d", indexPath.section, indexPath.row];
    
	cell.textLabel.text = cellText;
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NTAppDelegate *app = [[UIApplication sharedApplication] delegate];
	
	UIViewController *viewCont2 = [[UIViewController alloc] init];
	
	[app.navigationController pushViewController:viewCont2 animated:YES];
	
}

@end
