//
//  MeduzaAPIRequest.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 07.03.2021.
//

import Foundation

class MeduzaAPIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension MeduzaAPIRequest: APIRequest {
    func execute(withCompletion completion: @escaping (Resource.ResourceType?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> Resource.ResourceType? {
        let decoder = JSONDecoder()
        let decodedResource = try? decoder.decode(Resource.ResourceType.self, from: data)
        return decodedResource
    }
}
