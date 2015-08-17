//
// The MIT License (MIT)
//
// Copyright (c) 2013 Backelite
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

/**
 * Object to customize blurry background
 */
@interface BDBlurParameters : NSObject
/**
 *  Property to customize background view alpha.
 */
@property (assign, nonatomic) CGFloat alpha;
/**
 *  Property to customize background view blur radius.
 */
@property (assign, nonatomic) CGFloat radius;
/**
 *  Property to customize background view blur saturation factor.
 *  A value of 1.0 is neutral. Below it is desaturated and above it is more saturated.
 */
@property (assign, nonatomic) CGFloat saturationDeltaFactor;
/**
 *  Property to customize blur tint color. Default is clear color.
 */
@property (strong, nonatomic) UIColor *tintColor;

@end

/**
 *  Transition styles available when presenting popin view controllers.
 *  @since v1.0
 */
typedef NS_ENUM(NSInteger, BDPopinTransitionStyle) {
    /**
     *  When the view controller is presented, its view slide in the parent view controller and slide out on dismiss
     */
    BDPopinTransitionStyleSlide,
    /**
     *  When the view controller is presented, its view fade in and fade out on dismiss. Transition direction is ignored for this kind of transition.
     */
    BDPopinTransitionStyleCrossDissolve,
    /**
     *  When the view controller is presented, its view fade in with a zoom out effect and fade out with a zoom in effect on dismiss. Transition direction is ignored for this kind of transition.
     */
    BDPopinTransitionStyleZoom,
    /**
     *  When the view controller is presented, its view slide in with a bounce effect and slide out on dismiss.
     */
    BDPopinTransitionStyleSpringySlide,
    /**
     *  When the view controller is presented, its view zoom and fade in with a bounce effect. Transition direction is ignored for this kind of transition.
     */
    BDPopinTransitionStyleSpringyZoom,
    /**
     *  When the view controller is presented, its view has a undefined behavior.
     */
    //UIDynamics transition styles
    BDPopinTransitionStyleSnap,
    /**
     *  When the view controller is presented, its view has a custom animation.
     */
    BDPopinTransitionStyleCustom
};

/**
 *  Transition direction when presenting popins. Default is BDPopinTransitionDirectionBottom.
 *  @since v1.0
 */
typedef NS_ENUM(NSInteger, BDPopinTransitionDirection) {
    /**
     *  Presentation transition will start from the bottom of the parent view. Respectively, dismiss transition will end to the bottom of the parent view.
     */
    BDPopinTransitionDirectionBottom = 0,
    /**
     *  Presentation transition will start from the top of the parent view. Respectively, dismiss transition will end to the top of the parent view.
     */
    BDPopinTransitionDirectionTop,
    /**
     *  Presentation transition will start from the left of the parent view. Respectively, dismiss transition will end to the left of the parent view.
     */
    BDPopinTransitionDirectionLeft,
    /**
     *  Presentation transition will start from the right of the parent view. Respectively, dismiss transition will end to the right of the parent view.
     */
    BDPopinTransitionDirectionRight
};

/**
 *  Options to configure popin behavior to user related events. The following options are compoundables.
 *  @since v1.0
 */
typedef NS_OPTIONS(NSUInteger, BDPopinOption) {
    /**
     *  Default behaviour
     */
    BDPopinDefault = 0,
    /**
     *  Disable popin reaction to keyboard notifications
     */
    BDPopinIgnoreKeyboardNotification = 1 << 0,
    /**
     *  Disable auto dismiss when touching outside of the popin view
     */
    BDPopinDisableAutoDismiss = 1 << 1,
    /**
     *  Takes a screenshot of presenting view, blurs it and uses it as dimming view. Available only on ios 7.x.
     */
    BDPopinBlurryDimmingView = 1 << 2,
    /**
     *  Disable parallax effect on iOS7
     */
    BDPopinDisableParallaxEffect = 1 << 3,
    /**
     *  Set a background dimming view with a clear color. Default is a semi-transparent black background
     */
    BDPopinDimmingViewStyleNone = 1 << 16,
};

