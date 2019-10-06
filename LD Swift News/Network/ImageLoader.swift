////
////  SequenceImageLoader.swift
////  LD Swift News
////
////  Created by Gaurav Parvadiya on 06/10/19.
////  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
////
//
import UIKit

class ImageLoaderManager {
    var cachedImages: [Int : UIImage] = [:]
    
    var tableView: UITableView!
    
    func loadImage(_ url: URL, indexPath: IndexPath) {
        let downloadTask:URLSessionDownloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            (location: URL?, response: URLResponse?, error: Error?) -> Void in
            if let location = location {
                if let data:Data = try? Data(contentsOf: location) {
                    if let image:UIImage = UIImage(data: data) {
                        self.cachedImages[indexPath.row] = image // Save into the cache
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.tableView.beginUpdates()
                            self.tableView.reloadRows(
                                at: [indexPath],
                                with: .fade)
                            self.tableView.endUpdates()
                        })
                    }
                }
            }
        })
        downloadTask.resume()
    }
}
