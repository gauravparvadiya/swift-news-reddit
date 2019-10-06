//
//  NewsListTableViewCell.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 05/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var postImage: DerivedHeightImageView!
    
    static let nibName = "NewsListTableViewCell"
    static let identifier = "NewsListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postImage.image = nil // or set a placeholder image
    }
}
