@import Foundation;
@import UIKit;

@interface IGDiscoveryNavigationTray : UIView
- (void)setDelegate:(id)delegate;
@end

@interface IGViewController : UIViewController
- (void)searchTitleViewDidRequestSearchPresentation:(id)searchBar;
- (UIView *)scrollView;
@end

@interface IGExploreSeachTitleView : UIView
@end

@interface IGSearchBar : UIView
@end

@interface IGShimmeringGridView : UIView
@end
