#import <substrate.h>
#import <UIKit/UIKit.h>

NSMutableDictionary *myDict;
UILabel *myLabel;
int hastoadd = 0;

%hook QFVC

-(UIView*) contentView
{
UIView* r = %orig;
if(myLabel) { [myLabel setText:[myDict objectForKey:@"currentAnswer"]];
if(hastoadd) [r addSubview:myLabel];}
return r;
}

%end


%hook QFGameController

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

NSString *answer = [myDict objectForKey:[question description]];
[myDict setObject:answer forKey:@"currentAnswer"];
hastoadd = 1;
return r;
}

%end


%hook QFQuestion
+(void)setQuestion:(id)question dict:(id)dict
{
%orig;
if(!myDict) myDict = [NSMutableDictionary new];
[myDict setObject:[dict valueForKey:@"correct"] forKey:[question description]];	
}

%end
