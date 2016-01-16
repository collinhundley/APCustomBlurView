//
//  MainViewController.swift
//  Blur
//
//  Created by Collin Hundley on 1/16/16.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.blurButton.addTarget(self, action: "buttonTapped", forControlEvents: .TouchUpInside)
        mainView.blurSlider.addTarget(self, action: "sliderMoved:", forControlEvents: .ValueChanged)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func buttonTapped() {
        let radius: CGFloat = mainView.blurView.blurRadius == 0 ? 15 : 0
        UIView.animateWithDuration(0.5) {
            self.mainView.blurView.setBlurRadius(radius)
        }
        let title = mainView.blurButton.titleLabel?.text == "Blur" ? "Un-blur" : "Blur"
        mainView.blurButton.setTitle(title, forState: .Normal)
    }
    
    func sliderMoved(slider: UISlider) {
        mainView.blurView.setBlurRadius(CGFloat(slider.value))
    }
    
}
