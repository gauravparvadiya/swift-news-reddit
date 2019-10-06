//
//  ViewController.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var imageLoader: ImageLoaderManager!
    
    var viewModel: NewsListViewModel! {
        didSet {
            viewModel.newsListViewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchNews()
    }
    
    fileprivate func setupUI() {
        tableView.register(UINib(nibName: NewsListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView.estimatedRowHeight = 250 // match your tallest cell
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        imageLoader = ImageLoaderManager()
        imageLoader.tableView = self.tableView
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let news = viewModel.news[indexPath.row]
        cell.lblTitle.text = news.title
        if let url = news.thumbnail {
            if let image = imageLoader.cachedImages[indexPath.row] {
                cell.postImage.image = image
            } else {
                imageLoader.loadImage(url, indexPath: indexPath)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.newListCoordinatorDelegate?.showPost(news: viewModel.news[indexPath.row], postImage: imageLoader.cachedImages[indexPath.row])
    }
}

extension NewsListViewController: NewsListViewDelegate {
    func refreshList() {
        self.tableView.reloadData()
    }
}
