#import <UIKit/UIKit.h>
#import "QFClasses.h"	//Some built-in classes

#define settingsFile @"/var/mobile/Library/Preferences/ru.precisef0x.borbaumovcheat.plist"

NSString* correctAnswer;

int cheatIndex;
UISwitch *switchView;
UISwitch *switchView2;
UISwitch *switchView3;

QFButton *altButton1;
QFButton *altButton2;
QFButton *altButton3;
QFButton *altButton4;

%ctor
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:settingsFile])
    {
        NSDictionary *dict = @{@"showlabelenable" : @NO, @"hideenable" : @NO, @"glowenable" : @YES,};
        [dict writeToFile:settingsFile atomically:YES];
    }
}

void reloadSwitches()
{
    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    if (switchView && [[prefs objectForKey:@"showlabelenable"] boolValue]) [switchView setOn:YES animated:NO];
    else [switchView setOn:NO animated:NO];
    if (switchView2 && [[prefs objectForKey:@"hideenable"] boolValue]) [switchView2 setOn:YES animated:NO];
    else [switchView2 setOn:NO animated:NO];
    if (switchView3 && [[prefs objectForKey:@"glowenable"] boolValue]) [switchView3 setOn:YES animated:NO];
    else [switchView3 setOn:NO animated:NO];
}

%hook QFOptionsTVC
-(void)tableView:(id)view didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row != cheatIndex) %orig;
}

