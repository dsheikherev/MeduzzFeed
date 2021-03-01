//
//  NewsFeedTableView.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

protocol NewsFeedTableView: BaseView {
    
    var onArticleSelected: ( (Article) -> () )? { get set }
}
