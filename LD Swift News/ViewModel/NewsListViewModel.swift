//
//  NewsListViewModel.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya

protocol NewsListViewDelegate: class {
    func refreshList()
}

protocol NewsListCoordinatorDelegate: class {
    func showPost(news: News, postImage: UIImage?)
}

class NewsListViewModel {
    
    var news: [News]
    weak var newsListViewDelegate: NewsListViewDelegate?
    weak var newListCoordinatorDelegate: NewsListCoordinatorDelegate?
    
    init() {
        news = []
    }
    
    func fetchNews() {
        Network.request(.fetchNews, decodeType: NewsData.self, success: { newsResponse in
            print(newsResponse.news)
            self.news = newsResponse.news
            self.newsListViewDelegate?.refreshList()
        }, error: { error in
            
        }, failure: { error in
            
        }, completion: {
            
        })
    }
}
