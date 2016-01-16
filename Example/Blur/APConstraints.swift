//
//  APConstraints.swift
//  Copyright (c) 2015 Appsidian. All rights reserved.
//

import UIKit

public enum Constraint {
    case LeftToLeftRightToRight
    case LeftToLeft
    case LeftToRight
    case LeftToCenterX
    case RightToRight
    case RightToLeft
    case RightToCenterX
    case TopToTopBottomToBottom
    case TopToTop
    case TopToBottom
    case TopToCenterY
    case BottomToBottom
    case BottomToTop
    case BottomToCenterY
    case CenterXToCenterX
    case CenterXToLeft
    case CenterXToRight
    case CenterYToCenterY
    case CenterYToTop
    case CenterYToBottom
    case Width
    case IntrinsicContentWidth // TODO: Confirm this constraint behaves correctly
    case WidthToHeight
    case Height
    case IntrinsicContentHeight // TODO: Confirm this constraint behaves correctly
    case HeightToWidth
    case Baseline
    case Default
    
    public static let llrr = Constraint.LeftToLeftRightToRight
    public static let ll   = Constraint.LeftToLeft
    public static let lr   = Constraint.LeftToRight
    public static let lcx  = Constraint.LeftToCenterX
    public static let rr   = Constraint.RightToRight
    public static let rl   = Constraint.RightToLeft
    public static let rcx  = Constraint.RightToCenterX
    public static let ttbb = Constraint.TopToTopBottomToBottom
    public static let tt   = Constraint.TopToTop
    public static let tb   = Constraint.TopToBottom
    public static let tcy  = Constraint.TopToCenterY
    public static let bb   = Constraint.BottomToBottom
    public static let bt   = Constraint.BottomToTop
    public static let bcy  = Constraint.BottomToCenterY
    public static let cxcx = Constraint.CenterXToCenterX
    public static let cxl  = Constraint.CenterXToLeft
    public static let cxr  = Constraint.CenterXToRight
    public static let cycy = Constraint.CenterYToCenterY
    public static let cyt  = Constraint.CenterYToTop
    public static let cyb  = Constraint.CenterYToBottom
    public static let w    = Constraint.Width
    public static let iw   = Constraint.IntrinsicContentWidth
    // TODO: Consider making .wh WidthHeight (width and height) and not Width To Height
    public static let wh   = Constraint.WidthToHeight
    public static let h    = Constraint.Height
    public static let ih   = Constraint.IntrinsicContentHeight
    public static let hw   = Constraint.HeightToWidth
    public static let bsln = Constraint.Baseline
    
    init() {
        self = .Default
    }
    
}

public enum DeviceOrientation {
    case Portrait, Landscape
}

public class APConstraint: NSLayoutConstraint {
    var orientation: DeviceOrientation?
}

public extension UIView {
    
    /// Adds multiple subviews to the receiver, in the order specified in the array
    public func addSubviews(subviews: [UIView]) {
        for view in subviews {
            self.addSubview(view)
        }
    }

