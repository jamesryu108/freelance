//
//  Network.swift
//  Network
//
//  Created by James Ryu on 2021-09-01.
//

import Foundation

let userCache = NSCache<NSString, AnyObject>()

class FetchActivities {
    
    init() {
        
    }
    
    /// Fetch activities data from url using URLSession
    func getActivities(from url: URL, completion: @escaping (Activities?, URLResponse?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check if there will be an error while getting activities data. If there are no errors, you can get past the guard statement
            guard error == nil else {
                print("error: \(error?.localizedDescription)")
                return
            }

            do {
                
                // Try to serialize the JSON data
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any], let userDic = json as? [String: Any] {
                    
                    let userDetails: Activities? = Activities(dict: userDic)
                    
                    completion(userDetails,nil,nil)
                }
            } catch {
                completion(nil,nil,error)
            }
        }.resume()
    }
}

class UserData {
    
    /// Fetch activities data from url using URLSession
    func getUsers(from url: [String], completion: @escaping ([[String:Any]]?, URLResponse?, Error?) -> Void) {

        var urlStack: [[String:Any]] = []
        
        let group = DispatchGroup()
        
        for i in 0..<url.count {
        
            let fullURL = "https://qapital-ios-testtask.herokuapp.com/users/\(url[i])"
            
            if let cacheUser = userCache.object(forKey: fullURL as! NSString) as? Users {
                
                print("inside cache")
                
                let cache: [String:Any] = ["userId": cacheUser.userId!, "displayName": cacheUser.displayName!, "avatarUrl":cacheUser.avatarUrl!]
                
                urlStack.append(cache)
                
                continue;
            }
            
            group.enter()
            
            URLSession.shared.dataTask(with: URL(string: fullURL)!) { data, response, error in

                print("i: \(i)")
                print("url: \(url[i])")
                guard error == nil else {
                    print("error: \(error?.localizedDescription)")
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any], let userDic = json as? [String: Any] {

                        urlStack.append(userDic)
                        
                        userCache.setObject(Users(dict: userDic), forKey: fullURL as! NSString)
                        
                        group.leave()
                    }
                } catch {
                    completion(nil,nil,error)
                }

            }.resume()
        }
        
        group.notify(queue: .main) {
            
            print("urlstack: \(urlStack)")

            completion(urlStack,nil,nil)
        }
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
