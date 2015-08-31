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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionRichText: UITextView!
    
    
    // A brilliant HTML-to-attributedstring utility, from:
    // http://stackoverflow.com/questions/27164928/create-an-attributed-string-out-of-plain-android-formated-text-in-swift-for-io
    func convertText(inputText: String) -> NSAttributedString {
        
        var html = inputText
        
        // Replace newline character by HTML line break
        while let range = html.rangeOfString("\n") {
            html.replaceRange(range, with: "<br />")
        }
        
        // Embed in a <span> to facilitate control over  font attributes:
        html = "<span style=\"font-family: Helvetica; font-size:11pt; color:white \">" + html + "</span>"
        
        let data = html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!
        let attrStr = NSAttributedString(
            data: data,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil,
            error: nil)!
        return attrStr
    }

    
    var details: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = details.valueForKeyPath("title") as? String
        
        //let richSynopsis = "<b>" + (details.valueForKeyPath("mpaa_rating") as! String) + "</b>"
        
        let strRating = details.valueForKeyPath("mpaa_rating") as! String
        let intYear = (details.valueForKeyPath("year") as! Int)
        let synopsis = details.valueForKeyPath("synopsis") as! String
        
        let richSynopsis = "<b>\(strRating)</b>, <b>\(intYear)</b><br/>\(synopsis)"
        
        descriptionRichText.textStorage.setAttributedString(convertText(richSynopsis))
        
        var imgURL = (details.valueForKeyPath("posters.thumbnail")) as! String
        
        // 1: Show the low-res image since it's already in cache and will load immediately
        posterImage.setImageWithURL(NSURL(string: imgURL)!)

        // 2: Hack the URL to obtain the high-res image
        var range = imgURL.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
          imgURL = imgURL.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        posterImage.setImageWithURL(NSURL(string: imgURL)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
