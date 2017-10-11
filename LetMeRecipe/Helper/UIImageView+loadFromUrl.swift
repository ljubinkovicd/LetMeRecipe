//
//  UIImage+loadFromUrl.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/10/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    
    func loadFromUrl(url: URL) -> URLSessionDownloadTask {
        
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            
            if error == nil,
                let url = url,
                    let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            }
        })
        downloadTask.resume()
        
        return downloadTask
    }

}
