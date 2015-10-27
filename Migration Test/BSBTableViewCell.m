//
//  BSBTableViewCell.m
//  Migration Test
//
//  Created by Vijay on 27/10/15.
//  Copyright © 2015 Vijay. All rights reserved.
//

#import "BSBTableViewCell.h"

@implementation BSBTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.messageText setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width -20];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
