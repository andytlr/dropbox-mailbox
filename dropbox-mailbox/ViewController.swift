//
//  ViewController.swift
//  dropbox-mailbox
//
//  Created by Andy Taylor on 11/3/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var search: UIImageView!
    
    @IBOutlet weak var swipeyRowView: UIView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var leftIcon: UIImageView!
    
    @IBOutlet weak var rightIcon: UIImageView!
    
    @IBOutlet var messagePanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var otherMessages: UIImageView!
    
    let lightGreyColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    let greenColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
    let orangeColor = UIColor(red: 239/255, green: 84/255, blue: 12/255, alpha: 1)
    let yellowColor = UIColor(red: 255/255, green: 211/255, blue: 32/255, alpha: 1)
    let brownColor = UIColor(red: 215/255, green: 166/255, blue: 117/255, alpha: 1)
    
    var navOpen: Bool = false
    let scrollTo: CGPoint = CGPoint(x: 0, y: 79)
    var action: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        messagePanGestureRecognizer.delegate = self
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
        
//        contentView.frame.origin.x += 30
        scrollView.setContentOffset(scrollTo, animated: true)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
            
            switch messageMoved {
            case 60...220:
                leftIcon.image = UIImage(named: "archive_icon")
                leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved - 60), 0)
                swipeyRowView.backgroundColor = greenColor
                action = "archive"
            case 220...view.frame.width:
                leftIcon.image = UIImage(named: "delete_icon")
                leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved - 60), 0)
                swipeyRowView.backgroundColor = orangeColor
                action = "delete"
            case 0...60:
                leftIcon.image = UIImage(named: "archive_icon")
                self.swipeyRowView.backgroundColor = self.lightGreyColor
                action = ""
            case -60...0:
                rightIcon.image = UIImage(named: "later_icon")
                self.swipeyRowView.backgroundColor = self.lightGreyColor
                action = ""
            case -220...(-60):
                rightIcon.image = UIImage(named: "later_icon")
                rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved + 60), 0)
                swipeyRowView.backgroundColor = yellowColor
                action = "later"
            case (view.frame.width * -1)...(-220):
                rightIcon.image = UIImage(named: "list_icon")
                rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved + 60), 0)
                swipeyRowView.backgroundColor = brownColor
                action = "list"
            default:
                return
            }
        }
        
        if sender.state == .Ended {
            
            func reset() {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                    
                    self.message.frame.origin.x = 0
                    self.leftIcon.transform = CGAffineTransformMakeTranslation(0, 0)
                    self.rightIcon.transform = CGAffineTransformMakeTranslation(0, 0)
                    self.swipeyRowView.backgroundColor = self.lightGreyColor
                    
                    }) { (Bool) -> Void in
                }
            }
            
            switch action {
            case "archive":
                if velocity > 0 {
                    print("ended on Archive")
                    
                    rightIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width
                        self.leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(self.view.frame.width - 60), 0)
                        self.leftIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.frame.origin.y -= self.swipeyRowView.frame.height
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    reset()
                }
            case "delete":
                if velocity > 0 {
                    print("ended on Delete")
                    
                    rightIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width
                        self.leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(self.view.frame.width - 60), 0)
                        self.leftIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.frame.origin.y -= self.swipeyRowView.frame.height
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    reset()
                }
            case "later":
                if velocity < 0 {
                    print("ended on Later")
                    
                    leftIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width * -1
                        self.rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat((self.view.frame.width * -1) + 60), 0)
                        self.rightIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.frame.origin.y -= self.swipeyRowView.frame.height
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    reset()
                }
            case "list":
                if velocity < 0 {
                    print("ended on List")
                    
                    leftIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width * -1
                        self.rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat((self.view.frame.width * -1) + 60), 0)
                        self.rightIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.frame.origin.y -= self.swipeyRowView.frame.height
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    reset()
                }
            case "":
                reset()
            default:
                reset()
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

