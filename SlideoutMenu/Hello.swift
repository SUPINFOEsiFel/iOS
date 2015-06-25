//
//  Hello.swift
//  SlideoutMenu
//
//  Created by Jared Davidson on 4/8/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import Foundation

class Hello : UIViewController{
    
    
    @IBOutlet weak var MyTableView: UITableView!
    var arrayOfEvent: [EventFel] = [EventFel]()
    let baseImgUrl: String = "http://37.187.245.237/upload/"
    
    func loadEvents(){
        var date = NSDate()
        
        var urlString = "http://37.187.245.237/api/events" // Your Normal URL String
        var url = NSURL(string: urlString)// Creating URL
        var request = NSURLRequest(URL: url!) // Creating Http Request
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
        var error: AutoreleasingUnsafeMutablePointer<NSErrorPointer?> = nil;
        
        // Sending Synchronous request using NSURLConnection
        var responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: response, error:nil) as NSData?
        
        if error != nil{
            var event_error = EventFel(id: "error", title: "Erreur", date: date.description , content: "Impossible de se connecter au serveur", image: UIImage());
            arrayOfEvent.append(event_error);
        }else if(responseData != nil){
            let json = JSON(data: responseData!)
            var i: Int = 0
            //var test: Int =
            for i in 0..<json["events"].count{      //Parsing du JSON avec SwiftyJSON
                var new_event = EventFel(id: "1", title: "Test", date: date.description , content: "Test content", image: UIImage());
                if let name = json["events"][i]["name"].string{
                    new_event.title = name
                }
                if let content = json["events"][i]["comment"].string{
                    new_event.content = content
                }
                if let date = json["events"][i]["begin"].string{
                    new_event.date = date
                }
                if let id = json["events"][i]["_id"].string{
                    new_event.id = id
                    var imageUrl = self.baseImgUrl + id;
                    if let ext = json["events"][i]["imageExtension"].string{
                        imageUrl += ext
                    }else{
                        imageUrl += ".png"
                    }
                    let url = NSURL(string: imageUrl)
                    if let data = NSData(contentsOfURL: url!){
                        var image = UIImage(data: data)
                        new_event.image = image!
                    }
                }
                arrayOfEvent.append(new_event)
            }
        }else{
            var event_error = EventFel(id: "error", title: "Erreur", date: date.description , content: "Impossible de se connecter au serveur", image: UIImage());
            arrayOfEvent.append(event_error);
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEvent.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as CustomCell;
        
        let event = arrayOfEvent[indexPath.row];
        cell.setCell(event.title, content: event.content, image: event.image, date: event.date)
        
        return cell;
    }
    
    /*func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        let event = arrayOfEvent[indexPath.row];
        var NewViewController: DetailledViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailledViewController") as DetailledViewController;
        NewViewController.id = event.id;
        self.presentViewController(NewViewController, animated: true, completion: nil);
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEvents()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}