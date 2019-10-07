//
//  NewsListViewModel.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya
import RealmSwift

protocol NewsListViewDelegate: class {
    func refreshList()
}

protocol NewsListCoordinatorDelegate: class {
    func showPost(news: News, postImage: UIImage?)
}

class NewsListViewModel {
    
    var news: Results<News>
    weak var newsListViewDelegate: NewsListViewDelegate?
    weak var newListCoordinatorDelegate: NewsListCoordinatorDelegate?
    var apiRepo: NewsAPIRepository
    
    var newsNotificationToken: NotificationToken?
    
    init() {
        news = RealmManager.shared.getNews()
        let repo = NewsAPIRepository()
        apiRepo = repo
        fetchNews()
        
        observeNews()
    }
    
    func fetchNews() {
        apiRepo.fetchNews(completion: { news in
            RealmManager.shared.storeNews(news)
        }) { errorMessage in
            print(errorMessage)
        }
    }
    
    private func observeNews() {
        if let allNewsToken = newsNotificationToken {
            allNewsToken.invalidate()
        }
        
        newsNotificationToken = news.observe { changes in
            switch changes {
            case .initial: return
            case .update:
                self.newsListViewDelegate?.refreshList()
            case .error: break
            }
        }
    }
}
