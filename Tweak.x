#import "Tweak.h"

#define IS_BUNDLE_EQUAL_TO(bundleId) CFEqual(CFBundleGetIdentifier(CFBundleGetMainBundle()), CFSTR(bundleId))
#define GET_IVAR(className,instance,variable) object_getIvar(instance, class_getInstanceVariable(objc_getClass(#className), #variable))


%hook IGViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    NSString *clazz = NSStringFromClass([self class]);
    if ([clazz isEqualToString:@"IGExploreViewController"]) {
        IGExploreSeachTitleView *searchTitleView = GET_IVAR(IGExploreViewController, self, _searchTitleView);

        IGSearchBar *searchBar = GET_IVAR(IGExploreSeachTitleView, searchTitleView, _searchBar);

        [self searchTitleViewDidRequestSearchPresentation:searchBar];


        IGShimmeringGridView *shimmeringGridView = GET_IVAR(IGExploreViewController, self, _shimmeringGridView);

        shimmeringGridView.hidden = YES;
    } else if ([clazz isEqualToString:@"IGExploreGridViewController"]) {
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
