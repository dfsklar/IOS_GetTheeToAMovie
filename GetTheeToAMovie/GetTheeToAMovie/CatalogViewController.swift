//
//  ViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet weak var movieListTable: UITableView!
    
    @IBOutlet weak var prototypeMovieCard: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("catalog view did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

