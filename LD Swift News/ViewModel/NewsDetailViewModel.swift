//
//  NewsDetailViewModel.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class NewsDetailViewModel {
    
    let news: News
    let postImage: UIImage?
    
    init(news: News, postImage: UIImage?) {
        self.news = news
        self.postImage = postImage
    }
    
}
