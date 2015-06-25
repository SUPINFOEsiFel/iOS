//
//  CustomCell.swift
//  SlideoutMenu
//
//  Created by Aria Company on 25/06/2015.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    /*@IBOutlet weak var ImageEvent: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Description: UILabel!*/
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
    
    func setCell(title: String, content: String, image: UIImage, date: String){
        /*self.Title.text = title;
        self.Description.text = content;
        self.ImageEvent.image = image;
        self.Date.text = date;*/
    }
}