/**
 *  Options to quickly configure popin alignment in its container. Default is centered.
 *  @see -popinAlignement
 *  @since v1.3
 */
typedef NS_ENUM(NSInteger, BDPopinAlignementOption) {
    /**
     *  Popin will be centered in container
     */
    BDPopinAlignementOptionCentered = 0,
    /**
     *  Popin will be stuck to top in container
     */
    BDPopinAlignementOptionUp       = 1,
    /**
     *  Popin will be left-aligned in container
     */
    BDPopinAlignementOptionLeft     = 2,
    /**
     *  Default will be stuck to bottom in container
     */
    BDPopinAlignementOptionDown     = 3,
    /**
     *  Popin will be right-aligned in container
     */
    BDPopinAlignementOptionRight    = 4
};

/**
 * `BDPopin` is a category allowing modal-like presentation of view controllers but with more configuration options.
 * Configuration options include popin size, transition style, transition direction, response to keyboard notifications and auto dismiss.
 * @since v1.0
 */
@interface UIViewController (BDPopin) <UIDynamicAnimatorDelegate>

///---------------------
/// @name Presentation and dismiss
///---------------------

/**
 *  Present a popin controller as a child of the receiver. By default the popin keep its size when presented. If it is bigger than parent controller, the popin is resized to fit inside its parent.
 *
 *  @param popinController The controller to present as a popin.
 *  @param animated        Pass `YES` to animate the presentation. Otherwise, pass `NO`.
 *  @param completion      A completion handler, or `NULL`.
 *  @see -presentPopinController:fromRect:animated:completion:
 *  @since v1.0
 */
- (void)presentPopinController:(UIViewController *)popinController animated:(BOOL)animated
                    completion:(void(^)(void))completion;

/**
 *  Present a popin controller as a child of the receiver, centered inside an arbitrary rect.
 *
 *  @param popinController The controller to present as a popin.
 *  @param rect            An arbitrary rect in which the popin should be centered.
 *  @param animated        Pass `YES` to animate the presentation. Otherwise, pass `NO`.
 *  @param completion      A completion handler, or `NULL`.
 *  @since v1.0
 */
- (void)presentPopinController:(UIViewController *)popinController fromRect:(CGRect)rect animated:(BOOL)animated
                    completion:(void(^)(void))completion;

/**
 *  Dismiss the visible popin if any.
 *
 *  @param animated Pass `YES` to animate the dismiss. Otherwise, pass `NO`.
 *  @see dismissCurrentPopinControllerAnimated:completion:
 *  @since v1.0
 */
- (void)dismissCurrentPopinControllerAnimated:(BOOL)animated;

/**
 *  Dismiss the visible popin if any.
 *
 *  @param animated   Pass `YES` to animate the dismiss. Otherwise, pass `NO`.
 *  @param completion A completion handler, or `NULL`.
 *  @since v1.0
 */
- (void)dismissCurrentPopinControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

///---------------------
/// @name Properties accessors
///---------------------

/**
 *  A reference to the popin presented as a child controller.
 *
 *  @return The controller presented as a popin or `nil`.
 *  @see -presentingPopinViewController
 *  @since v1.0
 */
- (UIViewController *)presentedPopinViewController;

/**
 *  A reference to the parent presenting the popin.
 *
 *  @return The controller presenting the popin, or `nil`.
 *  @see -presentedPopinViewController
 *  @since v1.0
 */
- (UIViewController *)presentingPopinViewController;

/**
 *  Get desired size for popin.
 *
 *  @return The desired size for this controller when presented as a popin. Or `CGSizeZero` if not set.
 *  @see -setPreferedPopinContentSize:
 *  @since v1.0
 */
- (CGSize)preferedPopinContentSize;

/**
 *  Set the desired size for popin. This value may not be respected if popin is bigger than the presenting controller view.
 *  If not set, the default size will be the controller view size.
 *
 *  @param preferredSize The desired size for this controller when presented as a popin.
 *  @since v1.0
 */
