//
//  RealmManager.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManager {
    static let shared = RealmManager()
    private init() { }
    
    internal var realm: Realm {
        do {
            return try Realm()
        }
        catch let e {
            print(e.localizedDescription)
            
            do {
                try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            }
            catch let e {
                print("%@", getVaList([e.localizedDescription]))
            }
        }
        
        do {
            return try Realm()
        }
        catch let e {
            print(e.localizedDescription)
            fatalError()
        }
    }
    
    var isInWriteTransaction: Bool {
        return realm.isInWriteTransaction
    }
}

extension RealmManager {
    func storeNews(_ news: [News]) {
        realm.writeTransactionWait {
            self.realm.add(news, update: .all)
        }
    }
    
    func getNews() -> Results<News> {
        return realm.objects(News.self)
    }
}
