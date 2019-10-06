//
//  News.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation

struct NewsData: Decodable {
    
    let news: [News]
    
    enum CodingKeys: String, CodingKey {
        case parentData = "data"
        case news = "children"
    }
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let parentData = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .parentData)
        self.news = try parentData.decode([News].self, forKey: .news)
    }
}

struct News: Decodable {
    let title: String
    let selftext: String
    let thumbnail: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case selftext
        case thumbnail
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.title = try data.decode(String.self, forKey: .title)
        self.selftext = try data.decode(String.self, forKey: .selftext)
        if let _thumbnail = try data.decodeIfPresent(String.self, forKey: .thumbnail), _thumbnail != "self", _thumbnail != "default", let thumbURL = URL(string: _thumbnail) {
            self.thumbnail = thumbURL
            
        } else {
            self.thumbnail = nil
        }
    }
}
