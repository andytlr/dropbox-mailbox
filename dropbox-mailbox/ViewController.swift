//
//  ViewController.swift
//  dropbox-mailbox
//
//  Created by Andy Taylor on 11/3/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var search: UIImageView!
    
    @IBOutlet weak var swipeyRowView: UIView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var leftIcon: UIImageView!
    
    @IBOutlet weak var rightIcon: UIImageView!
    
    @IBOutlet weak var otherMessages: UIImageView!
    
    var navOpen: Bool = false
    
    let scrollTo: CGPoint = CGPoint(x: 0, y: 79)
    
    let lightGreyColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    let greenColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
    let orangeColor = UIColor(red: 239/255, green: 84/255, blue: 12/255, alpha: 1)
    let yellowColor = UIColor(red: 255/255, green: 211/255, blue: 32/255, alpha: 1)
    let brownColor = UIColor(red: 215/255, green: 166/255, blue: 117/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
        
//        contentView.frame.origin.x += 30
        scrollView.setContentOffset(scrollTo, animated: true)
    }
    
    @IBAction func panMessage(sender: UIPanGestureRecognizer) {
//        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view).x
        let messageMoved = message.frame.origin.x
        
        if sender.state == .Began {

            
        }
        
        if sender.state == .Changed {
            message.frame.origin.x = translation.x
            
            print(messageMoved)
            
            if messageMoved > 60 {
                leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved - 60), 0)
                swipeyRowView.backgroundColor = greenColor
            }
            

            switch messageMoved {
            case 0...60:
                self.swipeyRowView.backgroundColor = self.lightGreyColor
            case -60...0:
                self.swipeyRowView.backgroundColor = self.lightGreyColor
            default:
                return
            }
            
            if messageMoved < -60 {
                rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved + 60), 0)
                swipeyRowView.backgroundColor = yellowColor
            }
        }
        
        if sender.state == .Ended {
            
            if velocity < 0 {
                
            }
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                
                self.message.frame.origin.x = 0
                self.leftIcon.transform = CGAffineTransformMakeTranslation(0, 0)
                self.rightIcon.transform = CGAffineTransformMakeTranslation(0, 0)
                
                }) { (Bool) -> Void in
                    // derp
            }
        }
    }
    
    func openNav() {
        let screenWidth = view.frame.width
        let openX = screenWidth - 52
        let open = CGPoint(x: openX, y: 0.0)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            self.contentView.frame.origin = open
            self.navOpen = true
            self.scrollView.scrollEnabled = false
            }) { (Bool) -> Void in
                // derp
        }
    }
    
    func closeNav() {
        let closed = CGPoint(x: 0.0, y: 0.0)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            self.contentView.frame.origin = closed
            self.navOpen = false
            self.scrollView.scrollEnabled = true
            }) { (Bool) -> Void in
                // derp
        }
    }
    
    func toggleNav() {
        if self.navOpen == false {
            openNav()
        } else {
            closeNav()
        }
    }
    
    @IBAction func tapHamburger(sender: AnyObject) {
        toggleNav()
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
//        let translation = sender.translationInView(view)
        let location = sender.locationInView(view)
        let velocity = sender.velocityInView(view).x
        // jumpAmount is the amount of pan before the gesture recogniser realises you're panning. Subtracting this makes it feel like it's perfectly under your finger.
        let jumpAmount = CGFloat(10.0)
        
        if sender.state == .Began {
            
        }
        
        if sender.state == .Changed {
            contentView.frame.origin.x = location.x - jumpAmount
        }
        
        if sender.state == .Ended {
            if location.x > 44 {
                if velocity > 0 {
                    openNav()
                } else {
                    closeNav()
                }
            } else {
                closeNav()
            }
        }
    }
}

