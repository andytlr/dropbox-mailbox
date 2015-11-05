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
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var otherMessages: UIImageView!
    
    var navOpen: Bool = false
    
    let scrollTo: CGPoint = CGPoint(x: 0, y: 79)

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