    /// Applies an array of NSLayoutConstraints to the view, using a multiplier and an offset
    public func constrainUsing(constraints constraints: [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)]) {
        var parent = self.superview!
        
        // Checks if constraining within a TableView/CollectionView cell
        if let superclass: AnyClass? = self.superview?.superview?.superclass {
            if superclass === UICollectionViewCell.self || superclass === UITableViewCell.self {
                parent = self.superview!.superview!
            }
        }
        
        // Remove all existing UIConstraints
        self.removeAllConstraints()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        for constraint in constraints {
            switch constraint.0 {
            case .LeftToLeftRightToRight: // In this case, the LeftToLeft constant remains positive, but the RightToRight constant is made negative making the constant argument an inset margin
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .LeftToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToTopBottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .TopToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Width:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize().width + constraint.1.offset))
            case .WidthToHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Height:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize().height + constraint.1.offset))
            case .HeightToWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Baseline:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Baseline, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Baseline, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Default:
                break
            }
        }
    }
    
    public func constrainUsing(constraints constraints: [Constraint: (of: AnyObject?, offset: CGFloat)]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1.of, CGFloat(1), constraint.1.offset)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    public func constrainUsing(constraints constraints: [Constraint : AnyObject?]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1, 1.0, 0)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    public func fillSuperview() {
        constrainUsing(constraints: [
            .LeftToLeft : (of: self.superview, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self.superview, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self.superview, multiplier: 1.0, offset: 0),
            .BottomToBottom : (of: self.superview, multiplier: 1.0, offset: 0)])
    }
    
    public func centerInSuperview() {
        constrainUsing(constraints: [
            .CenterXToCenterX : (of: self.superview, multiplier: 1.0, offset: 0),
            .CenterYToCenterY : (of: self.superview, multiplier: 1.0, offset: 0)])
    }
    
    public func removeAllConstraints() {
        if let parent = self.superview {
            for constraint in parent.constraints as [NSLayoutConstraint] {
                if constraint.firstItem as? UIView == self {
                    parent.removeConstraint(constraint)
                }
            }
        }
    }
    
    public func updateConstraint(constraint constraint: Constraint, offset: CGFloat) {
        var firstAttribute: NSLayoutAttribute?
        var secondAttribute: NSLayoutAttribute?
        switch constraint {
        case .LeftToLeftRightToRight:
            print("Updating constraint .llrr is not yet supported")
            return
        case .LeftToLeft:
            firstAttribute = .Left; secondAttribute = .Left
        case .LeftToRight:
            firstAttribute = .Left; secondAttribute = .Right
        case .LeftToCenterX:
            firstAttribute = .Left; secondAttribute = .CenterX
        case .RightToRight:
            firstAttribute = .Right; secondAttribute = .Right
        case .RightToLeft:
            firstAttribute = .Right; secondAttribute = .Left
        case .RightToCenterX:
            firstAttribute = .Right; secondAttribute = .CenterX
        case .TopToTopBottomToBottom:
            print("Updating constraint .ttbb is not yet supported")
            return
        case .TopToTop:
            firstAttribute = .Top; secondAttribute = .Top
        case .TopToBottom:
            firstAttribute = .Top; secondAttribute = .Bottom
        case .TopToCenterY:
            firstAttribute = .Top; secondAttribute = .CenterY
        case .BottomToBottom:
            firstAttribute = .Bottom; secondAttribute = .Bottom
        case .BottomToTop:
            firstAttribute = .Bottom; secondAttribute = .Top
        case .BottomToCenterY:
            firstAttribute = .Bottom; secondAttribute = .CenterY
        case .CenterXToCenterX:
            firstAttribute = .CenterX; secondAttribute = .CenterX
        case .CenterXToLeft:
            firstAttribute = .CenterX; secondAttribute = .Left
        case .CenterXToRight:
            firstAttribute = .CenterX; secondAttribute = .Right
        case .CenterYToCenterY:
            firstAttribute = .CenterY; secondAttribute = .CenterY
        case .CenterYToTop:
            firstAttribute = .CenterY; secondAttribute = .Top
        case .CenterYToBottom:
            firstAttribute = .CenterY; secondAttribute = .Bottom
        case .Width:
            firstAttribute = .Width; secondAttribute = .Width
        case .IntrinsicContentWidth:
            print("Updating constraint .iw is not yet supported")
            return
        case .WidthToHeight:
            firstAttribute = .Width; secondAttribute = .Height
        case .Height:
            firstAttribute = .Height; secondAttribute = .Height
        case .HeightToWidth:
            firstAttribute = .Height; secondAttribute = .Width
        case .IntrinsicContentHeight:
            print("Updating constraint .ih is not yet supported")
            return
        case .Baseline:
            firstAttribute = .Baseline; secondAttribute = .Baseline
        case .Default:
            break
        }
        for existingConstraint in self.constraints {
            if existingConstraint.firstAttribute == firstAttribute && existingConstraint.secondAttribute == secondAttribute {
                existingConstraint.constant = offset
            }
        }
        self.setNeedsUpdateConstraints()
    }
    
    public func activateConstraintsForOrientation(orientation: DeviceOrientation) {
        for constraint in self.constraints as! [APConstraint] {
            if constraint.orientation == orientation {
                constraint.active = true
            }
        }
    }
    
    public func deactivateConstraintsForOrientation(orientation: DeviceOrientation) {
        for constraint in self.constraints as! [APConstraint] {
            if constraint.orientation == orientation {
                constraint.active = false
            }
        }
    }
    
    // NOTE: This method is deprecated - use APStackView instead.
    public func spaceHorizontalWithInset(views views: [UIView], inset: UIEdgeInsets) {
        assert(inset.right == inset.left, "Error! Left and Right insets must be equal")
        let parent = self
        parent.layoutIfNeeded()
        var totalWidthOfViews: CGFloat = 0
        for view in views as [UIView] {
            totalWidthOfViews += view.intrinsicContentSize().width
        }
        let padding = (parent.frame.width - totalWidthOfViews - (inset.right + inset.left)) / CGFloat(views.count)
        
        for (index, view) in views.enumerate() {
            view.translatesAutoresizingMaskIntoConstraints = false
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: parent.frame.height))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: view.intrinsicContentSize().width + padding))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: parent, attribute: .CenterY, multiplier: 1.0, constant: inset.top))
            
            if view == views.first! {
                parent.addConstraint(NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: parent, attribute: .Left, multiplier: 1.0, constant: inset.left))
            } else {
                parent.addConstraint(NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: views[index - 1], attribute: .Right, multiplier: 1.0, constant: 0))
            }
        }
    }
    
    
}