%new(v@:)
- (void) labelChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:settingsFile];
    if(switchControl.on)
    {
        [plistdict setValue:@YES forKey:@"showlabelenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
    else
    {
        [plistdict setValue:@NO forKey:@"showlabelenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
}

%new(v@:)
- (void) hideChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:settingsFile];
    if(switchControl.on)
    {
        [plistdict setValue:@YES forKey:@"hideenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
    else
    {
        [plistdict setValue:@NO forKey:@"hideenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
}

%new(v@:)
- (void) glowChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:settingsFile];
    if(switchControl.on)
    {
        [plistdict setValue:@YES forKey:@"glowenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
    else
    {
        [plistdict setValue:@NO forKey:@"glowenable"];
        [plistdict writeToFile:settingsFile atomically:YES];
    }
}

-(UITableViewCell*)tableView:(id)view cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *r = %orig;
    
    /* if(indexPath.row == cheatIndex)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell;
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [[cell contentView] setBackgroundColor:[UIColor clearColor]];
        [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.contentView.bounds = CGRectInset(cell.contentView.frame, -10.0f, 0.0f);
        //		cell.indentationWidth = r.indentationWidth;
        [cell.contentView addSubview:[[[[r.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1]];
        
        UILabel* countLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 87, 10)];
        countLabel.text = @"Показать ответ";
        countLabel.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel.textColor=[UIColor whiteColor];
        countLabel.backgroundColor=[UIColor clearColor];
        UILabel* countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(103, 5, 100, 10)];
        countLabel2.text = @"Скрыть неверные";
        countLabel2.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel2.textColor=[UIColor whiteColor];
        countLabel2.backgroundColor=[UIColor clearColor];
        UILabel* countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(216, 5, 80, 10)];
        countLabel3.text = @"Подсвечивать";
        countLabel3.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel3.textColor=[UIColor whiteColor];
        countLabel3.backgroundColor=[UIColor clearColor];
        
        
        [cell.contentView addSubview:countLabel];
        [cell.contentView addSubview:countLabel2];
        [cell.contentView addSubview:countLabel3];
        
        
        switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView.frame = CGRectMake(23, 25, 0, 0);
        [cell.contentView addSubview:switchView];
        [switchView addTarget:self action:@selector(labelChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView release];
        
        switchView2 = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView2.frame = CGRectMake(127, 25, 0, 0);
        [cell.contentView addSubview:switchView2];
        [switchView2 addTarget:self action:@selector(hideChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView2 release];
        
        switchView3 = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView3.frame = CGRectMake(230, 25, 0, 0);
        [cell.contentView addSubview:switchView3];
        [switchView3 addTarget:self action:@selector(glowChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView3 release];
        
        reloadSwitches();
        
        return cell;
    } */
    
    if(indexPath.row == cheatIndex)
    {
        id img = [self performSelector:@selector(imageNameForSection:) withObject:[NSIndexPath indexPathForRow:0 inSection:0]];
        id tableView = [[self performSelector:@selector(tableView)] retain];
        int rows = [self tableView:tableView numberOfRowsInSection:[indexPath section]];
        QFGamesTableViewCell* cell = [[%c(QFGamesTableViewCell) alloc] initSearchUserCell:@"" imageName:img row:[indexPath row] nRows:rows hasHeader:false avatarCode:nil delegate:self];
        
        UILabel* countLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 5, 87, 10)];
        countLabel.text = @"Показать ответ";
        countLabel.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel.textColor=[UIColor whiteColor];
        countLabel.backgroundColor=[UIColor clearColor];
        UILabel* countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(121, 5, 100, 10)];
        countLabel2.text = @"Скрыть неверные";
        countLabel2.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel2.textColor=[UIColor whiteColor];
        countLabel2.backgroundColor=[UIColor clearColor];
        UILabel* countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(222, 5, 80, 10)];
        countLabel3.text = @"Подсвечивать";
        countLabel3.font=[UIFont boldSystemFontOfSize:11.0];
        countLabel3.textColor=[UIColor whiteColor];
        countLabel3.backgroundColor=[UIColor clearColor];
        
        
        [cell.pane addSubview:countLabel];
        [cell.pane addSubview:countLabel2];
        [cell.pane addSubview:countLabel3];
        
        
        switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView.frame = CGRectMake(54, 25, 0, 0);
        [cell.pane addSubview:switchView];
        [switchView addTarget:self action:@selector(labelChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView release];
        
        switchView2 = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView2.frame = CGRectMake(145, 25, 0, 0);
        [cell.pane addSubview:switchView2];
        [switchView2 addTarget:self action:@selector(hideChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView2 release];
        
        switchView3 = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView3.frame = CGRectMake(236, 25, 0, 0);
        [cell.pane addSubview:switchView3];
        [switchView3 addTarget:self action:@selector(glowChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView3 release];
        
        reloadSwitches();

        
        
        return cell;
    }
    
    
    else return r;
}

-(int)nRowsSectionSettings
{
    int r = %orig;
    cheatIndex = r;
    return r + 1;
}

%end

%hook QFGameController

%new
-(void) glowButton:(QFButton*)button
{
    button.layer.shadowColor = [UIColor greenColor].CGColor;
    button.layer.shadowRadius = 5.0f;
    button.layer.shadowOpacity = 1.0f;
    button.layer.shadowOffset = CGSizeZero;
}

-(void)animateAlternativesIn
{
    NSString *alt1, *alt2, *alt3, *alt4;
    NSString* appVersion = [[NSString alloc] initWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    if([appVersion isEqualToString:@"4.7.4"] || [appVersion isEqualToString:@"5.0.4"] || [appVersion isEqualToString:@"5.3.2"])
    {
        alt1 = [[NSString alloc] initWithString:altButton1.titleLabel.text];
        alt2 = [[NSString alloc] initWithString:altButton2.titleLabel.text];
        alt3 = [[NSString alloc] initWithString:altButton3.titleLabel.text];
        alt4 = [[NSString alloc] initWithString:altButton4.titleLabel.text];
    }
    else
    {
        alt1 = [[NSString alloc] initWithString:altButton1.label.text];
        alt2 = [[NSString alloc] initWithString:altButton2.label.text];
        alt3 = [[NSString alloc] initWithString:altButton3.label.text];
        alt4 = [[NSString alloc] initWithString:altButton4.label.text];
    }
    
    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    
    if ([[prefs objectForKey:@"glowenable"] boolValue])
    {
        if([correctAnswer isEqualToString:alt1])
        {
            [self performSelector:@selector(glowButton:) withObject:altButton1];
        }
        else if([correctAnswer isEqualToString:alt2])
        {
            [self performSelector:@selector(glowButton:) withObject:altButton2];
        }
        else if([correctAnswer isEqualToString:alt3])
        {
            [self performSelector:@selector(glowButton:) withObject:altButton3];
        }
        else if([correctAnswer isEqualToString:alt4])
        {
            [self performSelector:@selector(glowButton:) withObject:altButton4];
        }
    }
    
    if ([[prefs objectForKey:@"hideenable"] boolValue])
    {
        if(![correctAnswer isEqualToString:alt1])
        {
            altButton1.hidden=YES;
        }
        else altButton1.hidden=NO;
        
        if(![correctAnswer isEqualToString:alt2])
        {
            altButton2.hidden=YES;
        }
        else altButton2.hidden=NO;
        
        if(![correctAnswer isEqualToString:alt3])
        {
            altButton3.hidden=YES;
        }
        else altButton3.hidden=NO;
        
        if(![correctAnswer isEqualToString:alt4])
        {
            altButton4.hidden=YES;
        }
        else altButton4.hidden=NO;
    }
    
    %orig;
}

-(id)addAlternativeButton:(id)button tag:(int)tag x:(int)x y:(int)y
{
    id r = %orig;
    switch (tag)
    {
        case 0: altButton1 = r; break;
        case 1: altButton2 = r; break;
        case 2: altButton3 = r; break;
        case 3: altButton4 = r; break;
        default: break;
    }
    return r;
}

%end

%hook QFQuestionCard

+(void)addWaterMarkTo:(UIView*)to
{
    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    UILabel* ololabel = [[UILabel alloc]initWithFrame:CGRectMake(0, to.bounds.size.height-24, to.bounds.size.width, 24)];
    [ololabel setBackgroundColor:[UIColor whiteColor]];
    [ololabel setText:correctAnswer];
    if ([[prefs objectForKey:@"showlabelenable"] boolValue])
        if(ololabel)
            [to addSubview:ololabel];
}

%end

%hook QuestionCardView
+ (id)questionCardWithQuestion:(id)question isLifeline:(BOOL)arg2
{
    id r = %orig;
    correctAnswer = [[NSString alloc] initWithString:[question performSelector:@selector(correctAnswer)]];
    return r;
}

+(id)questionCardWithQuestion:(id)question
{
    id r = %orig;
    correctAnswer = [[NSString alloc] initWithString:[question performSelector:@selector(correctAnswer)]];
    return r;
}
%end

%hook Datasource

+ (BOOL)isUserPremium { return 1; }


%end
