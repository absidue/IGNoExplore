#import "Tweak.h"

#define IS_BUNDLE_EQUAL_TO(bundleId) CFEqual(CFBundleGetIdentifier(CFBundleGetMainBundle()), CFSTR(bundleId))


%hook IGViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    if ([NSStringFromClass([self class]) isEqual: @"IGExploreViewController"]) {
        Ivar searchTitleViewIvar = class_getInstanceVariable([%c(IGExploreViewController) class], "_searchTitleView");
        IGExploreSeachTitleView *searchTitleView = (IGExploreSeachTitleView *)object_getIvar(self, searchTitleViewIvar);

        Ivar searchBarIvar = class_getInstanceVariable([%c(IGExploreSeachTitleView) class], "_searchBar");
        IGSearchBar *searchBar = (IGSearchBar *)object_getIvar(searchTitleView, searchBarIvar);

        [self searchTitleViewDidRequestSearchPresentation:searchBar];


        Ivar shimmeringGridViewIvar = class_getInstanceVariable([%c(IGExploreViewController) class], "_shimmeringGridView");
        IGShimmeringGridView *shimmeringGridView = (IGShimmeringGridView *)object_getIvar(self, shimmeringGridViewIvar);

        shimmeringGridView.hidden = YES;
    } else if ([NSStringFromClass([self class]) isEqual: @"IGExploreGridViewController"]) {
        [self scrollView].hidden = YES;
    }
}

%end


%hook IGDiscoveryNavigationTray

- (void)setDelegate:(id)delegate {
    %orig(nil);
    self.hidden = YES;
}

%end


%ctor {
    if (IS_BUNDLE_EQUAL_TO("com.burbn.instagram")) {
        %init;
    }
}
