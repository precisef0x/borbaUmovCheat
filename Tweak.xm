#import <UIKit/UIKit.h>

#define settingsFile @"/var/mobile/Library/Preferences/ru.precisef0x.borbaumovcheat.plist"

NSMutableDictionary *answersDict;
UILabel *myLabel;
int hastoadd = 0;

int cheatIndex;
UISwitch *switchView;
UISwitch *switchView2;
UISwitch *switchView3;

UIButton *altButton1;
UIButton *altButton2;
UIButton *altButton3;
UIButton *altButton4;


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

    if(indexPath.row == cheatIndex)
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
		[cell.contentView addSubview:[[[[r.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1]];

    	UILabel* countLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 87, 10)];
    	countLabel.text = @"Показать ответ"; 
    	countLabel.font=[UIFont boldSystemFontOfSize:11.0]; 
    	countLabel.textColor=[UIColor whiteColor];
    	countLabel.backgroundColor=[UIColor redColor];
    	UILabel* countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(103, 5, 100, 10)];
    	countLabel2.text = @"Скрыть неверные";
    	countLabel2.font=[UIFont boldSystemFontOfSize:11.0];
    	countLabel2.textColor=[UIColor whiteColor];
    	countLabel2.backgroundColor=[UIColor redColor]; 
    	UILabel* countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(216, 5, 80, 10)];
    	countLabel3.text = @"Подсвечивать";
    	countLabel3.font=[UIFont boldSystemFontOfSize:11.0];
    	countLabel3.textColor=[UIColor whiteColor];
    	countLabel3.backgroundColor=[UIColor redColor]; 


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


%hook QFVC
-(UIView*) contentView
{
    UIView* r = %orig;
    if(myLabel) { [myLabel setText:[answersDict objectForKey:@"currentAnswer"]];
        NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
        if ([[prefs objectForKey:@"showlabelenable"] boolValue])
            if(hastoadd) [r addSubview:myLabel];}
    return r;
}
%end


%hook QFGameController
-(void)animateAlternativesIn
{

    NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:settingsFile];
    if ([[prefs objectForKey:@"glowenable"] boolValue])
    {
        if([altButton1.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton1.layer.shadowColor = [UIColor greenColor].CGColor;
            altButton1.layer.shadowRadius = 5.0f;
            altButton1.layer.shadowOpacity = 1.0f;
            altButton1.layer.shadowOffset = CGSizeZero;
        }
        else if([altButton2.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton2.layer.shadowColor = [UIColor greenColor].CGColor;
            altButton2.layer.shadowRadius = 5.0f;
            altButton2.layer.shadowOpacity = 1.0f;
            altButton2.layer.shadowOffset = CGSizeZero;
        }
        else if([altButton3.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton3.layer.shadowColor = [UIColor greenColor].CGColor;
            altButton3.layer.shadowRadius = 5.0f;
            altButton3.layer.shadowOpacity = 1.0f;
            altButton3.layer.shadowOffset = CGSizeZero;
        }
        else if([altButton4.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton4.layer.shadowColor = [UIColor greenColor].CGColor;
            altButton4.layer.shadowRadius = 5.0f;
            altButton4.layer.shadowOpacity = 1.0f;
            altButton4.layer.shadowOffset = CGSizeZero;
        }
    }

    if ([[prefs objectForKey:@"hideenable"] boolValue])
    {
        if(![altButton1.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton1.hidden=YES;
        }
        else altButton1.hidden=NO;
        
        if(![altButton2.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton2.hidden=YES;
        }
        else altButton2.hidden=NO;
        
        if(![altButton3.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
        {
            altButton3.hidden=YES;
        }
        else altButton3.hidden=NO;
        
        if(![altButton4.titleLabel.text isEqualToString:[answersDict objectForKey:@"currentAnswer"]])
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

-(void)uploadRoundSucceeded:(id)succeeded
{
    %orig;
    hastoadd = 0;
    [myLabel removeFromSuperview];
}
%end


%hook QuestionCardView
+(id)questionCardWithQuestion:(id)question
{
    id r = %orig;

    if(!myLabel)
    {
        myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 43, 300, 24)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
    }

    NSString *answer = [answersDict objectForKey:[question description]];
    [answersDict setObject:answer forKey:@"currentAnswer"];
    hastoadd = 1;
    return r;
}
%end


%hook QFQuestion
+(void)setQuestion:(id)question dict:(id)dict
{
    %orig;
    if(!answersDict) answersDict = [NSMutableDictionary new];
    [answersDict setObject:[dict valueForKey:@"correct"] forKey:[question description]];
}
%end
