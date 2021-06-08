#import "Tweak.h"

#define IS_BUNDLE_EQUAL_TO(bundleId) CFEqual(CFBundleGetIdentifier(CFBundleGetMainBundle()), CFSTR(bundleId))
#define GET_IVAR(className,instance,variable) object_getIvar(instance, class_getInstanceVariable(objc_getClass(#className), #variable))


Class class_IGExploreViewController;
Class class_IGExploreGridViewController;


%hook IGViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    Class clazz = [self class];
    if (clazz == class_IGExploreViewController) {
        IGExploreSeachTitleView *searchTitleView = GET_IVAR(IGExploreViewController, self, _searchTitleView);

        IGSearchBar *searchBar = GET_IVAR(IGExploreSeachTitleView, searchTitleView, _searchBar);

        [self searchTitleViewDidRequestSearchPresentation:searchBar];


        IGShimmeringGridView *shimmeringGridView = GET_IVAR(IGExploreViewController, self, _shimmeringGridView);

        shimmeringGridView.hidden = YES;
    } else if (clazz == class_IGExploreGridViewController) {
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
        class_IGExploreViewController = objc_getClass("IGExploreViewController");
        class_IGExploreGridViewController = objc_getClass("IGExploreGridViewController");
        %init;
    }
}
