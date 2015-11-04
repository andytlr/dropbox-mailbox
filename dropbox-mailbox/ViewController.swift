//
//  ViewController.swift
//  dropbox-mailbox
//
//  Created by Andy Taylor on 11/3/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var getMeToZero: UIImageView!
    
    @IBOutlet weak var search: UIImageView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var otherMessages: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize.width = otherMessages.frame.width
        scrollView.contentSize.height = otherMessages.frame.height + message.frame.height + search.frame.height + search.frame.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

