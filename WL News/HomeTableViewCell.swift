//
//  HomeTableViewCell.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //****** All the object library *******
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsArticleTitleLabel: UILabel!
    
    @IBOutlet weak var newsSummaryTextView: UITextView!
    
    @IBOutlet weak var newsPublishedTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}

