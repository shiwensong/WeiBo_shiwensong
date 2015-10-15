//
//  TSWeiboCell.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSWeiboCell.h"
#import "WeiboModel.h"
#import "UserModel.h"

#import "WeiboImageView.h"
#import "ToAttributeString.h"

#define ImageWidth (TScreenWidth - 30) / 3
#define ImageSpace 5
#define OtherViewsHeight 125
#define RetOtherViewsHeight 145 // 有转发微博时其他视图的高度


@interface TSWeiboCell ()

@property (strong, nonatomic) NSArray *nibSubViews;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *downButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromPlaceLabel;
@property (weak, nonatomic) IBOutlet UITextView *weiboContentTextView;
@property (weak, nonatomic) IBOutlet UIView *buttomView;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIView *weiboBgImageView;//保存图片的背景View

@property (strong, nonatomic) WeiboImageView *weiboImageView;

/*放置转发微博的View*/
@property (weak, nonatomic) IBOutlet UIView *retweetWeiboBgView;

/*转发微博的TextView*/
@property (weak, nonatomic) IBOutlet UITextView *retweetTextView;

/*转发微薄的图片背景View*/
@property (weak, nonatomic) IBOutlet UIView *reweetImageBgView;

@end

@implementation TSWeiboCell

- (void)awakeFromNib {
    
    self.buttomView.layer.borderColor = [UIColor grayColor].CGColor;
    self.buttomView.layer.borderWidth = 0.5;
    self.weiboContentTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, -4);
    self.retweetTextView.textContainerInset = UIEdgeInsetsMake(0 , -4,  0 , -4);
    
    self.nibSubViews = [[NSBundle mainBundle] loadNibNamed:@"WeiboImageView" owner:self options:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Custom Accessor

- (void)setModel:(WeiboModel *)model{
    _model = model;
    
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_model.user.profile_image_url]];
    self.userNameLabel.text = _model.user.screen_name;
    self.timeLabel.text = _model.created_at;
    self.fromPlaceLabel.text = _model.source;

    self.weiboContentTextView.attributedText = [ToAttributeString attributeStringfromString:_model.text];
    
    if(_model.reposts_count.integerValue > 0){
        [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",(long)[_model.reposts_count integerValue]]  forState:UIControlStateNormal];
    }
    
    if(_model.comments_count.integerValue > 0){
        [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",(long)[_model.comments_count integerValue]]  forState:UIControlStateNormal];
    }
    
    if(_model.attitudes_count.integerValue > 0){
        [self.goodButton setTitle:[NSString stringWithFormat:@"%ld",(long)[_model.attitudes_count integerValue]]  forState:UIControlStateNormal];
    }
    
    [self.weiboImageView removeFromSuperview];
    
    if (_model.pic_urls.count > 0) {
        [self setWeiboImages:model];
    }
    
    [self.retweetWeiboBgView removeFromSuperview];
    
    //如果有转发微博，就执行我们的转发微博的数据填充
    if (model.retweetedWeiboModel != nil){
        self.reweetImageBgView.hidden = NO;
        
        [self retweetWeiboDateFillViews:model];
    }else {
        self.retweetWeiboBgView.hidden = YES;
    }
}

//设置转发微博的数据
- (void)retweetWeiboDateFillViews:(WeiboModel *)model{

    self.retweetTextView.text = model.retweetedWeiboModel.text;
}

//设置我们的图片显示
- (void)setWeiboImages:(WeiboModel *)model{
    
    if (model.pic_urls.count == 0) {
        self.weiboImageView.hidden = YES;
    }else if(model.pic_urls.count == 1){
        self.weiboImageView.hidden = NO;
        
        self.weiboImageView = _nibSubViews[0];
        self.weiboImageView.imageURLs = model.pic_urls;
        self.weiboImageView.width = 150;
        self.weiboImageView.height = 150;
        [self.weiboBgImageView addSubview:self.weiboImageView];
    }else if (_model.pic_urls.count == 4){
        self.weiboImageView.hidden = NO;

        self.weiboImageView = _nibSubViews[1];
        self.weiboImageView.imageURLs = model.pic_urls;
        self.weiboImageView.width = ImageWidth * 2 + ImageSpace;
        self.weiboImageView.height = self.weiboImageView.width;
        [self.weiboBgImageView addSubview:self.weiboImageView];
    }else {
        self.weiboImageView.hidden = NO;

        self.weiboImageView = _nibSubViews[2];
        self.weiboImageView.imageURLs = model.pic_urls;
        self.weiboImageView.width = TScreenWidth - 20;
        self.weiboImageView.height = self.weiboImageView.width;
        [self.weiboBgImageView addSubview:self.weiboImageView];
    }
}


#pragma mark - 根据文本计算cell的高度
+ (CGFloat)tableViewCellRowHeight:(WeiboModel *)model
{
    // 原微博的文本高度
    CGFloat weiboTextHeight = [self weiboTextHeight:model withFontSize:14];
    
    //图片视图的高度
    CGFloat imagesHeight = [self weiboImagesHeight:model];
    
    // 其他视图的总高度
    CGFloat otherViewsHeight = OtherViewsHeight;
    
    // 转发微博的文本高度
    CGFloat retWeiboTextHeight = 0;
    if (model.retweetedWeiboModel != nil) {
        
        retWeiboTextHeight = [self weiboTextHeight:model.retweetedWeiboModel withFontSize:13];
        imagesHeight = [self weiboImagesHeight:model.retweetedWeiboModel];
        otherViewsHeight = RetOtherViewsHeight;
    }
    
    return  otherViewsHeight + weiboTextHeight + retWeiboTextHeight + imagesHeight;
}

// 计算微博文本的高度
+ (CGFloat)weiboTextHeight:(WeiboModel *)model withFontSize:(CGFloat)fontSize
{
    CGRect textRect = [model.text boundingRectWithSize:CGSizeMake(TScreenWidth - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil];
    
    return ceil(textRect.size.height);
}

// 计算微博图片视图的高度
+ (CGFloat)weiboImagesHeight:(WeiboModel *)model
{
    CGFloat imageCount = model.pic_urls.count;
    if (imageCount == 0) {
        return 0;
        
    }else if (imageCount == 1) {
        return 150;
        
    } else if (imageCount <= 3) {
        return ImageWidth;
        
    } else if (imageCount > 3 && imageCount < 7) {
        return ImageWidth * 2 + ImageSpace;
    }
    
    return ImageWidth * 3 + ImageSpace * 2;
}


@end
