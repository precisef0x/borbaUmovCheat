#import <UIKit/UIKit.h>
#import "QFClasses.h"	//Some built-in classes

#define settingsFile [NSHomeDirectory() stringByAppendingString:@"/Documents/ru.precisef0x.borbaumovcheat.plist"]

NSString* correctAnswer;
int cheatIndex;

%ctor
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:settingsFile])
    {
        NSDictionary *dict = @{@"hideenable" : @NO, @"glowenable" : @YES,};
        [dict writeToFile:settingsFile atomically:NO];
    }
}

NSString* getPrefKeyForTag(int tag)
{
    return [@[@"glowenable", @"hideenable"] objectAtIndex: tag];
}

%hook QFButton

%new
-(void) glow
{
    self.layer.shadowColor = [UIColor greenColor].CGColor;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeZero;
}

- (void)setLabelText:(id)arg1
{
    self.hidden = NO;
    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    if ([[prefs objectForKey:@"glowenable"] boolValue])
    {
        if([correctAnswer isEqualToString:arg1])
        {
            [self glow];
        }
    }
    if ([[prefs objectForKey:@"hideenable"] boolValue])
    {
        if(![correctAnswer isEqualToString:arg1])
        {
            self.hidden = YES;
        }
    }
    %orig;
}

%end

%hook QFOptionsTVC
-(void)tableView:(id)view didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row < cheatIndex) %orig;
}

%new(v@:)
- (void) switchToggled:(UISwitch*)sender {
    NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:settingsFile];
    [plistdict setValue:[NSNumber numberWithBool:sender.on] forKey:getPrefKeyForTag(sender.tag)];
    [plistdict writeToFile:settingsFile atomically:NO];
}

%new
-(UITableViewCell*)generateCheatCellWithLabel: (NSString*)label prefTag:(int)tag atIndexPath:(NSIndexPath*)indexPath
{
    int rows = [self tableView:[[self performSelector:@selector(tableView)] retain] numberOfRowsInSection:[indexPath section]];
    QFGamesTableViewCell *cell = [[%c(QFGamesTableViewCell) alloc] initOptionsCell:label imageName:@"review_star_active" row:[indexPath row] nRows:rows hasHeader:false avatarCode:nil delegate:self];

    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchView addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    switchView.tag = tag;
    cell.accessoryView = switchView;

    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    if ([[prefs objectForKey:getPrefKeyForTag(tag)] boolValue]) [switchView setOn:YES animated:NO];
    else [switchView setOn:NO animated:NO];

    return cell;
}

-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row >= cheatIndex)
    {
        switch(indexPath.row - cheatIndex)
        {
            case 0: return [self generateCheatCellWithLabel:@"Подсветить ответ" prefTag:0 atIndexPath:indexPath];
            case 1: return [self generateCheatCellWithLabel:@"Скрыть неверные" prefTag:1 atIndexPath:indexPath];
            default: return nil;
        }
    }

    else return %orig;
}

-(int)nRowsSectionSettings
{
    int r = %orig;
    cheatIndex = r;
    return r + 2;
}
%end

%hook QuestionCardView
+ (id)questionCardWithQuestion:(id)question isLifeline:(BOOL)arg2
{
    id r = %orig;
    correctAnswer = [[NSString alloc] initWithString:[question performSelector:@selector(correctAnswer)]];
    return r;
}
%end

%hook Datasource
+ (BOOL)isUserPremium { return 1; }
%end
