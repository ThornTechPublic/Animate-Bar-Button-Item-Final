//
//  ViewController.swift
//  animateBarButtonItem
//
//  Created by Robert Chen on 8/16/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rightBarButton: UIBarButtonItem! {
        didSet {
            // using image from asset catalog
            let icon = UIImage(named: "star")
            // need the icon size for the button
            let iconSize = CGRect(origin: CGPointZero, size: icon!.size)
            // create a button using the icon size
            let iconButton = UIButton(frame: iconSize)
            // set the button image
            iconButton.setBackgroundImage(icon, forState: .Normal)

            // put the button in the right bar button item
            rightBarButton.customView = iconButton
            // This is to support the initial animation.
            // First stage the button to be microscopic
            rightBarButton.customView!.transform = CGAffineTransformMakeScale(0, 0)
            
            // animate the button to normal size
            UIView.animateWithDuration(1.0,
                delay: 0.5,
                // between 0.0 and 1.0, this is the brakes applied to the bounciness
                usingSpringWithDamping: 0.5,
                // approximate pixels per second you want to explode the button
                initialSpringVelocity: 10,
                options: .CurveLinear,
                animations: {
                    // restore the button to original size.
                    // it may briefly grow past normal size,
                    // depending on how high you set the spring velocity.
                    self.rightBarButton.customView!.transform = CGAffineTransformIdentity
                },
                completion: nil
            )
            
            // custom view breaks the IBAction, so set the target manually
            iconButton.addTarget(self, action: "tappedRightButton", forControlEvents: .TouchUpInside)

        }
    }
    
    override func viewDidLoad() {
        // thanks to didSet on IBOutlet, this viewDidLoad is pretty clean.
    }
    
    func tappedRightButton(){
        println("tapped right button")
        spinTheRightBarButton()
    }

    // spin the star when tapped
    func spinTheRightBarButton(){
        // wind the clock back
        rightBarButton.customView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
        // animate back to original position
        UIView.animateWithDuration(1.0) {
            self.rightBarButton.customView!.transform = CGAffineTransformIdentity
        }
    }
    
}

