//
//  NSObjectExtension.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
