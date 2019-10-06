//
//  AppCoordinator.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow
    let rootViewController: NewsListViewController
    let storyboard: UIStoryboard
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        storyboard = UIStoryboard(name: "News", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        rootViewController = initialViewController
        
        navigationController = UINavigationController()
    }

    func start() {
        navigationController.navigationBar.prefersLargeTitles = true

        let viewModel = NewsListViewModel()
        viewModel.newListCoordinatorDelegate = self
        rootViewController.viewModel = viewModel
        rootViewController.navigationItem.title = "Swift News"

        navigationController.viewControllers = [rootViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: NewsListCoordinatorDelegate {
    func showPost(news: News, postImage: UIImage?) {
        print(news)
        let coordinator = NewsDetailCoordinator(navigationController: navigationController, news: news, postImage: postImage)
        coordinator.start()
    }
}
