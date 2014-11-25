//
//  SettingTableTableViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "UserSettings.h"

@interface SettingsTableViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *diceQuantityOptions;     // of NSString
@property (strong, nonatomic) NSArray *diceMaxNumberOptions;    // of NSString
@property (strong, nonatomic) NSArray *diceStyleOptions;

@property (strong, nonatomic) IBOutlet UITableView *tableView_settings;

@end

@implementation SettingsTableViewController


#pragma mark - 常量

#define SECTION_INDEX_DICE 0
#define SECTION_INDEX_COIN 1
#define ROW_INDEX_DICE_QUANTITY 0
#define ROW_INDEX_DICE_SIDES_NUMBER 1
#define ROW_INDEX_DICE_STYLE 2

#define NUMBER_OF_SECTIONS 1
#define NUMBER_OF_ROWS_IN_DICE 3
#define NUMBER_OF_ROWS_IN_COIN 0

#define DICE_QUANTITY_OPTIONS @"1", @"2", @"3", @"4", @"5", @"6"
#define DICE_SIDES_NUMBER_OPTIONS @"4", @"6", @"8", @"10", @"12", @"20", @"100" //, @"2", @"3", @"4", @"5", @"6",  @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89", @"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", @"100"
#define DICE_STYLE_OPTIOINS @"Number", @"Dots (6 sides or less)"


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
        _diceMaxNumberOptions = [NSArray arrayWithObjects:DICE_SIDES_NUMBER_OPTIONS, nil];
    }
    return _diceMaxNumberOptions;
}

- (NSArray *)diceStyleOptions
{
    if (!_diceStyleOptions) {
        _diceStyleOptions = [NSArray arrayWithObjects:DICE_STYLE_OPTIOINS, nil];
    }
    return _diceStyleOptions;
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
    if (section == SECTION_INDEX_DICE) {
        return NUMBER_OF_ROWS_IN_DICE;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_text"
                                                            forIndexPath:indexPath];
    
    if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_QUANTITY) {
        cell.textLabel.text = @"Dice Quantity";
        cell.detailTextLabel.text = [UserSettings sharedInstance].dice_quantity_string;
        
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_SIDES_NUMBER) {
        cell.textLabel.text = @"Dice Sides Number";
        cell.detailTextLabel.text = [UserSettings sharedInstance].dice_sidesNumber_string;
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_STYLE) {
        cell.textLabel.text = @"Dice Style";
        cell.detailTextLabel.text = [UserSettings sharedInstance].dice_style_string;
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
    } else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_SIDES_NUMBER) {
        [self showOptionsForDiceMaxNumber];
    } else if (indexPath.section == SECTION_INDEX_DICE && indexPath.row == ROW_INDEX_DICE_STYLE) {
        [self showOptionsForDiceStyle];
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
        // 处理骰子数量ActionSheet选项点击
        NSString *selectedOption = self.diceQuantityOptions[buttonIndex];
        [UserSettings sharedInstance].dice_quantity = selectedOption.integerValue;
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE
               && indexPath.row == ROW_INDEX_DICE_SIDES_NUMBER
               && buttonIndex < self.diceMaxNumberOptions.count)
    {
        // 处理骰子面数ActionSheet选项点击
        NSString *selectedOption = self.diceMaxNumberOptions[buttonIndex];
        [UserSettings sharedInstance].dice_sidesNumber = selectedOption.integerValue;
        
        if ([UserSettings sharedInstance].dice_sidesNumber > 6
            &&[UserSettings sharedInstance].dice_style != DiceStyleNumber) {
            [UserSettings sharedInstance].dice_style = DiceStyleNumber;
        }
    }
    
    else if (indexPath.section == SECTION_INDEX_DICE
             && indexPath.row == ROW_INDEX_DICE_STYLE
             && buttonIndex < self.diceStyleOptions.count)
    {
        // 处理骰子样式ActionSheet选项点击
        [UserSettings sharedInstance].dice_style_string = self.diceStyleOptions[buttonIndex];
        
        if ([UserSettings sharedInstance].dice_style == DiceStyleDots
            && [UserSettings sharedInstance].dice_sidesNumber > 6) {
            [UserSettings sharedInstance].dice_sidesNumber = 6;
        }
    }
    
    [self.tableView reloadData];
    
    
}

#pragma mark - 方法
/*
- (void)updateTableViewCellDetail:(NSIndexPath *)indexPath value:(NSString *)value
{
    UITableViewCell *cell = [self.tableView_settings cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = value;
}
 */


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
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"Select Dice Sides Number"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:DICE_SIDES_NUMBER_OPTIONS, nil];
    [as showInView:self.view];
}

- (void)showOptionsForDiceStyle
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Select Dice Style"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:DICE_STYLE_OPTIOINS, nil];
    [as showInView:self.view];
}


@end


















