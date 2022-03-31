//
//  HomeTableViewCell.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsArticleTitleLabel: UILabel!
    
    @IBOutlet weak var newsSummaryTextView: UITextView!
    
    @IBOutlet weak var newsPublishedTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

