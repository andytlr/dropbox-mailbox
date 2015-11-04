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
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
    }
    
    @IBAction func tapHamburger(sender: AnyObject) {
        let closed = CGPoint(x: 0.0, y: 0.0)
        let screenWidth = view.frame.width
        let openX = screenWidth - 52
        let open = CGPoint(x: openX, y: 0.0)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            if self.navOpen == false {
                self.contentView.frame.origin = open
                self.navOpen = true
                self.scrollView.scrollEnabled = false
            } else {
                self.contentView.frame.origin = closed
                self.navOpen = false
                self.scrollView.scrollEnabled = true
            }
            }) { (Bool) -> Void in
                // derp
        }
    }

    @IBAction func edgeSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        
    }
}

