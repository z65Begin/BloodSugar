

#import "ZDSearchBar.h"
#import "UIView+Extension.h"

@implementation ZDSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.font = [UIFont systemFontOfSize:16];
//        self.placeholder = @"请输入搜索条件";
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * searchIcon =[UIImageView new];
        searchIcon.image = [UIImage imageNamed:@"ico_search"];
        searchIcon.width = 20;
        searchIcon.height = 20;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.rightView = searchIcon;
        self.rightViewMode = UITextFieldViewModeAlways;
      
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self resignFirstResponder];
    
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}
@end
