//
//  ViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit
import AFNetworking

class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let igClientID = "d2f5486933b342db801303d699c76ecb"
    
    var photoList : NSArray = []
    
    @IBOutlet weak var prototypeMovieCard: CatalogCellViewTableViewCell!
    
    @IBOutlet weak var catalogTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.catalogTable.dataSource = self
        self.catalogTable.delegate = self
        
        self.catalogTable.rowHeight = 150

        // Do any additional setup after loading the view, typically from a nib.
        println("catalog view did load")
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(igClientID)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as! NSDictionary
            self.photoList = responseDict["data"] as! NSArray
            println("Async load good")
            self.catalogTable.reloadData()
        }
    }
    
    func tableView(catalogTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = catalogTable.dequeueReusableCellWithIdentifier("com.sklardevelopment.Cell", forIndexPath: indexPath) as! CatalogCellViewTableViewCell
        
        var igInfo : NSDictionary = self.photoList[indexPath.row] as! NSDictionary
        
        var imgURL = (igInfo.valueForKeyPath("images.thumbnail.url")) as! String
        
        println(imgURL)
        
        cell.imagewidget.setImageWithURL(NSURL(string: imgURL)!)
        
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

