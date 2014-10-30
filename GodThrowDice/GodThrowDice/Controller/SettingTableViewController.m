//
//  SettingTableTableViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "SettingTableViewController.h"
#import "UserSettings.h"

@interface SettingTableViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *diceQuantityOptions;     // of NSString
@property (strong, nonatomic) NSArray *diceMaxNumberOptions;
@property (strong, nonatomic) IBOutlet UITableView *tableView_settings;

@end

@implementation SettingTableViewController


#pragma mark - 常量

#define SECTION_INDEX_DICE 0
#define SECTION_INDEX_COIN 1
#define ROW_INDEX_DICE_QUANTITY 0
#define ROW_INDEX_DICE_MAX_NUMBER 1

#define NUMBER_OF_SECTIONS 1

#define DICE_QUANTITY_OPTIONS @"1", @"2", @"3", @"4", @"5", @"6"
#define DICE_MAX_NUMBER_OPTIONS @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89", @"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", @"100"


#pragma mark - 属性

- (NSArray *)diceQuantityOptions
{
    if (!_diceQuantityOptions) {
        _diceQuantityOptions = [NSArray arrayWithObjects:DICE_QUANTITY_OPTIONS, nil];
    }
    return _diceQuantityOptions;
}

- (NSArray *)diceMaxNumberOptions
{
    if (!_diceMaxNumberOptions) {
        _diceMaxNumberOptions = [NSArray arrayWithObjects:DICE_MAX_NUMBER_OPTIONS, nil];
    }
    return _diceMaxNumberOptions;
}



#pragma mark - 初始化方法

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_picker"
                                                            forIndexPath:indexPath];
    
    if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_QUANTITY) {
        cell.textLabel.text = @"Dice Quantity";
        cell.detailTextLabel.text = [UserSettings sharedInstance].dice_quantity_string;
        
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_MAX_NUMBER) {
        cell.textLabel.text = @"Dice Max Number";
        cell.detailTextLabel.text = [UserSettings sharedInstance].dice_sidesNumber_string;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    
    switch (section) {
        case 0:
            title = @"Dice Settings";
            break;
            
        case 1:
            title = @"Coin Settings";
            break;
            
        default:
            title = @"";
            break;
    }
    
    return title;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_QUANTITY) {
        [self showOptionsForDiceQuantity];
    } else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_MAX_NUMBER) {
        [self showOptionsForDiceMaxNumber];
    }
    
}

#pragma mark - ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *indexPath = self.tableView_settings.indexPathForSelectedRow;
    if (indexPath.section == SECTION_INDEX_DICE
        && indexPath.row == ROW_INDEX_DICE_QUANTITY
        && buttonIndex < self.diceQuantityOptions.count)
    {
        NSString *selectedOption = self.diceQuantityOptions[buttonIndex];
        [UserSettings sharedInstance].dice_quantity = selectedOption.integerValue;
        [self updateTableViewCellDetail:indexPath value:[UserSettings sharedInstance].dice_quantity_string];
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE
               && indexPath.row == ROW_INDEX_DICE_MAX_NUMBER
               && buttonIndex < self.diceMaxNumberOptions.count)
    {
        NSString *selectedOption = self.diceMaxNumberOptions[buttonIndex];
        [UserSettings sharedInstance].dice_sidesNumber = selectedOption.integerValue;
        [self updateTableViewCellDetail:indexPath value:[UserSettings sharedInstance].dice_sidesNumber_string];
    }
}

#pragma mark - 方法

- (void)updateTableViewCellDetail:(NSIndexPath *)indexPath value:(NSString *)value
{
    UITableViewCell *cell = [self.tableView_settings cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = value;
}

#pragma mark - 显示选项 ActionSheet

- (void)showOptionsForDiceQuantity
{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"Select Dice Quantity"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:DICE_QUANTITY_OPTIONS, nil];
    [as showInView:self.view];
}


- (void)showOptionsForDiceMaxNumber
{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"Select Dice Max Number"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:DICE_MAX_NUMBER_OPTIONS, nil];
    [as showInView:self.view];
}


@end


















