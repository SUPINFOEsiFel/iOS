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
    
    @IBAction func ImageBron(sender: AnyObject) {
        self.GoToWebsite("39280/bron-lumiere-bron/detail");
    }
    
    @IBAction func ButtonBron(sender: UIButton) {
        self.GoToWebsite("39280/bron-lumiere-bron/detail");
    }
    
    @IBAction func ImageDali(sender: AnyObject) {
        self.GoToWebsite("36724/lyon/residence-etudiante-dali-ii-lyon-3.html");
    }
    
    @IBAction func ButtonDali(sender: UIButton) {
        self.GoToWebsite("36724/lyon/residence-etudiante-dali-ii-lyon-3.html");
    }
    
    @IBAction func ImageDufy(sender: AnyObject) {
        self.GoToWebsite("36853/lyon/residence-etudiante-dufy-villeurbanne.html");
    }
    
    @IBAction func ButtonDufy(sender: UIButton) {
        self.GoToWebsite("36853/lyon/residence-etudiante-dufy-villeurbanne.html");
    }
    
    @IBAction func ImageLouis(sender: AnyObject) {
        self.GoToWebsite("36770/lyon/residence-etudiante-saint-louis-lyon-7.html");
    }

    @IBAction func ButtonLouis(sender: UIButton) {
        self.GoToWebsite("36770/lyon/residence-etudiante-saint-louis-lyon-7.html");
    }
    
    func GoToWebsite(name: String){
        let base_url = "http://m.studelites.com/#!fr/residence/";
        let dest_url = NSURL(string: base_url + name);
        UIApplication.sharedApplication().openURL(dest_url!);
    }
}