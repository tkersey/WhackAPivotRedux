import UIKit

struct Network: NetworkType {
    func request(with url: URL, success: @escaping ([String:AnyObject]?) -> Void, failure: @escaping (Error) -> Void) {
        URLSession().dataTask(with: url) { data, urlResponse, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject]
                    success(json)
                } catch {
                   let error = NSError(domain: "WhatAPivotNetwork", code: 0, userInfo: [:])
                    failure(error)
                }
            } else if let error = error {
                failure(error)
            }
        }.resume()
    }
}
