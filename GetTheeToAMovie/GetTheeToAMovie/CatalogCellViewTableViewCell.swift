//
//  CatalogCellViewTableViewCell.swift
//  GetTheeToAMovie
//
//  Created by David Sklar on 8/26/15.
//  Copyright (c) 2015 David Sklar. All rights reserved.
//

import UIKit

class CatalogCellViewTableViewCell: UITableViewCell {

    @IBOutlet weak var imagewidget: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
