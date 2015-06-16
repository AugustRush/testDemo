//
//  CustomTableViewCell.m
//  ActionTableViewSample
//
//  Created by VANGELI ONTIVEROS on 29/08/14.
//
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *customLabel;



@end

@implementation CustomTableViewCell

@dynamic customText;

- (void)setCustomText:(NSString *)customText{
    self.customLabel.text = customText;
}

- (NSString *)customText{
    
    return self.customLabel.text;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
