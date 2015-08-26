//
//  ViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController, UITableViewDataSource {
    
    let igClientID = "d2f5486933b342db801303d699c76ecb"
    
    var photoList : NSArray = []
    
    @IBOutlet weak var prototypeMovieCard: UITableViewCell!
    
    @IBOutlet weak var catalogTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.catalogTable.dataSource = self
        //self.catalogTable.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
        println("catalog view did load")
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(igClientID)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as! NSDictionary
            self.photoList = responseDict["data"] as! NSArray
            println("Loaded good")
            self.catalogTable.reloadData()
        }
    }
    
    func tableView(catalogTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = catalogTable.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        //let cityState = data[indexPath.row].componentsSeparatedByString(", ")
        //cell.cityLabel.text = cityState.first
        //cell.stateLabel.text = cityState.last
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

