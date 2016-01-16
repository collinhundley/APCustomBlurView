//
//  APCustomBlurView.swift
//  Created by Collin Hundley on 1/15/16.
//

import UIKit

public class APCustomBlurView: UIVisualEffectView {
    
    private let blurEffect: UIBlurEffect
    public var blurRadius: CGFloat {
        return blurEffect.valueForKeyPath("blurRadius") as! CGFloat
    }
    
    public convenience init() {
        self.init(withRadius: 0)
    }
    
    public init(withRadius radius: CGFloat) {
        let customBlurClass: AnyObject.Type = NSClassFromString("_UICustomBlurEffect")!
        let customBlurObject: NSObject.Type = customBlurClass as! NSObject.Type
        self.blurEffect = customBlurObject.init() as! UIBlurEffect
        self.blurEffect.setValue(1.0, forKeyPath: "scale")
        self.blurEffect.setValue(radius, forKeyPath: "blurRadius")
        super.init(effect: radius == 0 ? nil : self.blurEffect)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setBlurRadius(radius: CGFloat) {
        guard radius != blurRadius else {
            return
        }
        if blurRadius != 0 {
            print("APCustomBlurView warning: Blur view radius should only be animated from  Attempting to animate blur radius more than one time can produce unintended results.")
        }
        blurEffect.setValue(radius, forKeyPath: "blurRadius")
        self.effect = blurEffect
    }
    
}
