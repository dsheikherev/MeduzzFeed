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
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(value)
            }
        }
        dataTask.resume()
    }
}
