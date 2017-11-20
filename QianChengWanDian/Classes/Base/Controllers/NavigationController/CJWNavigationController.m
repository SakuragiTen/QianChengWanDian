//
//  CJWNavigationController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWNavigationController.h"
#import "UIViewController+CJWNavigationExtension.h"

#define kDefaultBackImageName @"backIcon"

#pragma mark - CJWWrapNavigationController

@interface CJWWrapNavigationController : UINavigationController

@end

@implementation CJWWrapNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    CJWNavigationController *cjw_navigationController = viewController.cjw_navigationController;
    NSInteger index = [cjw_navigationController.cjw_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:cjw_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.cjw_navigationController = (CJWNavigationController *)self.navigationController;
    viewController.cjw_fullScreenPopGestureEnabled = viewController.cjw_navigationController.fullScreenPopGestureEnabled;
    UIImage *backButtonImage = viewController.cjw_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    //    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    UIBarButtonItem *leftnegativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    leftnegativeSpacer.width = -6;
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    if ([UIDevice currentDevice].systemVersion.floatValue >=11.0) {
        backBarButton.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        viewController.navigationItem.leftBarButtonItems = @[backBarButton];
    }
    else{
        viewController.navigationItem.leftBarButtonItems = @[leftnegativeSpacer, backBarButton];
    }
    
    /** 自动隐藏tabBar */
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[CJWWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.cjw_navigationController=nil;
}

@end

#pragma mark - CJWWrapViewController

static NSValue *cjw_tabBarRectValue;

@implementation CJWWrapViewController

+ (CJWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    CJWWrapNavigationController *wrapNavController = [[CJWWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    CJWWrapViewController *wrapViewController = [[CJWWrapViewController alloc] init];
    //    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !cjw_tabBarRectValue) {
        cjw_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    if (self.view.subviews.count) {
        UIView *firstView = [self.view.subviews firstObject];
        firstView.frame = [UIScreen mainScreen].bounds;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && cjw_tabBarRectValue) {
        self.tabBarController.tabBar.frame = cjw_tabBarRectValue.CGRectValue;
    }
    if (self.childViewControllers.count && self.view.subviews.count == 0) {
        [self.view addSubview:self.childViewControllers.firstObject.view];
        self.childViewControllers.firstObject.view.frame = [UIScreen mainScreen].bounds;
    }
}

- (BOOL)cjw_fullScreenPopGestureEnabled {
    return [self rootViewController].cjw_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    CJWWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}
- (void)dealloc {
    
}
@end

#pragma mark - CJWNavigationController

@interface CJWNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation CJWNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.cjw_navigationController = self;
        self.viewControllers = @[[CJWWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.cjw_navigationController = self;
        self.viewControllers = @[[CJWWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.cjw_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)cjw_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (CJWWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

@end
