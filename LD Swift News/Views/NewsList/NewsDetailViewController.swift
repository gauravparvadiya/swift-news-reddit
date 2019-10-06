//
//  NewsDetailViewController.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    
    @IBOutlet weak var postImageView: DerivedHeightImageView!
    @IBOutlet weak var lblPostBody: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var viewModel: NewsDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        lblTitle.text = viewModel.news.title
        lblPostBody.text = viewModel.news.selftext
        if let image = viewModel.postImage {
            postImageView.image = image
        }
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
