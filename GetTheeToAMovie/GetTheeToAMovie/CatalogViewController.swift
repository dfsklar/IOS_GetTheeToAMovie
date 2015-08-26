//
//  ViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    let igClientID = "d2f5486933b342db801303d699c76ecb"
    
    var photoList : NSArray = []

    @IBOutlet weak var movieListTable: UITableView!
    
    @IBOutlet weak var prototypeMovieCard: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        println("catalog view did load")
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(igClientID)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as! NSDictionary
            self.photoList = responseDict["data"] as! NSArray
            self.movieListTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

