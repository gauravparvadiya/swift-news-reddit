//
//  NewsAPIRepository.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation

class NewsAPIRepository {
    
    func fetchNews(completion: @escaping ([News]) -> Void, error: @escaping (String) -> Void) {
        Network.request(.fetchNews, decodeType: NewsData.self, success: { newsResponse in
            completion(newsResponse.news)
        }, error: { errorMessage in
            error(errorMessage)
        }, failure: { errorMessage in
            error(errorMessage.localizedDescription)
        }, completion: {
            //
        })
    }
}
