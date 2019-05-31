//
//  LWHomeHotInforListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomeHotInforListTableViewCell.h"
@interface LWHomeHotInforListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pic;

@end
@implementation LWHomeHotInforListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = HYCOLOR.color_c1;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self = [[NSBundle mainBundle] loadNibNamed:@"LWHomeHotInforListTableViewCell" owner:self options:nil].firstObject;
    }
    return self;
}

- (void)setHotModel:(HYHomePageHotModel *)hotModel
{
    _hotModel = hotModel;
    [_pic sd_setImageWithURL:[NSURL URLWithString:hotModel.pics] placeholderImage:[UIImage imageNamed:@"占位图-200_200"]];
}

@end
