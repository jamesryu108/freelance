//
//  UIImageView.swift
//  UIImageView
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

/// Used to cache images downloaded from the web
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    /// Loading post image to the cache from your Firebase server.
    func loadImageToTheCache(_ imageName: String) {
        
        self.image = nil
        
        // Checking cache for image
        
        if let cacheImage = imageCache.object(forKey: imageName as NSString) as? UIImage {
            self.image = cacheImage
            return
        }

        DownloadImage().getImage(from: URL(string: imageName)!) { data, urlResponse, error in
            
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    imageCache.setObject(downloadedImage, forKey: imageName as! NSString)
                    
                    self.image = downloadedImage
                }
            }
        }
    }
}
