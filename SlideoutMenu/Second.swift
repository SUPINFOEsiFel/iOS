//
//  Second.swift
//  SlideoutMenu
//
//  Created by Jared Davidson on 4/8/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import Foundation
class Second : UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    @IBAction func OnImageClick(sender: AnyObject) {
        let testUrl = NSURL(string: "http://www.studelites.com/fr/lyon/");
        UIApplication.sharedApplication().openURL(testUrl!);
    }
}