//
//  Network.swift
//  Network
//
//  Created by James Ryu on 2021-09-01.
//

import Foundation

class FetchActivities {
    
    init() {
        
    }
    
    /// Fetch activities data from url using URLSession
    func getActivities(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

class FetchUsers {

    init() {
        
    }
    
    /// Fetch activities data from url using URLSession
    func getActivities(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

class DownloadImage {
    
    init() {
        
    }
    
    /// Fetch image from the url with URLSession
    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
                
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
