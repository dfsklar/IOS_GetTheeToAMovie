//
//  ViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftLoader

class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var DisplayError: UIView!
    
    var refreshControl: UIRefreshControl!
    
    var movieList : NSArray = []
    
    @IBOutlet weak var prototypeMovieCard: CatalogCellViewTableViewCell!
    
    @IBOutlet weak var catalogTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.catalogTable.dataSource = self
        self.catalogTable.delegate = self
        
        // Let's use fixed-height approach
        self.catalogTable.rowHeight = 120
        
        // Set up "refresh list via swipe gesture" behavior
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:"onRefresh", forControlEvents:UIControlEvents.ValueChanged)
        catalogTable.insertSubview(refreshControl, atIndex: 0)
        
        self.reloadCatalogFromDataSource(true)
    }
    
    
    func reloadCatalogFromDataSource(boolIsVeryFirstLoad: Bool) {
    
        // Access static cached data simulating the RottenTom API
        let cachedDataUrlString = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"

        // Do any additional setup after loading the view, typically from a nib.
        var url = NSURL(string: cachedDataUrlString)!
        var request = NSURLRequest(URL: url)
        DisplayError.hidden = true
        if boolIsVeryFirstLoad { SwiftLoader.show(title: "Loading...", animated: true) }
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if let boolDidError = error {
              self.DisplayError.hidden = false
            } else {
              if let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? NSDictionary {
                if let findMoviesObj = responseDict["movies"] as? NSArray {
                   self.movieList = findMoviesObj
                   self.catalogTable.reloadData()
                }
              }
              // We may have experienced a failure regarding the JSON's structure.
              // Let's detect that and if so, let's just show the Network Error box for now...
                if self.movieList.count < 1 {
                    self.DisplayError.hidden = false
                }
            }
            SwiftLoader.hide()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    
    func onRefresh() {
        self.reloadCatalogFromDataSource(false)
    }
    
    
    
    
    // Set up the look of a particular allocated cell in the table, to show a particular movie in the catalog
    func tableView(catalogTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = catalogTable.dequeueReusableCellWithIdentifier("com.sklardevelopment.moviecatalog.cell", forIndexPath: indexPath) as! CatalogCellViewTableViewCell
        
        var igInfo : NSDictionary = self.movieList[indexPath.row] as! NSDictionary
        
        var imgURL = (igInfo.valueForKeyPath("posters.thumbnail")) as! String
        
        cell.imagewidget.setImageWithURL(NSURL(string: imgURL)!)
        cell.descriptionLabel.text =  (igInfo.valueForKeyPath("synopsis")) as? String
        cell.titleLabel.text = (igInfo.valueForKeyPath("title")) as? String
        
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
        
        // Deselect the cell that was touched so upon return we have a  clean slate
        catalogTable.deselectRowAtIndexPath(indexPathSelectedCell, animated:false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

