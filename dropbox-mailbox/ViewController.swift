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
    
    @IBOutlet weak var rescheduleView: UIView!
    
    @IBOutlet weak var search: UIImageView!
    
    @IBOutlet weak var swipeyRowView: UIView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var leftIcon: UIImageView!
    
    @IBOutlet weak var rightIcon: UIImageView!
    
    @IBOutlet var messagePanGestureRecognizer: UIPanGestureRecognizer!
    
    var edgeGesture: UIScreenEdgePanGestureRecognizer!
    
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
        
        edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        messagePanGestureRecognizer.delegate = self
        
        rescheduleView.alpha = 0
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
        
//        contentView.frame.origin.x += 30
        scrollView.setContentOffset(scrollTo, animated: true)
    }
    
    func resetMessage() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            self.message.frame.origin.x = 0
            self.leftIcon.transform = CGAffineTransformMakeTranslation(0, 0)
            self.rightIcon.transform = CGAffineTransformMakeTranslation(0, 0)
            self.swipeyRowView.backgroundColor = self.lightGreyColor
            self.leftIcon.alpha = 1
            self.rightIcon.alpha = 1
            self.otherMessages.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }) { (Bool) -> Void in
        }
    }
    
    override func motionBegan(motion: UIEventSubtype,
        withEvent event: UIEvent?) {
            
            if action != "" {
                let alertController = UIAlertController(title: "Undo \(action)?", message: nil, preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
                alertController.addAction(cancelAction)
                
                let UndoAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
                    self.swipeyRowView.backgroundColor = self.lightGreyColor
                    self.swipeyRowView.transform = CGAffineTransformMakeTranslation(0, -(self.swipeyRowView.frame.height))
                    self.message.frame.origin.x = 0
                    
                    UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.otherMessages.transform = CGAffineTransformMakeTranslation(0, 0)
                        self.swipeyRowView.transform = CGAffineTransformMakeTranslation(0, 0)
                        
                        
                        }) { (Bool) -> Void in
                            
                            self.resetMessage()
                    }
                }
                alertController.addAction(UndoAction)
                
                self.presentViewController(alertController, animated: true) { }
            }
            
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panGetsureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        
        let velocity = panGetsureRecognizer.velocityInView(view)
        
        if abs(velocity.x) > abs(velocity.y) {
            return true
        } else {
            return false
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer == edgeGesture {
            return true
        } else {
            return false
        }
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
            
//            print(messageMoved)
            self.scrollView.scrollEnabled = false
            
            switch messageMoved {
            case 60...220:
                leftIcon.image = UIImage(named: "archive_icon")
                leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved - 60), 0)
                swipeyRowView.backgroundColor = greenColor
                action = "Archive"
            case 220...view.frame.width:
                leftIcon.image = UIImage(named: "delete_icon")
                leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved - 60), 0)
                swipeyRowView.backgroundColor = orangeColor
                action = "Delete"
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
                action = "Postpone"
            case (view.frame.width * -1)...(-220):
                rightIcon.image = UIImage(named: "list_icon")
                rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat(messageMoved + 60), 0)
                swipeyRowView.backgroundColor = brownColor
                action = "List"
            default:
                return
            }
        }
        
        if sender.state == .Ended {
            
            self.scrollView.scrollEnabled = true
            
            switch action {
            case "Archive":
                if velocity > 0 {
                    
                    rightIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width
                        self.leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(self.view.frame.width - 60), 0)
                        self.leftIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.transform = CGAffineTransformMakeTranslation(0, -(self.swipeyRowView.frame.height))
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    resetMessage()
                }
            case "Delete":
                if velocity > 0 {
                    
                    rightIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width
                        self.leftIcon.transform = CGAffineTransformMakeTranslation(CGFloat(self.view.frame.width - 60), 0)
                        self.leftIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.transform = CGAffineTransformMakeTranslation(0, -(self.swipeyRowView.frame.height))
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    resetMessage()
                }
            case "Postpone":
                if velocity < 0 {
                    
                    leftIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width * -1
                        self.rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat((self.view.frame.width * -1) + 60), 0)
                        self.rightIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.rescheduleView.alpha = 1
                            })
                    }
                    
                } else {
                    resetMessage()
                }
            case "List":
                if velocity < 0 {
                    
                    leftIcon.alpha = 0
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        
                        self.message.frame.origin.x = self.view.frame.width * -1
                        self.rightIcon.transform = CGAffineTransformMakeTranslation(CGFloat((self.view.frame.width * -1) + 60), 0)
                        self.rightIcon.alpha = 0
                        
                        }) { (Bool) -> Void in
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                                
                                self.otherMessages.transform = CGAffineTransformMakeTranslation(0, -(self.swipeyRowView.frame.height))
                                
                                }) { (Bool) -> Void in
                            }
                    }
                    
                } else {
                    resetMessage()
                }
            case "":
                resetMessage()
            default:
                resetMessage()
            }
        }
    }
    
    @IBAction func cancelRescheduling(sender: UITapGestureRecognizer) {
        
        action = ""
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.rescheduleView.alpha = 0
        }
        
        delay(0.15) {
            self.resetMessage()
        }

    }
    
    @IBAction func tapRescheduleTime(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.rescheduleView.alpha = 0
        }
        
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            self.otherMessages.transform = CGAffineTransformMakeTranslation(0, -(self.swipeyRowView.frame.height))
            
            }) { (Bool) -> Void in
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
        }
    }
    
    func closeNav() {
        let closed = CGPoint(x: 0.0, y: 0.0)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            self.contentView.frame.origin = closed
            self.navOpen = false
            self.scrollView.scrollEnabled = true
            }) { (Bool) -> Void in
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

