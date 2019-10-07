//
//  News.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import RealmSwift

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

class News: Object, Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var selftext: String = ""
    @objc dynamic var _thumbnail: String? = nil
    
    var thumbnail: URL? {
        guard let thumb = _thumbnail else {
            return nil
        }
        
        return URL(string: thumb)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case selftext
        case _thumbnail = "thumbnail"
        case data
        case id
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.id = try data.decode(String.self, forKey: .id)
        self.title = try data.decode(String.self, forKey: .title)
        self.selftext = try data.decode(String.self, forKey: .selftext)
        if let _thumb = try data.decodeIfPresent(String.self, forKey: ._thumbnail), _thumb != "self", _thumb != "default" {
            self._thumbnail = _thumb
        }
    }
    
    
}
