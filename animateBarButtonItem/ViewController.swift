//
//  ViewController.swift
//  animateBarButtonItem
//
//  Created by Robert Chen on 8/16/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animateTheRightBarButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func starTapped(sender: AnyObject) {
        println("star tapped")
    }
    
    func tappedRightButton(){
        println("tapped right button")
    }

    // makes the right bar button "pop"
    func animateTheRightBarButton(){
        // using image from asset catalog
        let icon = UIImage(named: "star")
        // need the icon size for the button
        let iconSize = CGRect(origin: CGPointZero, size: icon!.size)
        // create a button using the icon size
        let iconButton = UIButton(frame: iconSize)
        // set the button image
        iconButton.setBackgroundImage(icon, forState: .Normal)
        // custom view breaks the IBAction, so set the target manually
        iconButton.addTarget(self, action: "tappedRightButton", forControlEvents: .TouchUpInside)
        // put the button in the right bar button item
        rightBarButton.customView = iconButton
        // stage the button to be microscopic
        rightBarButton.customView!.transform = CGAffineTransformMakeScale(0, 0)
        
        // animate the button to normal size
        UIView.animateWithDuration(2.0,
            delay: 0.5,
            // between 0.0 and 1.0, this is the brakes applied to the bounciness
            usingSpringWithDamping: 0.5,
            // approximate pixels per second you want to explode the button
            initialSpringVelocity: 10,
            options: .CurveLinear,
            animations: {
                // restore the button to original size.
                // it may briefly grow past the original size,
                // depending on how high you set the spring velocity.
                self.rightBarButton.customView!.transform = CGAffineTransformIdentity
            },
            completion: nil
        )
    }
    
}