- (void)setPreferedPopinContentSize:(CGSize)preferredSize;

/**
 *  The transition style to use when presenting a popin. Default value is `BDPopinTransitionStyleSlide`.
 *
 *  @return A BDPopinTransitionStyle value.
 *  @see -setPopinTransitionStyle:
 *  @since v1.0
 */
- (BDPopinTransitionStyle)popinTransitionStyle;

/**
 *  The transition style to use when presenting a popin. For a list of possible transition style, see `BDPopinTransitionStyle`.
 *
 *  @param transitionStyle A BDPopinTransitionStyle value.
 *  @since v1.0
 */
- (void)setPopinTransitionStyle:(BDPopinTransitionStyle)transitionStyle;

/**
 *  The transition direction to use when presenting a popin. Default value is `BDPopinTransitionDirectionBottom`.
 *
 *  @return A BDPopinTransitionDirection value.
 *  @see -setPopinTransitionDirection:
 *  @since v1.0
 */
- (BDPopinTransitionDirection)popinTransitionDirection;

/**
 *  The transition direction to use when presenting a popin. For a list of possible transition direction, see BDPopinTransitionDirection
 *
 *  @param transitionDirection A BDPopinTransitionDirection value.
 *  @since v1.0
 */
- (void)setPopinTransitionDirection:(BDPopinTransitionDirection)transitionDirection;

/**
 *  The options to apply to the popin. Default value is `BDPopinDefault`.
 *
 *  @return The BDPopinOption values as a bit field.
 *  @see -setPopinOptions:
 *  @since v1.0
 */
- (BDPopinOption)popinOptions;

/**
 *  The options to apply to the popin. For a list of possible options, see BDPopinOption
 *
 *  @param popinOptions The BDPopinOption values separated by | character.
 *  @since v1.0
 */
- (void)setPopinOptions:(BDPopinOption)popinOptions;


/**
 *  Get the custom in animation block. Default value is nil.
 *
 *  @return The In animation block.
 *  @see -setPopinCustomInAnimation:
 *  @since v1.3
 */
- (void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))popinCustomInAnimation;

/**
 *  The popinCustomAnimation let you pass an custom in animation. The popInController frame must be the finalFrame in the end of the animation.
 *
 *  @param customInAnimation The Block with animation.
 *  @since v1.3
 */
- (void)setPopinCustomInAnimation:(void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))customInAnimation;

/**
 *  Get the custom out animation block. Default value is nil.
 *
 *  @return The Out animation block.
 *  @see -setPopinCustomOutAnimation:
 *  @since v1.3
 */
- (void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))popinCustomOutAnimation;

/**
 *  The popinCustomOutAnimation let's you pass an custom out animation. The popInController frame must be the finalFrame in the end of the animation.
 *
 *  @param customOutAnimation The Block with animation.
 *  @since v1.3
 */
- (void)setPopinCustomOutAnimation:(void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))customOutAnimation;

/**
 *  The options to apply to the popin. Default value is `BDPopinAlignementOptionCentered`.
 *
 *  @return The BDPopinAlignementOption values as a bit field.
 *  @see -setPopinAlignement:
 *  @since v1.3
 */
- (BDPopinAlignementOption)popinAlignment;

/**
 *  The options to apply to the popin. For a list of possible options, see BDPopinAlignementOption
 *
 *  @param popinAlignement The BDPopinAlignementOption values separated by | character.
 *  @since v1.3
 */
- (void)setPopinAlignment:(BDPopinAlignementOption)popinAlignment;

/**
 *  An object used to configure the blurred background.
 *
 *  @return The blur parameters object.
 *  @see -setBlurParameters:
 *  @since v1.4
 */
- (BDBlurParameters *)blurParameters;

/**
 *  An object used to configure the blurred background.
 *
 *  @param blurParameters The blur parameters object.
 *  @sicne v1.4
 */
- (void)setBlurParameters:(BDBlurParameters *)blurParameters;

@end
