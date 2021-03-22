//
//  APIResource.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 07.03.2021.
//

import Foundation

protocol APIResource {
    associatedtype ResourceType: Decodable
    var methodPath: String { get }
    var pageNumber: Int { get }
    var url: URL { get }
}
