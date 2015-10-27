//
//  DetailViewController.h
//  Migration Test
//
//  Created by Vijay on 27/10/15.
//  Copyright © 2015 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

