//
//  MainView.swift
//  Blur
//
//  Created by Collin Hundley on 1/16/16.
//

import UIKit

class MainView: UIView {
    
    let imageView = UIImageView(image: UIImage(named: "background"))
    let blurView = APCustomBlurView()
    let blurSlider = UISlider()
    let blurButton = APSpringButton()
    let exampleColor = UIColor(red: 70 / 255, green: 100 / 255, blue: 170 / 255, alpha: 0.8)
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        // Add Subviews
        addSubviews([imageView, blurView, blurSlider, blurButton])
        
        // Style Subviews
        blurSlider.minimumValue = 0
        blurSlider.maximumValue = 40
        blurSlider.value = 0
        blurSlider.tintColor = exampleColor
        blurSlider.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        blurButton.setTitle("Auto", forState: .Normal)
        blurButton.titleLabel?.font = .systemFontOfSize(20)
        blurButton.backgroundColor = exampleColor
        blurButton.layer.borderColor = UIColor(white: 1, alpha: 0.4).CGColor
        blurButton.layer.borderWidth = 1
        blurButton.layer.cornerRadius = 6
        blurButton.minimumScale = 0.93
        
    }
    
    override func updateConstraints() {
        // Configure Subviews
        configureSubviews()
        
        // Add Constraints
        imageView.fillSuperview()
        
        blurView.fillSuperview()
        
        blurSlider.constrainUsing(constraints: [
            Constraint.ll : (of: self, offset: 25),
            Constraint.rr : (of: self, offset: -25),
            Constraint.cycy : (of: self, offset: 0)])
        
        blurButton.constrainUsing(constraints: [
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: 100),
            Constraint.bt : (of: blurSlider, offset: -15),
            Constraint.h : (of: nil, offset: 50)])
        
        super.updateConstraints()
    }
}
