//
//  APIRequest.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 07.03.2021.
//

import Foundation

protocol APIRequest: AnyObject {
    associatedtype ResourceType
    
    func decode(_ data: Data) -> ResourceType?
    func execute(withCompletion completion: @escaping (ResourceType?) -> Void)
}

extension APIRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ResourceType?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) -> Void in
            
            guard let self = self else { return }
            
            if let error = error {
                completion(nil)
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(nil)
                return
            }
            
            if let data = data {
                if let value = self.decode(data) {
                    DispatchQueue.main.async {
                        completion(value)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
