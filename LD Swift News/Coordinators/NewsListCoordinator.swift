//
//  NewsListCoordinator.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailCoordinator {
    private let navigationController: UINavigationController
    private let news: News
    private let postImage: UIImage?
    private var viewController: NewsDetailViewController?
    
    init(navigationController: UINavigationController, news: News, postImage: UIImage?) {
        self.navigationController = navigationController
        self.news = news
        self.postImage = postImage
    }
    
    func start() {
        let viewModel = NewsDetailViewModel(news: news, postImage: postImage)
        let viewController = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        viewController.navigationItem.title = news.title
        self.viewController = viewController
        self.viewController?.viewModel = viewModel
        
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
