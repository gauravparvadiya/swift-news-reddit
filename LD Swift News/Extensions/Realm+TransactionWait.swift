//
//  Realm+TransactionWait.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    public func writeTransactionWait(_ block: @escaping (() -> Void)) {
        if self.isInWriteTransaction {
            DispatchQueue.main.async {
                self.writeTransactionWait(block)
            }
        }
        else {
            do {
                try self.write(block)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    public func performTransactionWait(_ block: @escaping () -> Void) {
        if self.isInWriteTransaction {
            DispatchQueue.main.async {
                self.performTransactionWait(block)
            }
        }
        else {
            block()
        }
    }
}
