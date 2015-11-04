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
    
    @IBOutlet weak var getMeToZero: UIImageView!
    
    @IBOutlet weak var search: UIImageView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var otherMessages: UIImageView!
    
    var navOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
        
//        contentView.frame.origin.x += 30
    }
    
    func toggleNav() {
        let closed = CGPoint(x: 0.0, y: 0.0)
        let screenWidth = view.frame.width
        let openX = screenWidth - 52
        let open = CGPoint(x: openX, y: 0.0)
        
        func openNav() {
            self.contentView.frame.origin = open
            self.navOpen = true
            self.scrollView.scrollEnabled = false
        }
        
        func closeNav() {
            self.contentView.frame.origin = closed
            self.navOpen = false
            self.scrollView.scrollEnabled = true
        }
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            if self.navOpen == false {
                openNav()
            } else {
                closeNav()
            }
            }) { (Bool) -> Void in
                // derp
        }
    }
    
    @IBAction func tapHamburger(sender: AnyObject) {
        toggleNav()
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
//        let translation = sender.translationInView(view)
        let location = sender.locationInView(view)
        let velocity = sender.velocityInView(view).x
        
        print(velocity)
        
        if sender.state == .Began {
            
        }
        
        if sender.state == .Changed {
            contentView.frame.origin.x = location.x
        }
        
        if sender.state == .Ended {
            if velocity > 0 {
                toggleNav()
            } else {
                // close nav
            }
        }
    }

}

