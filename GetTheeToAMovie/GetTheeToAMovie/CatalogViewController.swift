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
    
    var movieList : NSArray = []
    
    @IBOutlet weak var prototypeMovieCard: CatalogCellViewTableViewCell!
    
    @IBOutlet weak var catalogTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.catalogTable.dataSource = self
        self.catalogTable.delegate = self
        
        self.catalogTable.rowHeight = 120
        
        // Access static cached data simulating the RottenTom API
        let cachedDataUrlString = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"

        // Do any additional setup after loading the view, typically from a nib.
        println("catalog view did load")
        var url = NSURL(string: cachedDataUrlString)!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as! NSDictionary
            self.movieList = responseDict["movies"] as! NSArray
            println("Async load good")
            self.catalogTable.reloadData()
        }
    }
    
    
    // Set up the look of a particular allocated cell in the table, to show a particular movie in the catalog
    func tableView(catalogTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = catalogTable.dequeueReusableCellWithIdentifier("com.sklardevelopment.moviecatalog.cell", forIndexPath: indexPath) as! CatalogCellViewTableViewCell
        
        var igInfo : NSDictionary = self.movieList[indexPath.row] as! NSDictionary
        
        var imgURL = (igInfo.valueForKeyPath("posters.thumbnail")) as! String
        
        println(imgURL)
        
        cell.imagewidget.setImageWithURL(NSURL(string: imgURL)!)
        cell.descriptionLabel.text =  (igInfo.valueForKeyPath("synopsis")) as? String
        cell.titleLabel.text = (igInfo.valueForKeyPath("title")) as? String
        
        //let cityState = data[indexPath.row].componentsSeparatedByString(", ")
        //cell.cityLabel.text = cityState.first
        //cell.stateLabel.text = cityState.last
        return cell
    }
    
    // Determine how many cells are needed for the current movie collection
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPathSelectedCell = catalogTable.indexPathForCell(cell)!
        let detailsDict = movieList[indexPathSelectedCell.row] as! NSDictionary
        let destinationViewC = segue.destinationViewController as! DetailsViewController
        destinationViewC.details = detailsDict
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

