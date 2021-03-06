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
    let baseImgUrl: String = "http://api.fel.asso.fr/upload/"
    
    func loadEvents(){
        var date = NSDate()
        
        var urlString = "http://api.fel.asso.fr/api/events" // Your Normal URL String
        var url = NSURL(string: urlString)// Creating URL
        var request = NSURLRequest(URL: url!) // Creating Http Request
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
        var error: AutoreleasingUnsafeMutablePointer<NSErrorPointer?> = nil;
        
        // Sending Synchronous request using NSURLConnection
        var responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: response, error:nil) as NSData?
        
        if error != nil{
            var event_error = EventFel(id: "error", title: "Erreur", date: date.description , content: "Impossible de se connecter au serveur", image: UIImage(named: "logo_fel")!);
            arrayOfEvent.append(event_error);
        }else if(responseData != nil){
            let json = JSON(data: responseData!)
            var i: Int = 0
            if(json["events"].count == 0){
                var event_void = EventFel(id: "error", title: "Aucun evenements", date: date.description , content: "Il n'y a actuellement aucun evenement prevu", image: UIImage(named: "logo_fel")!)
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
                var nsdate = dateFormatter.dateFromString(event_void.date)
                dateFormatter.dateFormat = "EEEE d MMMM HH:mm"
                var final_date_string = dateFormatter.stringFromDate(nsdate!)
                event_void.date = final_date_string
                arrayOfEvent.append(event_void)
            }else{
                for i in 0..<json["events"].count{      //Parsing du JSON avec SwiftyJSON
                    var new_event = EventFel(id: "1", title: "Test", date: date.description , content: "Test content", image: UIImage(named: "logo_fel")!)
                    if let name = json["events"][i]["name"].string{
                        new_event.title = name
                    }
                    if let content = json["events"][i]["comment"].string{
                        new_event.content = content
                    }
                    if let date = json["events"][i]["begin"].string{
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
                        var nsdate = dateFormatter.dateFromString(date)
                        
                        dateFormatter.dateFormat = "EEEE d MMMM HH:mm"
                        var final_date_string = dateFormatter.stringFromDate(nsdate!)
                        new_event.date = final_date_string
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
            }
        }else{
            var event_error = EventFel(id: "error", title: "Erreur", date: date.description , content: "Impossible de se connecter au serveur", image: UIImage(named: "logo_fel")!)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            var nsdate = dateFormatter.dateFromString(event_error.date)
            
            dateFormatter.dateFormat = "EEEE d MMMM HH:mm"
            var final_date_string = dateFormatter.stringFromDate(nsdate!)
            event_error.date = final_date_string
            arrayOfEvent.append(event_error)
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