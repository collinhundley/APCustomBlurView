# APCustomBlurView
A subclass of UIVisualEffectView with customizable blur radius

##### Disclaimer
APCustomBlurView utilizes a private UIKit API to do its magic. It is intended for **internal use only.** Use caution; submitting this code to the App Store adds the risk of being rejected!

### What It Is

We all love transparency, and UIBlurEffect makes it easy to build beautiful, glassy overlays. But sometimes we need more customization options: most notably, control over the amount of blur applied to a view. That's where APCustomBlurView comes in!

This is a subclass of UIVisualEffectView, with the ability to control the `blurRadius` of the effect. This property can be changed at any time, and is even animatable. See for yourself:

(Example project included in repository)

![auto.gif](https://github.com/collinhundley/APCustomBlurView/blob/master/SiteAssets/auto.gif?raw=true)
![slider.gif](https://github.com/collinhundley/APCustomBlurView/blob/master/SiteAssets/slider.gif?raw=true)

Note: Color banding is a compression artifact from the gifs. Actual blurs render smoothly.

### Usage

For the most part, you use APCustomBlurView the same way you use UIVisualEffectView. If you're not familiar with it, check out Apple's [documentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/index.html#//apple_ref/doc/uid/TP40014528).

**Initialization**

You can create a view using the empty initializer, which will start with no blur:

    let blurView = APCustomBlurView()

Or, you can intialize with a specific blur radius:

    let blurView = APCustomBlurView(withRadius: 15)

**Modification**

In addition to UIVisualEffectView's normal properties, APCustomBlurView provides a method for modifying the `blurRadius` at any time:

    blurView.setBlurRadius(25)

That's *much* easier than learning OpenGL! You can also use it inside an animation block:

    UIView.animateWithDuration(0.5) {
        blurView.setBlurRadius(25)
    }

### Compatibility

APCustomBlurView is compatible with iOS 8.0 and above, and all versions of tvOS.

If you didn't read the disclaimer at the top of this page, **do it now!**  I don't recommend using this class in an app that you plan to submit for review, but it's really great for building personal apps and proofs-of-concept. My hope is that the next version of iOS will render this class obsolete.


#### Note:
The iOS Simulator doesn't like transparency. If you get strange results (flickering, lag, etc), run it on a real device and everything should work beautifully.
