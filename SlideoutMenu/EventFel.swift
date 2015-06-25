//
//  EventFel.swift
//  SlideoutMenu
//
//  Created by Aria Company on 25/06/2015.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import Foundation
import UIKit

class EventFel{
    var title : String = "Title"
    var date : String = NSDate().description
    var content = "Test content"
    var image : UIImage
    var id : String = ""
    
    init(id: String, title: String, date: String, content: String, image: UIImage){
        self.title = title;
        self.date = date;
        self.content = content;
        self.image = image;
        self.id = id;
    }
    
}
