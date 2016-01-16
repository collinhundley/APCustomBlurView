//
//  CustomBlurView.swift
//  Created by Collin Hundley on 1/15/16.
//

import UIKit

public class CustomBlurView: UIVisualEffectView {
    
    private let blurEffect: UIBlurEffect
    private var blurRadius: CGFloat
    
    public convenience init() {
        self.init(withRadius: 0)
    }
    
    public init(withRadius radius: CGFloat) {
        let customBlurClass: AnyObject.Type = NSClassFromString("_UICustomBlurEffect")!
        let customBlurObject: NSObject.Type = customBlurClass as! NSObject.Type
        self.blurEffect = customBlurObject.init() as! UIBlurEffect
        self.blurEffect.setValue(1.0, forKeyPath: "scale")
        self.blurEffect.setValue(radius, forKeyPath: "blurRadius")
        self.blurRadius = radius
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
            print("CustomBlurView warning: Attempting to animate blur radius more than one time can produce unintended results.")
        }
        blurRadius = radius
        blurEffect.setValue(radius, forKeyPath: "blurRadius")
        self.effect = blurEffect
    }
    
}
