//
//  LGTabBarView.m
//  lvgouProjectIphone
//
//  Created by lvgou on 13-12-18.
//  Copyright (c) 2013年 lvgou. All rights reserved.
//

#import "LGTabBarView.h"
#import "UIUtils.h"

@implementation LGTabBarView

#pragma mark - 初始化Tab -
/**
 *  初始化Tab
 *
 *  @param frame 位置信息
 *
 *  @return 无
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        if(iPhone5)
        {
            [self setFrame:CGRectMake(0, 568 - 49, 320, 49)];
        }
        else
        {
            [self setFrame:CGRectMake(0, 480 - 49, 320, 49)];
        }
        
        UIImageView *imageView_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 71)];
        //[SKUIUtils didLoadImageNotCached:@"tabBar_background.png" inImageView:imageView_background];
        [self addSubview:imageView_background];
        
        UIButton *button_first = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button_two = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button_three = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button_four = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button_first setFrame:CGRectMake(20, 5 + 22, 40, 40)];
        [button_two setFrame:CGRectMake(button_first.frame.origin.x + button_first.frame.size.width + 40, button_first.frame.origin.y, button_first.frame.size.width, button_first.frame.size.height)];
        [button_three setFrame:CGRectMake(button_two.frame.origin.x + button_two.frame.size.width + 40, button_two.frame.origin.y, button_first.frame.size.width, button_two.frame.size.height)];
        [button_four setFrame:CGRectMake(button_three.frame.origin.x + button_three.frame.size.width + 30, button_three.frame.origin.y - 22, button_first.frame.size.width + 20, button_three.frame.size.height + 20)];
        
        /*[SKUIUtils didLoadImageNotCached:@"image10pressed.png" inButton:button_first withState:UIControlStateNormal];
        [SKUIUtils didLoadImageNotCached:@"image10.png" inButton:button_first withState:UIControlStateHighlighted];
        [SKUIUtils didLoadImageNotCached:@"image12.png" inButton:button_two withState:UIControlStateNormal];
        [SKUIUtils didLoadImageNotCached:@"image12pressed.png" inButton:button_two withState:UIControlStateHighlighted];
        [SKUIUtils didLoadImageNotCached:@"image11.png" inButton:button_three withState:UIControlStateNormal];
        [SKUIUtils didLoadImageNotCached:@"image11pressed.png" inButton:button_three withState:UIControlStateHighlighted];
        [SKUIUtils didLoadImageNotCached:@"image13.png" inButton:button_four withState:UIControlStateNormal];
        [SKUIUtils didLoadImageNotCached:@"image13pressed.png" inButton:button_four withState:UIControlStateHighlighted];*/
        
        //[button_first setShowsTouchWhenHighlighted:YES];
        //[button_two setShowsTouchWhenHighlighted:YES];
        //[button_three setShowsTouchWhenHighlighted:YES];
        
        [button_first setTag:10];
        [button_two setTag:12];
        [button_three setTag:11];
        [button_four setTag:13];
        
        _integer_before = button_first.tag;
        
        
        //UIImageView *imageView_animation = [[UIImageView alloc] initWithFrame:button_two.frame];
        //[SKUIUtils didLoadImageNotCached:@"animetionRound.png" inImageView:imageView_animation];
        //[imageView_animation setTag:20];
        //[self addSubview:imageView_animation];
        
        [button_first addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
        [button_two addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
        [button_three addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
        [button_four addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button_first];
        [self addSubview:button_two];
        [self addSubview:button_three];
        [self addSubview:button_four];
        
        //UIImageView *imageView_count = [[UIImageView alloc] initWithFrame:CGRectMake(58, 4, 15, 15)];
        //[SKUIUtils didLoadImageNotCached:@"image_count.png" inImageView:imageView_count];
        //[imageView_count setTag:30];
        //[button_three addSubview:imageView_count];
        //[imageView_count setHidden:YES];
        
        //UILabel *label_count = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, 15, 15)];
        //[label_count setTextAlignment:NSTextAlignmentCenter];
        //[label_count setBackgroundColor:[UIColor clearColor]];
        //[imageView_count addSubview:label_count];
        //[label_count setFont:[UIFont systemFontOfSize:11.0f]];
        //[label_count setTextColor:[UIColor whiteColor]];
        //[label_count setTag:31];
        
        // Initialization code
        
#pragma mark - 四按钮写法 -
        /*  if([UIScreen mainScreen].currentMode.size.width == 320)
         {
         [self setFrame:CGRectMake(0, [UIScreen mainScreen].currentMode.size.height - 49, [UIScreen mainScreen].currentMode.size.width, 49)];
         }
         else
         {
         [self setFrame:CGRectMake(0, [UIScreen mainScreen].currentMode.size.height/2 - 49, [UIScreen mainScreen].currentMode.size.width/2, 49)];
         }
         
         //UIImageView *imageView_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
         //[SKUIUtils didLoadImageNotCached:@"tabBar_background.png" inImageView:imageView_background];
         //[self addSubview:imageView_background];
         
         UIButton *button_first = [UIButton buttonWithType:UIButtonTypeCustom];
         UIButton *button_two = [UIButton buttonWithType:UIButtonTypeCustom];
         UIButton *button_three = [UIButton buttonWithType:UIButtonTypeCustom];
         UIButton *button_four = [UIButton buttonWithType:UIButtonTypeCustom];
         
         [button_first setFrame:CGRectMake(0, 0, 80, 49)];
         [button_two setFrame:CGRectMake(button_first.frame.origin.x + button_first.frame.size.width , button_first.frame.origin.y, button_first.frame.size.width, button_first.frame.size.height)];
         [button_three setFrame:CGRectMake(button_two.frame.origin.x + button_two.frame.size.width, button_two.frame.origin.y, button_first.frame.size.width, button_two.frame.size.height)];
         [button_four setFrame:CGRectMake(button_three.frame.origin.x + button_three.frame.size.width, button_three.frame.origin.y, button_first.frame.size.width, button_three.frame.size.height)];
         
         [button_first setImage:[UIImage imageFileName:@"0.png"] forState:UIControlStateNormal];
         [button_first setImage:[UIImage imageFileName:@"0_s.png"] forState:UIControlStateHighlighted];
         [button_first setImage:[UIImage imageFileName:@"0_s.png"] forState:UIControlStateSelected];
         button_first.selected = YES;
         button_first.userInteractionEnabled = NO;
         
         [button_two setBackgroundImage:[UIImage imageFileName:@"1.png"] forState:UIControlStateNormal];
         [button_two setBackgroundImage:[UIImage imageFileName:@"1_s.png"] forState:UIControlStateHighlighted];
         [button_two setBackgroundImage:[UIImage imageFileName:@"1_s.png"] forState:UIControlStateSelected];
         button_two.adjustsImageWhenHighlighted = NO;
         
         [button_three setBackgroundImage:[UIImage imageFileName:@"2.png"] forState:UIControlStateNormal];
         [button_three setBackgroundImage:[UIImage imageFileName:@"2_s.png"] forState:UIControlStateHighlighted];
         [button_three setBackgroundImage:[UIImage imageFileName:@"2_s.png"] forState:UIControlStateSelected];
         button_three.adjustsImageWhenHighlighted = NO;
         
         [button_four setBackgroundImage:[UIImage imageFileName:@"3.png"] forState:UIControlStateNormal];
         [button_four setBackgroundImage:[UIImage imageFileName:@"3_s.png"] forState:UIControlStateHighlighted];
         [button_four setBackgroundImage:[UIImage imageFileName:@"3_s.png"] forState:UIControlStateSelected];
         button_four.adjustsImageWhenHighlighted = NO;
         
         [button_first setTag:0];
         [button_two setTag:1];
         [button_three setTag:2];
         [button_four setTag:3];
         
         [button_first addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
         [button_two addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
         [button_three addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
         [button_four addTarget:self action:@selector(didClickButton_tab:) forControlEvents:UIControlEventTouchUpInside];
         
         [self addSubview:button_first];
         [self addSubview:button_two];
         [self addSubview:button_three];
         [self addSubview:button_four];
         
         _button_before = button_first; */
    }
    return self;
}

#pragma mark - 点击Tab -
/**
 *  点击Tab
 *
 *  @param button_tag 标签值
 */
- (void)didClickButton_tab:(UIButton *)button_tag
{
    if(button_tag.tag == 13)
    {
        [_delegate delegate_didClickButton_tab:button_tag.tag - 10];
        return;
    }
    _integer_now = button_tag.tag;
    //UIImageView *imageView_animetion = (UIImageView *)[self viewWithTag:20];
    //imageView_animetion.alpha = 1.0;
    //UIButton *button_before = (UIButton *)[self viewWithTag:_integer_before];
    //[SKUIUtils didLoadImageNotCached:[NSString stringWithFormat:@"image%d.png",_integer_before] inButton:button_before withState:UIControlStateNormal];
    //[SKUIUtils didLoadImageNotCached:[NSString stringWithFormat:@"image%dpressed.png",_integer_before] inButton:button_before withState:UIControlStateHighlighted];
    //[SKUIUtils didLoadImageNotCached:[NSString stringWithFormat:@"image%dpressed.png",_integer_now] inButton:button_tag withState:UIControlStateNormal];
    //[SKUIUtils didLoadImageNotCached:[NSString stringWithFormat:@"image%d.png",_integer_now] inButton:button_tag withState:UIControlStateHighlighted];
    
    /*[UIView animateWithDuration:0.2f animations:
     ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [imageView_animetion setCenter:button_tag.center];
        [UIView commitAnimations];
     }completion:^(BOOL finish){if(finish){
         [UIView animateWithDuration:1.5f animations:^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationTransition:UIViewAnimationTransitionNone forView: self cache:NO];
                imageView_animetion.alpha = 0.0;
                imageView_animetion.frame = CGRectMake(imageView_animetion.frame.origin.x- 40, imageView_animetion.frame.origin.y - 15, imageView_animetion.frame.size.width + 85 , imageView_animetion.frame.size.height + 40);
              [UIView commitAnimations];
         } completion:^(BOOL finish)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 imageView_animetion.alpha = 1.0;
                 imageView_animetion.frame = CGRectMake(imageView_animetion.frame.origin.x + 41, imageView_animetion.frame.origin.y + 15, imageView_animetion.frame.size.width - 85, imageView_animetion.frame.size.height - 40);}];
         }];
        }}];*/

    _integer_before = _integer_now;
    [_delegate delegate_didClickButton_tab:_integer_now - 10];
    //NSLog(@"%d",button_tag.tag);
}


#pragma mark - 四个按钮点击事件 -
#pragma mark - 点击Tab -
/**
 *  点击Tab
 *
 *  @param button_tag 标签值
 */

/*- (void)didClickButton_tab:(UIButton *)button
{
    if(button.tag == _button_before.tag){
        return;
    }
    else{
        _button_before.userInteractionEnabled = YES;
        button.userInteractionEnabled = NO;
        
        button.selected = YES;
        _button_before.selected = NO;
        [_delegate delegate_didClickButton_tab:button.tag];
        _button_before = button;
    }
}*/

@end
