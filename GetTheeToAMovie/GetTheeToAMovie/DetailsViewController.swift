//
//  DetailsViewController.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/29/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var labelWidget: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!

    
    var details: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = details.valueForKeyPath("title") as? String
        synopsisLabel.text = details.valueForKeyPath("synopsis") as? String
        
        let imgURL = (details.valueForKeyPath("posters.thumbnail")) as! String
        posterImage.setImageWithURL(NSURL(string: imgURL)!)

        synopsisLabel.sizeToFit()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
