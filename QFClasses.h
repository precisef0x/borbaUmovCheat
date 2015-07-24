@interface QFButton : UIButton
{
    BOOL _hasClickSound;
    UIImage *_frontImage;
    UIImage *_pressedImage;
    UILabel *_label;
    NSString *_soundName;
    UIImageView *_guardView;
}

+ (id)addCategoryTitleButton:(id)arg1 target:(id)arg2 selector:(SEL)arg3 superview:(id)arg4 placement:(int)arg5 marginX:(float)arg6 marginY:(float)arg7;
@property(retain) UIImageView *guardView; // @synthesize guardView=_guardView;
@property BOOL hasClickSound; // @synthesize hasClickSound=_hasClickSound;
@property(retain) NSString *soundName; // @synthesize soundName=_soundName;
@property(retain) UILabel *label; // @synthesize label=_label;
- (void)setLabelText:(id)arg1;
@property(retain) UIImage *pressedImage; // @synthesize pressedImage=_pressedImage;
@property(retain) UIImage *frontImage; // @synthesize frontImage=_frontImage;
- (void)timerUpdate:(id)arg1 countingUp:(id)arg2;
- (void)hidePercentBar;
- (void)hidePercentView;
- (void)setPercentbarTo:(float)arg1 aboveView:(BOOL)arg2 duration:(float)arg3;
- (void)hideGuardModeAnimation;
- (void)showGuardModeAnimation;
- (void)stopGuardModeAnimation;
- (void)startGuardModeAnimation;
- (float)fontSizeChange;
- (void)hide:(BOOL)arg1;
- (void)buttonReleased;
- (void)buttonPressedDown;
- (id)initWithFrontImage:(id)arg1 andPressedImage:(id)arg2 hasClickSound:(BOOL)arg3;
- (id)initWithFrontImage:(id)arg1 andPressedImage:(id)arg2;

@end


@interface QKCell : UITableViewCell {
    UIImageView* m_selectView;
    UIView* pane;
    id selectDelegate;
}
@property(assign) id selectDelegate;
@property(assign)  UIView* pane;
+(CGRect)cellFrame;
-(void)touchesMoved:(id)moved withEvent:(id)event;
-(void)touchesBegan:(id)began withEvent:(id)event;
-(void)setSelected:(BOOL)selected animated:(BOOL)animated;
-(id)initWithStyle:(int)style reuseIdentifier:(id)identifier bgName:(id)name delegate:(id)delegate;
@end


@interface QFGamesTableViewCell : QKCell {
    UIImageView* m_imageView;
}
-(void)addIconView:(id)view avatar:(id)avatar;

-(id)initSearchUserCell:(id)cell imageName:(id)name row:(int)row nRows:(int)rows hasHeader:(BOOL)header avatarCode:(id)code delegate:(id)delegate;
@end